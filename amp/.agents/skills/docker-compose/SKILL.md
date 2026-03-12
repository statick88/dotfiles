---
name: docker-compose
description: >
  Docker & Container orchestration patterns with docker-compose and Kubernetes basics.
  Trigger: When containerizing applications, setting up docker-compose, or deploying to Kubernetes.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Docker Best Practices

```dockerfile
# ✅ Multi-stage builds for smaller images
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
EXPOSE 3000
CMD ["node", "dist/server.js"]

# ✅ Layer caching: Put expensive operations last
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "main.py"]

# ✅ Non-root user for security
FROM node:20-alpine
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs
WORKDIR /app
COPY --chown=nodejs:nodejs . .
CMD ["node", "server.js"]

# ❌ NEVER: Run as root, large images, multiple processes
FROM ubuntu:latest       # Bloated
RUN apt-get install ... # Cache busting
```

## Docker Compose Setup (Most Common)

```yaml
version: "3.9"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: myapp
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./src:/app/src:ro
    networks:
      - app-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

  db:
    image: postgres:16-alpine
    container_name: myapp-db
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=securepass
      - POSTGRES_DB=mydb
    volumes:
      - db-data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    networks:
      - app-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: myapp-redis
    ports:
      - "6379:6379"
    networks:
      - app-network
    restart: unless-stopped
    command: redis-server --requirepass redispass

volumes:
  db-data:

networks:
  app-network:
    driver: bridge
```

## Environment Configuration

```yaml
# ✅ Use .env files for secrets
services:
  app:
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - API_KEY=${API_KEY}
      - NODE_ENV=${NODE_ENV:-development}

# .env (never commit!)
DATABASE_URL=postgresql://user:pass@db:5432/mydb
API_KEY=sk-1234567890
NODE_ENV=production
```

## Common Service Patterns

```yaml
# Express/Node.js
app:
  build: .
  ports:
    - "3000:3000"
  environment:
    - PORT=3000
  depends_on:
    - db

# Django
django:
  build: .
  command: python manage.py runserver 0.0.0.0:8000
  ports:
    - "8000:8000"
  environment:
    - DEBUG=True
  volumes:
    - .:/code
  depends_on:
    - db

# FastAPI
fastapi:
  build: .
  command: uvicorn main:app --host 0.0.0.0 --reload
  ports:
    - "8000:8000"
  volumes:
    - ./app:/app/app
  environment:
    - DATABASE_URL=postgresql://user:pass@db:5432/mydb
```

## Development vs Production

```yaml
# docker-compose.yml (base)
version: "3.9"
services:
  app:
    build: .
    ports:
      - "3000:3000"
  db:
    image: postgres:16-alpine

# docker-compose.dev.yml (development - extends)
services:
  app:
    environment:
      - DEBUG=True
    volumes:
      - ./src:/app/src
    command: npm run dev

# docker-compose.prod.yml (production)
services:
  app:
    restart: always
    environment:
      - NODE_ENV=production
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]

# Run with override
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

## Common Docker Compose Commands

```bash
# Build and start services
docker-compose up -d

# View running containers
docker-compose ps

# View logs
docker-compose logs -f app

# Execute command in running container
docker-compose exec app npm run build

# Stop services
docker-compose down

# Remove volumes (data loss!)
docker-compose down -v

# Rebuild images
docker-compose build --no-cache

# Update single service
docker-compose up -d --no-deps --build app
```

## Networking

```yaml
# ✅ Services communicate via service name
services:
  app:
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
      # NOT: localhost:5432 - that's inside app container

  db:
    container_name: myapp-db  # Hostname for app service
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

## Volumes & Data Persistence

```yaml
# ✅ Named volumes for databases
volumes:
  db-data:

services:
  db:
    volumes:
      - db-data:/var/lib/postgresql/data

# ✅ Bind mounts for development
services:
  app:
    volumes:
      - ./src:/app/src:ro          # Read-only for source
      - ./config:/app/config:rw    # Read-write for config

# Commands
docker-compose volume ls
docker-compose volume rm myapp_db-data
```

## Health Checks

```yaml
# ✅ Database health check
db:
  image: postgres:16-alpine
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U user -d mydb"]
    interval: 10s
    timeout: 5s
    retries: 5
    start_period: 20s

# ✅ Web service health check
app:
  build: .
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
    interval: 30s
    timeout: 10s
    retries: 3
    start_period: 40s

# ✅ Redis health check
redis:
  image: redis:7-alpine
  healthcheck:
    test: ["CMD", "redis-cli", "ping"]
    interval: 5s
    timeout: 3s
    retries: 5
```

## Kubernetes Basics

```yaml
# deployment.yaml - For production at scale
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:1.0.0
        ports:
        - containerPort: 3000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: db-url
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10

---
# service.yaml - Expose deployment
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 3000
  type: LoadBalancer

---
# Secret for sensitive data
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
stringData:
  db-url: postgresql://user:pass@db:5432/mydb
  api-key: sk-1234567890
```

## Docker Compose to Kubernetes

```bash
# Convert docker-compose to k8s manifests
kompose convert -f docker-compose.yml -o k8s/

# Deploy to Kubernetes
kubectl apply -f k8s/

# View deployments
kubectl get deployments
kubectl get pods
kubectl get services

# View logs
kubectl logs -f deployment/myapp

# Scale deployment
kubectl scale deployment myapp --replicas=5

# Update image
kubectl set image deployment/myapp myapp=myapp:2.0.0
```

## Best Practices Checklist

- ✅ Use multi-stage builds for smaller images
- ✅ Layer caching: expensive operations last
- ✅ Run containers as non-root user
- ✅ Use Alpine images for smaller size
- ✅ Pin image versions (not `latest`)
- ✅ Use health checks for all services
- ✅ Named volumes for persistent data
- ✅ Separate development and production configs
- ✅ Use `depends_on` with `condition: service_healthy`
- ✅ Never commit `.env` files
- ✅ Use restart policies (`unless-stopped`)
- ✅ Implement proper logging
- ✅ Use resource limits (CPU, memory)
- ✅ Scan images for vulnerabilities

## Keywords
docker, docker-compose, containers, kubernetes, k8s, orchestration, devops, deployment, docker-build
