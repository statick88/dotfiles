---
name: api-design
description: >
  REST API design patterns and best practices.
  Trigger: When designing REST APIs, creating endpoints, or building API documentation.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Resource-Based Design

```typescript
// ✅ ALWAYS: Use nouns for resources, HTTP verbs for actions
GET    /api/v1/users           # List users
POST   /api/v1/users           # Create user
GET    /api/v1/users/:id       # Get user
PUT    /api/v1/users/:id       # Replace user
PATCH  /api/v1/users/:id       # Update user
DELETE /api/v1/users/:id       # Delete user

// ✅ Collection operations
GET    /api/v1/users?status=active       # Filter
GET    /api/v1/users?sort=-created_at    # Sort
GET    /api/v1/users?page=2&limit=20     # Pagination

// ✅ Nested resources
GET    /api/v1/users/:id/posts           # User's posts
POST   /api/v1/users/:id/posts           # Create post for user
GET    /api/v1/users/:id/posts/:postId   # Get specific post

// ❌ NEVER: Use verbs in URLs
POST   /api/v1/createUser              # NO!
GET    /api/v1/getUser                 # NO!
POST   /api/v1/updateUser/:id          # NO!
```

## Status Codes (REQUIRED)

```
Success:
✅ 200 OK              - GET, PUT, PATCH request succeeded
✅ 201 Created         - POST created resource
✅ 204 No Content      - DELETE succeeded, no body

Client Errors:
❌ 400 Bad Request     - Invalid syntax or validation failed
❌ 401 Unauthorized    - Missing/invalid authentication
❌ 403 Forbidden       - Authenticated but not authorized
❌ 404 Not Found       - Resource doesn't exist
❌ 409 Conflict        - Request conflicts (e.g., duplicate)
❌ 422 Unprocessable   - Validation failed (preferred for input)
❌ 429 Too Many        - Rate limit exceeded

Server Errors:
❌ 500 Internal Error  - Server error
❌ 503 Unavailable     - Server temporarily down
```

## Response Format (REQUIRED)

```typescript
// ✅ Success response
{
  "status": "success",
  "data": {
    "id": "123",
    "name": "John",
    "email": "john@example.com"
  },
  "timestamp": "2024-01-29T10:30:00Z"
}

// ✅ List response with pagination
{
  "status": "success",
  "data": [
    { "id": "1", "name": "User 1" },
    { "id": "2", "name": "User 2" }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "pages": 8
  },
  "timestamp": "2024-01-29T10:30:00Z"
}

// ✅ Error response
{
  "status": "error",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      { "field": "email", "message": "Invalid email format" }
    ]
  },
  "timestamp": "2024-01-29T10:30:00Z"
}

// ❌ NEVER: Unstructured responses
{ "message": "Success" }
{ "data": [...] }  // No status field
```

## Versioning

```
// ✅ URL versioning (preferred for API)
GET /api/v1/users
GET /api/v2/users

// ✅ Header versioning (for web clients)
Accept-Version: 2.0

// ❌ Query string (avoid)
GET /api/users?version=2
```

## Authentication & Authorization

```typescript
// ✅ Bearer token in Authorization header
Authorization: Bearer <token>

// ✅ Check at endpoint
export async function protectedRoute(req: NextRequest) {
  const authHeader = req.headers.get("authorization");
  const token = authHeader?.split(" ")[1];

  if (!token) {
    return NextResponse.json(
      { status: "error", error: { code: "MISSING_TOKEN" } },
      { status: 401 }
    );
  }

  // Validate token...
}

// ❌ NEVER: Token in URL
GET /api/users?token=123abc
```

## Rate Limiting

```typescript
// ✅ Communicate limits via headers
HTTP/1.1 200 OK
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 85
X-RateLimit-Reset: 1709116800

// ✅ Return 429 when exceeded
{
  "status": "error",
  "error": {
    "code": "RATE_LIMITED",
    "message": "Rate limit exceeded",
    "retryAfter": 60
  }
}
```

## CORS

```typescript
// ✅ Explicit origins in production
const ALLOWED_ORIGINS = [
  "https://yourdomain.com",
  "https://app.yourdomain.com"
];

export const corsHeaders = (origin: string) => ({
  "Access-Control-Allow-Origin": ALLOWED_ORIGINS.includes(origin) ? origin : "",
  "Access-Control-Allow-Methods": "GET, POST, PUT, PATCH, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization",
  "Access-Control-Max-Age": "86400"
});

// Handle OPTIONS preflight
export async function OPTIONS(request: NextRequest) {
  return new NextResponse(null, {
    status: 204,
    headers: corsHeaders(request.headers.get("origin") || "")
  });
}
```

## Documentation (OpenAPI/Swagger)

```yaml
openapi: 3.0.0
info:
  title: User API
  version: 1.0.0
  description: User management API

servers:
  - url: https://api.example.com/v1

paths:
  /users:
    get:
      summary: List users
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: Users list
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'
    post:
      summary: Create user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UserInput'
      responses:
        '201':
          description: User created
```

## Pagination Patterns

```typescript
// ✅ Cursor-based (for large datasets)
GET /api/v1/posts?limit=20&cursor=eyJpZCI6IjEyMyJ9

// ✅ Offset-based (common, simple)
GET /api/v1/users?page=2&limit=20

// ✅ Request
GET /api/v1/users?page=2&limit=20

// ✅ Response
{
  "status": "success",
  "data": [...],
  "pagination": {
    "page": 2,
    "limit": 20,
    "total": 150,
    "pages": 8,
    "nextCursor": "eyJpZCI6IjQ0In0"
  }
}
```

## Filtering & Searching

```typescript
// ✅ Query parameters for filters
GET /api/v1/users?status=active&role=admin&created_after=2024-01-01

// ✅ Full-text search
GET /api/v1/users?search=john

// ✅ Sorting
GET /api/v1/users?sort=-created_at,name

// ✅ Implementation example (Django DRF)
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filterset_fields = ["status", "role"]
    search_fields = ["name", "email"]
    ordering_fields = ["created_at", "name"]
    ordering = ["-created_at"]
```

## Error Handling

```typescript
// ✅ Consistent error structure
interface ApiError {
  status: "error";
  error: {
    code: string;           // Machine readable: VALIDATION_ERROR
    message: string;        // User friendly
    details?: {             // Optional detailed info
      [field: string]: string;
    };
  };
  timestamp: string;
}

// ✅ Common error codes
INVALID_REQUEST       - Malformed request
VALIDATION_ERROR      - Input validation failed
AUTHENTICATION_ERROR  - Invalid credentials
AUTHORIZATION_ERROR   - Access denied
NOT_FOUND            - Resource not found
CONFLICT             - Business logic conflict
INTERNAL_ERROR       - Server error
```

## Webhooks (Async Events)

```typescript
// ✅ Register webhook
POST /api/v1/webhooks
{
  "url": "https://yourapp.com/webhook",
  "events": ["user.created", "user.deleted"],
  "secret": "webhook_secret"
}

// ✅ Send webhook with signature
const signature = hmac("sha256", secret, JSON.stringify(payload));
POST https://yourapp.com/webhook
X-Webhook-Signature: sha256=<signature>
{
  "event": "user.created",
  "data": { "id": "123", "name": "John" },
  "timestamp": "2024-01-29T10:30:00Z"
}

// ✅ Verify webhook
import crypto from "crypto";

export function verifyWebhook(
  payload: string,
  signature: string,
  secret: string
): boolean {
  const expected = crypto
    .createHmac("sha256", secret)
    .update(payload)
    .digest("hex");
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(`sha256=${expected}`)
  );
}
```

## Best Practices Checklist

- ✅ Use HTTP verbs correctly (GET, POST, PUT, PATCH, DELETE)
- ✅ Use proper status codes (200, 201, 400, 401, 404, 500)
- ✅ Consistent response format with status field
- ✅ Version your API (/api/v1/)
- ✅ Use Bearer tokens for authentication
- ✅ Implement rate limiting
- ✅ Document with OpenAPI/Swagger
- ✅ Support pagination for lists
- ✅ Allow filtering and sorting
- ✅ Handle errors consistently
- ✅ Use HTTPS in production
- ✅ Implement CORS properly
- ✅ Return created resources (201 with body)

## Keywords
api, rest, design, patterns, rest-api, openapi, swagger, http-status, authentication, pagination
