---
name: fastapi-advanced
description: >
  Advanced FastAPI patterns: dependency injection, middleware, background tasks, and production patterns.
  Trigger: When building scalable FastAPI applications, adding complex features, or optimizing performance.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Dependency Injection (FastAPI's Superpower)

```python
# ✅ Basic dependency
from fastapi import FastAPI, Depends
from typing import Annotated

async def get_query_token(token: str) -> str:
    return token

@app.get("/items/")
async def read_items(token: Annotated[str, Depends(get_query_token)]):
    return {"token": token}

# ✅ Class-based dependencies
class CommonQueryParams:
    def __init__(self, skip: int = 0, limit: int = 10):
        self.skip = skip
        self.limit = limit

@app.get("/items/")
async def read_items(commons: Annotated[CommonQueryParams, Depends()]):
    return {"skip": commons.skip, "limit": commons.limit}

# ✅ Database session injection
from sqlalchemy.orm import Session

def get_db() -> Session:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/users/")
async def get_users(db: Annotated[Session, Depends(get_db)]):
    return db.query(User).all()

# ✅ Nested dependencies
async def verify_token(token: str) -> dict:
    if not token.startswith("Bearer "):
        raise HTTPException(status_code=401)
    return {"token": token[7:]}

async def get_current_user(
    credentials: Annotated[dict, Depends(verify_token)],
    db: Annotated[Session, Depends(get_db)]
) -> User:
    user = db.query(User).filter_by(token=credentials["token"]).first()
    if not user:
        raise HTTPException(status_code=401)
    return user

@app.get("/me/")
async def read_current_user(user: Annotated[User, Depends(get_current_user)]):
    return user
```

## Middleware & Lifecycle

```python
# ✅ Custom middleware for logging
from fastapi import Request
import time

@app.middleware("http")
async def log_requests(request: Request, call_next):
    start_time = time.time()
    
    response = await call_next(request)
    
    duration = time.time() - start_time
    response.headers["X-Process-Time"] = str(duration)
    
    print(f"{request.method} {request.url.path} - {response.status_code} - {duration:.3f}s")
    return response

# ✅ Request/response modification
@app.middleware("http")
async def add_cors_headers(request: Request, call_next):
    response = await call_next(request)
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    return response

# ✅ Exception handling
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request, exc):
    return JSONResponse(
        status_code=422,
        content={
            "status": "error",
            "code": "VALIDATION_ERROR",
            "details": exc.errors()
        }
    )

# ✅ Lifespan events
from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    print("Starting up...")
    db.connect()
    yield
    # Shutdown
    print("Shutting down...")
    db.disconnect()

app = FastAPI(lifespan=lifespan)
```

## Background Tasks & Async Patterns

```python
# ✅ Background tasks
from fastapi import BackgroundTasks

def send_email(email: str, message: str):
    # This runs in background
    time.sleep(2)
    print(f"Sending email to {email}")

@app.post("/send-notification/")
async def send_notification(
    email: str,
    background_tasks: BackgroundTasks
):
    background_tasks.add_task(send_email, email, "Hello!")
    return {"status": "Email will be sent in the background"}

# ✅ Multiple background tasks
@app.post("/process-data/")
async def process_data(data: dict, background_tasks: BackgroundTasks):
    background_tasks.add_task(validate_data, data)
    background_tasks.add_task(save_to_cache, data)
    background_tasks.add_task(send_notification, "Processing complete")
    return {"status": "Processing started"}

# ✅ Async functions (not I/O blocking)
async def process_file(file_path: str):
    async with aiofiles.open(file_path) as f:
        content = await f.read()
    return content

# ✅ Use Celery for long tasks
from celery import Celery

celery_app = Celery("tasks", broker="redis://localhost:6379")

@celery_app.task
def send_email_task(email: str):
    send_email(email)
    return f"Email sent to {email}"

@app.post("/send-email-celery/")
async def send_email_celery(email: str):
    task = send_email_task.delay(email)
    return {"task_id": task.id, "status": "Processing"}

@app.get("/task-status/{task_id}")
async def task_status(task_id: str):
    task = send_email_task.AsyncResult(task_id)
    return {"status": task.status, "result": task.result}
```

## Streaming Responses

```python
# ✅ Stream large files
from fastapi.responses import StreamingResponse

async def generate_large_file():
    for i in range(10000):
        yield f"data: {i}\n"

@app.get("/stream/")
async def stream_data():
    return StreamingResponse(
        generate_large_file(),
        media_type="text/event-stream"
    )

# ✅ File download with streaming
import io
from fastapi.responses import FileResponse

@app.get("/download/{file_id}")
async def download_file(file_id: str):
    file_path = f"/tmp/{file_id}.csv"
    return FileResponse(
        file_path,
        media_type="text/csv",
        filename=f"export_{file_id}.csv"
    )

# ✅ Generate CSV on-the-fly
async def generate_csv():
    # Write header
    yield "id,name,email\n"
    
    # Query and stream data
    users = db.query(User).all()
    for user in users:
        yield f"{user.id},{user.name},{user.email}\n"

@app.get("/export/users/")
async def export_users():
    return StreamingResponse(
        generate_csv(),
        media_type="text/csv",
        headers={"Content-Disposition": "attachment; filename=users.csv"}
    )
```

## Caching & Performance

```python
# ✅ HTTP caching headers
from fastapi import Header
from datetime import timedelta

@app.get("/items/{item_id}")
async def get_item(
    item_id: int,
    response: Response
):
    item = db.query(Item).get(item_id)
    
    # Cache for 1 hour
    response.headers["Cache-Control"] = "public, max-age=3600"
    response.headers["ETag"] = f'"{item.updated_at.timestamp()}"'
    
    return item

# ✅ Redis caching
import redis

redis_client = redis.Redis(host="localhost", port=6379)

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    # Check cache
    cached = redis_client.get(f"user:{user_id}")
    if cached:
        return json.loads(cached)
    
    # Database query
    user = db.query(User).get(user_id)
    
    # Store in cache for 1 hour
    redis_client.setex(
        f"user:{user_id}",
        3600,
        json.dumps(user.dict())
    )
    
    return user

# ✅ Query optimization
from sqlalchemy import joinedload

@app.get("/users/")
async def list_users(db: Session):
    # ✅ Eager load related data
    users = db.query(User).options(
        joinedload(User.posts),
        joinedload(User.comments)
    ).all()
    
    return users

# ❌ N+1 queries (slow)
users = db.query(User).all()
for user in users:
    posts = db.query(Post).filter_by(user_id=user.id).all()
```

## Validation & Serialization

```python
# ✅ Pydantic validation
from pydantic import BaseModel, Field, validator, field_validator

class UserCreate(BaseModel):
    email: str = Field(..., min_length=5, max_length=100)
    password: str = Field(..., min_length=8)
    age: int = Field(..., ge=0, le=150)
    
    @field_validator("email")
    @classmethod
    def validate_email(cls, v):
        if "@" not in v:
            raise ValueError("Invalid email")
        return v.lower()
    
    @field_validator("password")
    @classmethod
    def validate_password(cls, v):
        if not any(c.isupper() for c in v):
            raise ValueError("Password must contain uppercase")
        return v

# ✅ Custom response models
class UserResponse(BaseModel):
    id: int
    email: str
    created_at: datetime
    
    class Config:
        from_attributes = True  # For ORM objects

# ✅ Conditional fields
from typing import Optional

class ItemResponse(BaseModel):
    id: int
    name: str
    description: Optional[str] = None
    price: float
    
    # Hide sensitive fields
    class Config:
        fields = {"internal_id": {"exclude": True}}

@app.get("/items/{item_id}", response_model=ItemResponse)
async def get_item(item_id: int):
    return db.query(Item).get(item_id)
```

## Rate Limiting & Security

```python
# ✅ Rate limiting with slowapi
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.get("/items/")
@limiter.limit("100/minute")
async def list_items(request: Request):
    return {"items": []}

# ✅ JWT authentication
from fastapi.security import HTTPBearer, HTTPAuthCredentials
import jwt
from datetime import datetime, timedelta

security = HTTPBearer()
SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"

def create_access_token(data: dict, expires_in: int = 3600):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(seconds=expires_in)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

async def verify_token(credentials: HTTPAuthCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("sub")
        if user_id is None:
            raise HTTPException(status_code=401)
        return user_id
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401)

@app.post("/login")
async def login(credentials: dict):
    # Verify credentials
    user = authenticate_user(credentials["email"], credentials["password"])
    if not user:
        raise HTTPException(status_code=401)
    
    token = create_access_token({"sub": user.id})
    return {"access_token": token, "token_type": "bearer"}

@app.get("/me")
async def get_current_user(user_id: int = Depends(verify_token)):
    user = db.query(User).get(user_id)
    return user
```

## API Documentation & Testing

```python
# ✅ Enhanced OpenAPI schema
from fastapi.openapi.utils import get_openapi

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    
    openapi_schema = get_openapi(
        title="My API",
        version="1.0.0",
        description="Complete API with authentication",
        routes=app.routes,
    )
    
    openapi_schema["info"]["x-logo"] = {
        "url": "https://example.com/logo.png"
    }
    
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

# ✅ Testing with FastAPI TestClient
from fastapi.testclient import TestClient

client = TestClient(app)

def test_create_user():
    response = client.post(
        "/users/",
        json={"email": "test@example.com", "password": "Secure123!"}
    )
    assert response.status_code == 201
    assert response.json()["email"] == "test@example.com"

def test_unauthorized_access():
    response = client.get("/me")
    assert response.status_code == 401

def test_with_token():
    # Create user and get token
    response = client.post("/login", json={"email": "test@example.com", "password": "Secure123!"})
    token = response.json()["access_token"]
    
    # Use token
    headers = {"Authorization": f"Bearer {token}"}
    response = client.get("/me", headers=headers)
    assert response.status_code == 200
```

## Deployment Patterns

```python
# ✅ Environment configuration
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    database_url: str
    secret_key: str
    debug: bool = False
    redis_url: str = "redis://localhost:6379"
    
    class Config:
        env_file = ".env"
        case_sensitive = False

settings = Settings()

app = FastAPI(
    title="My API",
    debug=settings.debug,
    docs_url="/api/docs" if not settings.debug else "/docs",
    openapi_url="/api/openapi.json" if not settings.debug else "/openapi.json"
)

# ✅ Production middleware
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_origins.split(","),
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(
    TrustedHostMiddleware,
    allowed_hosts=settings.allowed_hosts.split(",")
)

# ✅ Health check for deployment
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "version": "1.0.0",
        "timestamp": datetime.utcnow()
    }
```

## Best Practices Checklist

- ✅ Use dependency injection for modularity
- ✅ Async everywhere (no blocking operations)
- ✅ Proper error handling with custom exceptions
- ✅ Pydantic for validation and serialization
- ✅ Cache frequently accessed data
- ✅ Use `joinedload` to avoid N+1 queries
- ✅ Implement rate limiting
- ✅ Use JWT for authentication
- ✅ Stream large files/responses
- ✅ Add health checks for monitoring
- ✅ Document with OpenAPI/Swagger
- ✅ Use background tasks for async work
- ✅ Test with TestClient
- ✅ Use environment variables for config

## Keywords
fastapi, python, async, dependency-injection, middleware, streaming, jwt, pydantic, performance
