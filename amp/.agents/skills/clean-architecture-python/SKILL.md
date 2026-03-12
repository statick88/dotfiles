---
name: clean-architecture-python
description: >
  Clean Architecture in Python: layered design with domain-driven development.
  Trigger: When designing Python applications, creating domain models, or organizing project structure.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Clean Architecture Layers (4-Layer Pattern)

```
┌─────────────────────────────────────────────────────┐
│  Presentation Layer (FastAPI/Django routes)         │  ← Frameworks & UI
├─────────────────────────────────────────────────────┤
│  Application Layer (Use Cases/Services)             │  ← Business Logic
├─────────────────────────────────────────────────────┤
│  Domain Layer (Entities, Value Objects)             │  ← Business Rules
├─────────────────────────────────────────────────────┤
│  Infrastructure Layer (DB, APIs, External Services) │  ← Details
└─────────────────────────────────────────────────────┘

Dependencies point INWARD only
```

## Project Structure (Recommended)

```
my_app/
├── domain/                    # Pure business logic (NO dependencies)
│   ├── __init__.py
│   ├── entities/
│   │   ├── __init__.py
│   │   ├── user.py            # Domain model
│   │   └── order.py
│   ├── repositories/
│   │   ├── __init__.py
│   │   └── user_repository.py # Abstract interface
│   └── exceptions.py          # Domain exceptions
│
├── application/               # Use cases (business workflows)
│   ├── __init__.py
│   ├── use_cases/
│   │   ├── __init__.py
│   │   ├── create_user.py
│   │   ├── get_user.py
│   │   └── list_users.py
│   ├── services/
│   │   ├── __init__.py
│   │   └── user_service.py    # Orchestrates domain
│   └── dtos/
│       ├── __init__.py
│       └── user_dto.py        # Data Transfer Objects
│
├── infrastructure/            # Implementation details
│   ├── __init__.py
│   ├── persistence/
│   │   ├── __init__.py
│   │   ├── user_repository.py # DB implementation
│   │   └── models.py          # SQLAlchemy/Django ORM
│   ├── external/
│   │   ├── __init__.py
│   │   └── email_service.py   # External APIs
│   └── config.py              # DB connections, settings
│
├── presentation/              # FastAPI/Django routes
│   ├── __init__.py
│   ├── api/
│   │   ├── __init__.py
│   │   └── users.py           # Route handlers
│   └── schemas.py             # Pydantic models
│
├── main.py                    # Application entry point
├── requirements.txt
└── .env
```

## Domain Layer (No External Dependencies)

```python
# domain/entities/user.py
from dataclasses import dataclass
from datetime import datetime

@dataclass
class User:
    """Pure business entity - NO database, NO frameworks"""
    id: str
    email: str
    name: str
    is_active: bool = True
    created_at: datetime = None
    
    def __post_init__(self):
        if self.created_at is None:
            self.created_at = datetime.now()
    
    def deactivate(self) -> None:
        """Business rule: deactivate user"""
        if not self.is_active:
            raise ValueError("User already inactive")
        self.is_active = False

# domain/exceptions.py
class DomainException(Exception):
    """Base exception for domain layer"""
    pass

class UserNotFound(DomainException):
    """User doesn't exist"""
    pass

class InvalidEmail(DomainException):
    """Email format is invalid"""
    pass
```

## Domain Repository Interface (Abstraction)

```python
# domain/repositories/user_repository.py
from abc import ABC, abstractmethod
from typing import List, Optional
from domain.entities.user import User

class UserRepository(ABC):
    """Abstract interface - implementation in infrastructure layer"""
    
    @abstractmethod
    async def save(self, user: User) -> None:
        """Save or update user"""
        pass
    
    @abstractmethod
    async def get_by_id(self, user_id: str) -> Optional[User]:
        """Get user by ID"""
        pass
    
    @abstractmethod
    async def get_by_email(self, email: str) -> Optional[User]:
        """Get user by email"""
        pass
    
    @abstractmethod
    async def list_all(self, skip: int = 0, limit: int = 10) -> List[User]:
        """List all users with pagination"""
        pass
    
    @abstractmethod
    async def delete(self, user_id: str) -> None:
        """Delete user"""
        pass
```

## Application Layer (Use Cases)

```python
# application/use_cases/create_user.py
from dataclasses import dataclass
from domain.entities.user import User
from domain.repositories.user_repository import UserRepository
from domain.exceptions import InvalidEmail, UserNotFound

@dataclass
class CreateUserRequest:
    """Input DTO"""
    email: str
    name: str

@dataclass
class CreateUserResponse:
    """Output DTO"""
    user_id: str
    email: str
    name: str

class CreateUserUseCase:
    """Orchestrates domain layer"""
    
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository
    
    async def execute(self, request: CreateUserRequest) -> CreateUserResponse:
        # Business logic: validate email
        if "@" not in request.email:
            raise InvalidEmail("Invalid email format")
        
        # Business logic: check if email exists
        existing = await self.user_repository.get_by_email(request.email)
        if existing:
            raise ValueError("Email already registered")
        
        # Create domain entity
        user = User(
            id=str(uuid4()),
            email=request.email.lower(),
            name=request.name
        )
        
        # Persist using repository
        await self.user_repository.save(user)
        
        # Return DTO
        return CreateUserResponse(
            user_id=user.id,
            email=user.email,
            name=user.name
        )

# application/services/user_service.py
from application.use_cases.create_user import CreateUserUseCase, CreateUserRequest
from infrastructure.persistence.user_repository import UserRepository

class UserService:
    """High-level service orchestrating use cases"""
    
    def __init__(self, repository: UserRepository):
        self.create_user_uc = CreateUserUseCase(repository)
        self.repository = repository
    
    async def create_user(self, email: str, name: str):
        request = CreateUserRequest(email=email, name=name)
        return await self.create_user_uc.execute(request)
    
    async def get_user(self, user_id: str):
        user = await self.repository.get_by_id(user_id)
        if not user:
            raise UserNotFound(f"User {user_id} not found")
        return user
```

## Infrastructure Layer (Implementations)

```python
# infrastructure/persistence/user_repository.py
from typing import Optional, List
from sqlalchemy.orm import Session
from domain.entities.user import User
from domain.repositories.user_repository import UserRepository as IUserRepository
from infrastructure.persistence.models import UserModel

class UserRepository(IUserRepository):
    """SQLAlchemy implementation of UserRepository"""
    
    def __init__(self, session: Session):
        self.session = session
    
    async def save(self, user: User) -> None:
        model = UserModel(
            id=user.id,
            email=user.email,
            name=user.name,
            is_active=user.is_active,
            created_at=user.created_at
        )
        self.session.merge(model)
        self.session.commit()
    
    async def get_by_id(self, user_id: str) -> Optional[User]:
        model = self.session.query(UserModel).filter_by(id=user_id).first()
        if not model:
            return None
        return self._map_to_entity(model)
    
    async def get_by_email(self, email: str) -> Optional[User]:
        model = self.session.query(UserModel).filter_by(email=email).first()
        if not model:
            return None
        return self._map_to_entity(model)
    
    async def list_all(self, skip: int = 0, limit: int = 10) -> List[User]:
        models = self.session.query(UserModel).offset(skip).limit(limit).all()
        return [self._map_to_entity(m) for m in models]
    
    async def delete(self, user_id: str) -> None:
        self.session.query(UserModel).filter_by(id=user_id).delete()
        self.session.commit()
    
    def _map_to_entity(self, model: UserModel) -> User:
        """Map database model to domain entity"""
        return User(
            id=model.id,
            email=model.email,
            name=model.name,
            is_active=model.is_active,
            created_at=model.created_at
        )

# infrastructure/persistence/models.py
from sqlalchemy import Column, String, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()

class UserModel(Base):
    """SQLAlchemy ORM model"""
    __tablename__ = "users"
    
    id = Column(String, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    name = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.now)
```

## Presentation Layer (FastAPI)

```python
# presentation/api/users.py
from fastapi import APIRouter, Depends, HTTPException, status
from application.services.user_service import UserService
from infrastructure.persistence.user_repository import UserRepository
from infrastructure.config import get_db_session
from presentation.schemas import UserCreateRequest, UserResponse
from domain.exceptions import DomainException

router = APIRouter(prefix="/api/v1/users", tags=["users"])

def get_user_service(session = Depends(get_db_session)) -> UserService:
    """Dependency injection"""
    repository = UserRepository(session)
    return UserService(repository)

@router.post("/", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user(
    request: UserCreateRequest,
    service: UserService = Depends(get_user_service)
):
    try:
        result = await service.create_user(request.email, request.name)
        return UserResponse(**result.__dict__)
    except DomainException as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{user_id}", response_model=UserResponse)
async def get_user(
    user_id: str,
    service: UserService = Depends(get_user_service)
):
    try:
        user = await service.get_user(user_id)
        return UserResponse(**user.__dict__)
    except DomainException as e:
        raise HTTPException(status_code=404, detail=str(e))

# presentation/schemas.py
from pydantic import BaseModel, EmailStr
from datetime import datetime

class UserCreateRequest(BaseModel):
    email: EmailStr
    name: str

class UserResponse(BaseModel):
    id: str
    email: str
    name: str
    is_active: bool
    created_at: datetime
    
    class Config:
        from_attributes = True
```

## Dependency Injection Container

```python
# infrastructure/container.py
from infrastructure.config import get_db_session
from infrastructure.persistence.user_repository import UserRepository
from application.services.user_service import UserService

class Container:
    """Central dependency container"""
    
    @staticmethod
    def get_user_service() -> UserService:
        session = get_db_session()
        repository = UserRepository(session)
        return UserService(repository)

# Usage in main.py
from infrastructure.container import Container

service = Container.get_user_service()
```

## Testing (Clean Architecture Advantage)

```python
# tests/application/test_create_user.py
import pytest
from unittest.mock import AsyncMock
from application.use_cases.create_user import CreateUserUseCase, CreateUserRequest
from domain.entities.user import User
from domain.exceptions import InvalidEmail

@pytest.fixture
def mock_repository():
    """Mock domain repository"""
    repository = AsyncMock()
    repository.get_by_email = AsyncMock(return_value=None)
    repository.save = AsyncMock()
    return repository

@pytest.mark.asyncio
async def test_create_user_success(mock_repository):
    """Test happy path"""
    use_case = CreateUserUseCase(mock_repository)
    request = CreateUserRequest(email="user@example.com", name="John")
    
    response = await use_case.execute(request)
    
    assert response.email == "user@example.com"
    assert response.name == "John"
    mock_repository.save.assert_called_once()

@pytest.mark.asyncio
async def test_create_user_invalid_email(mock_repository):
    """Test validation"""
    use_case = CreateUserUseCase(mock_repository)
    request = CreateUserRequest(email="invalid", name="John")
    
    with pytest.raises(InvalidEmail):
        await use_case.execute(request)

# tests/infrastructure/test_user_repository.py
@pytest.mark.asyncio
async def test_save_user(db_session):
    """Test database persistence - uses real DB"""
    repository = UserRepository(db_session)
    user = User(id="1", email="user@example.com", name="John")
    
    await repository.save(user)
    
    retrieved = await repository.get_by_id("1")
    assert retrieved.email == "user@example.com"
```

## Key Principles Checklist

- ✅ Domain layer has ZERO external dependencies
- ✅ All dependencies point inward (presentation → app → domain)
- ✅ Repository pattern for data access abstraction
- ✅ DTOs for data transfer between layers
- ✅ Use cases for business logic orchestration
- ✅ Entities represent domain concepts
- ✅ Exceptions in domain layer for business rules
- ✅ Infrastructure layer pluggable (swap DB, APIs)
- ✅ Easy to test (mock repositories)
- ✅ Framework-agnostic domain logic
- ✅ Clear separation of concerns
- ✅ Single Responsibility Principle

## Benefits of Clean Architecture

| Aspect | Benefit |
|--------|---------|
| **Testability** | Domain logic tests without DB/frameworks |
| **Maintainability** | Changes in one layer don't affect others |
| **Flexibility** | Swap FastAPI → Django, PostgreSQL → MongoDB |
| **Scalability** | Clear boundaries for large teams |
| **Reusability** | Domain logic usable in different interfaces |
| **Independence** | Develop independently per layer |

## Common Mistakes to Avoid

```python
# ❌ NEVER: Business logic in routes
@router.post("/users")
async def create_user(request: Request):
    # DON'T: All logic here
    user = db.create(...)
    email.send(...)

# ✅ INSTEAD: Use service/use case
@router.post("/users")
async def create_user(request: Request, service: UserService = Depends()):
    return await service.create_user(request.email)

# ❌ NEVER: Domain layer imports frameworks
from fastapi import HTTPException
class User:
    def validate(self):
        raise HTTPException(400)

# ✅ INSTEAD: Domain layer uses custom exceptions
class InvalidUser(DomainException):
    pass
```

## Keywords
clean-architecture, ddd, domain-driven-design, layered-architecture, python, solid, testing
