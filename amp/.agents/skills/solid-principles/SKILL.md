---
name: solid-principles
description: >
  SOLID principles for maintainable and scalable code: SRP, OCP, LSP, ISP, DIP.
  Trigger: When designing classes, refactoring code, or improving maintainability.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## SOLID Overview

```
S - Single Responsibility Principle (SRP)
    A class should have one reason to change

O - Open/Closed Principle (OCP)
    Open for extension, closed for modification

L - Liskov Substitution Principle (LSP)
    Subtypes must be substitutable for base types

I - Interface Segregation Principle (ISP)
    Many specific interfaces over one general interface

D - Dependency Inversion Principle (DIP)
    Depend on abstractions, not concrete implementations
```

---

## S - Single Responsibility Principle

**Definition:** A class should have only ONE reason to change.

### Bad Example (Violates SRP)

```python
# ❌ UserManager has too many responsibilities
class UserManager:
    def __init__(self, db_connection):
        self.db = db_connection
    
    def create_user(self, email, password):
        """Responsibility 1: User management"""
        # Hash password
        hashed = self._hash_password(password)
        # Create in database
        self.db.insert("users", {"email": email, "password": hashed})
    
    def _hash_password(self, password):
        """Embedded password logic"""
        return hashlib.sha256(password.encode()).hexdigest()
    
    def send_verification_email(self, email):
        """Responsibility 2: Email sending"""
        import smtplib
        msg = f"Verify your account: {email}"
        smtplib.SMTP("smtp.gmail.com").sendmail("no-reply@app.com", email, msg)
    
    def generate_jwt_token(self, user_id):
        """Responsibility 3: Token generation"""
        import jwt
        return jwt.encode({"user_id": user_id}, "secret")
    
    def log_user_activity(self, user_id, action):
        """Responsibility 4: Logging"""
        with open("logs.txt", "a") as f:
            f.write(f"{user_id}: {action}\n")
```

**Problems:**
- 4 reasons to change (user logic, password, email, tokens, logging)
- Hard to test
- Hard to reuse components
- Hard to maintain

### Good Example (Follows SRP)

```python
# ✅ Each class has ONE responsibility

class PasswordHasher:
    """Only responsible for password hashing"""
    def hash(self, password: str) -> str:
        return hashlib.sha256(password.encode()).hexdigest()
    
    def verify(self, password: str, hash: str) -> bool:
        return self.hash(password) == hash

class UserRepository:
    """Only responsible for user persistence"""
    def __init__(self, db_connection):
        self.db = db_connection
    
    def create(self, email: str, password_hash: str) -> User:
        result = self.db.insert("users", {
            "email": email,
            "password": password_hash
        })
        return User(id=result.id, email=email)
    
    def get_by_id(self, user_id: str) -> Optional[User]:
        # ...

class EmailService:
    """Only responsible for email sending"""
    def __init__(self, smtp_config):
        self.config = smtp_config
    
    def send_verification(self, email: str, token: str):
        msg = f"Verify: {token}"
        # Send email implementation

class TokenService:
    """Only responsible for JWT tokens"""
    def __init__(self, secret: str):
        self.secret = secret
    
    def generate(self, user_id: str) -> str:
        return jwt.encode({"user_id": user_id}, self.secret)
    
    def verify(self, token: str) -> dict:
        return jwt.decode(token, self.secret)

class UserService:
    """Orchestrates the above services"""
    def __init__(self, repository, password_hasher, email_service, token_service):
        self.repository = repository
        self.password_hasher = password_hasher
        self.email_service = email_service
        self.token_service = token_service
    
    def register_user(self, email: str, password: str) -> str:
        # Orchestrate: hash → save → send email → generate token
        hashed = self.password_hasher.hash(password)
        user = self.repository.create(email, hashed)
        self.email_service.send_verification(email, user.id)
        token = self.token_service.generate(user.id)
        return token
```

**Benefits:**
- Each class has ONE reason to change
- Easy to test in isolation
- Easy to reuse components
- Clear responsibilities

---

## O - Open/Closed Principle

**Definition:** Software should be OPEN for extension but CLOSED for modification.

### Bad Example (Violates OCP)

```python
# ❌ Adding new payment methods requires modifying existing code
class PaymentProcessor:
    def process(self, payment_type: str, amount: float):
        if payment_type == "credit_card":
            # Credit card logic
            return self._process_credit_card(amount)
        
        elif payment_type == "paypal":
            # PayPal logic
            return self._process_paypal(amount)
        
        elif payment_type == "stripe":
            # Stripe logic
            return self._process_stripe(amount)
        
        # Adding new payment method?
        # Must modify this class! ❌
        elif payment_type == "crypto":
            # Cryptocurrency logic
            return self._process_crypto(amount)
```

**Problems:**
- Adding payment method requires modifying existing code
- Violates OCP
- Risk of breaking existing functionality

### Good Example (Follows OCP)

```python
# ✅ New payment methods added via extension, not modification

from abc import ABC, abstractmethod

class PaymentMethod(ABC):
    """Abstract interface for all payment methods"""
    @abstractmethod
    def process(self, amount: float) -> bool:
        pass
    
    @abstractmethod
    def refund(self, transaction_id: str) -> bool:
        pass

class CreditCardPayment(PaymentMethod):
    """Extends for credit card"""
    def process(self, amount: float) -> bool:
        # Credit card implementation
        return True
    
    def refund(self, transaction_id: str) -> bool:
        # Credit card refund
        return True

class PayPalPayment(PaymentMethod):
    """Extends for PayPal"""
    def process(self, amount: float) -> bool:
        # PayPal implementation
        return True
    
    def refund(self, transaction_id: str) -> bool:
        # PayPal refund
        return True

class CryptoPayment(PaymentMethod):
    """NEW payment method - just add new class, no modification!"""
    def process(self, amount: float) -> bool:
        # Crypto implementation
        return True
    
    def refund(self, transaction_id: str) -> bool:
        # Can't refund crypto, but implement interface
        raise NotImplementedError("Crypto refunds not supported")

class PaymentProcessor:
    """Closed for modification, accepts any PaymentMethod"""
    def process_payment(self, payment_method: PaymentMethod, amount: float) -> bool:
        return payment_method.process(amount)
    
    def refund_payment(self, payment_method: PaymentMethod, transaction_id: str) -> bool:
        return payment_method.refund(transaction_id)

# Usage: Add new payment method WITHOUT modifying PaymentProcessor
processor = PaymentProcessor()
processor.process_payment(CryptoPayment(), 100)  # New, no changes needed!
```

**Benefits:**
- Add new payment methods without modifying existing code
- Lower risk of breaking things
- Easy to test new functionality
- Follows OCP

---

## L - Liskov Substitution Principle

**Definition:** Subtypes must be substitutable for their base types.

### Bad Example (Violates LSP)

```python
# ❌ Rectangle and Square problem
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    def set_width(self, width):
        self.width = width
    
    def set_height(self, height):
        self.height = height
    
    def area(self) -> float:
        return self.width * self.height

class Square(Rectangle):
    """Square IS-A Rectangle, but..."""
    def set_width(self, width):
        self.width = width
        self.height = width  # ❌ Violates contract!
    
    def set_height(self, height):
        self.width = height
        self.height = height  # ❌ Violates contract!

# Usage breaks expectations
def calculate_area(rect: Rectangle):
    rect.set_width(5)
    rect.set_height(10)
    return rect.area()  # Expects 50

area = calculate_area(Square(0, 0))
# Problem: Square returns 100, not 50!
```

### Good Example (Follows LSP)

```python
# ✅ Proper inheritance hierarchy
from abc import ABC, abstractmethod

class Shape(ABC):
    """Base class for all shapes"""
    @abstractmethod
    def area(self) -> float:
        pass

class Rectangle(Shape):
    def __init__(self, width: float, height: float):
        self.width = width
        self.height = height
    
    def set_width(self, width: float):
        self.width = width
    
    def set_height(self, height: float):
        self.height = height
    
    def area(self) -> float:
        return self.width * self.height

class Square(Shape):
    """Square is NOT a Rectangle in terms of behavior"""
    def __init__(self, side: float):
        self.side = side
    
    def set_side(self, side: float):
        self.side = side
    
    def area(self) -> float:
        return self.side ** 2

# Now substitutability works correctly
def calculate_area(shape: Shape) -> float:
    return shape.area()

calculate_area(Rectangle(5, 10))  # 50
calculate_area(Square(5))         # 25
```

**Benefits:**
- Subtypes work correctly when substituted
- No unexpected behavior
- Contracts are honored

---

## I - Interface Segregation Principle

**Definition:** Clients should not depend on interfaces they don't use.

### Bad Example (Violates ISP)

```python
# ❌ Fat interface - forces clients to implement unused methods
class Animal(ABC):
    @abstractmethod
    def eat(self):
        pass
    
    @abstractmethod
    def fly(self):
        pass
    
    @abstractmethod
    def swim(self):
        pass

class Dog(Animal):
    def eat(self):
        print("Dog eating")
    
    def fly(self):
        raise NotImplementedError("Dogs can't fly")  # ❌
    
    def swim(self):
        print("Dog swimming")

class Fish(Animal):
    def eat(self):
        print("Fish eating")
    
    def fly(self):
        raise NotImplementedError("Fish can't fly")  # ❌
    
    def swim(self):
        print("Fish swimming")

class Bird(Animal):
    def eat(self):
        print("Bird eating")
    
    def fly(self):
        print("Bird flying")
    
    def swim(self):
        raise NotImplementedError("Birds can't swim")  # ❌
```

### Good Example (Follows ISP)

```python
# ✅ Segregated interfaces - implement only what's needed
class Eatable(ABC):
    @abstractmethod
    def eat(self):
        pass

class Flyable(ABC):
    @abstractmethod
    def fly(self):
        pass

class Swimmable(ABC):
    @abstractmethod
    def swim(self):
        pass

class Dog(Eatable, Swimmable):
    """Only implements needed interfaces"""
    def eat(self):
        print("Dog eating")
    
    def swim(self):
        print("Dog swimming")

class Fish(Eatable, Swimmable):
    """Only implements needed interfaces"""
    def eat(self):
        print("Fish eating")
    
    def swim(self):
        print("Fish swimming")

class Bird(Eatable, Flyable):
    """Only implements needed interfaces"""
    def eat(self):
        print("Bird eating")
    
    def fly(self):
        print("Bird flying")

# Now clients only depend on what they use
def feed(animal: Eatable):
    animal.eat()

def race(swimmer: Swimmable):
    swimmer.swim()
```

**Benefits:**
- Classes only implement what they need
- No "fake" implementations
- Cleaner contracts
- Better flexibility

---

## D - Dependency Inversion Principle

**Definition:** Depend on abstractions, NOT concrete implementations.

### Bad Example (Violates DIP)

```python
# ❌ UserService depends on concrete MySQL class
class MySQLDatabase:
    def query(self, sql: str):
        # Execute MySQL query
        pass

class UserService:
    def __init__(self):
        self.db = MySQLDatabase()  # ❌ Hard dependency
    
    def get_user(self, user_id: str):
        return self.db.query(f"SELECT * FROM users WHERE id = {user_id}")

# Problem: Changing database requires modifying UserService!
```

### Good Example (Follows DIP)

```python
# ✅ UserService depends on abstract interface
from abc import ABC, abstractmethod

class Database(ABC):
    """Abstraction that both depend on"""
    @abstractmethod
    def query(self, sql: str):
        pass

class MySQLDatabase(Database):
    """Concrete implementation"""
    def query(self, sql: str):
        # Execute MySQL query
        pass

class PostgreSQLDatabase(Database):
    """Another concrete implementation"""
    def query(self, sql: str):
        # Execute PostgreSQL query
        pass

class UserService:
    def __init__(self, database: Database):
        self.db = database  # ✅ Depends on abstraction
    
    def get_user(self, user_id: str):
        return self.db.query(f"SELECT * FROM users WHERE id = {user_id}")

# Usage: Easy to swap databases
mysql_db = MySQLDatabase()
postgres_db = PostgreSQLDatabase()

service1 = UserService(mysql_db)
service2 = UserService(postgres_db)

# Testing: Easy to mock
mock_db = MagicMock(spec=Database)
test_service = UserService(mock_db)
```

**Benefits:**
- Change implementations without changing clients
- Easy to test (mock the interface)
- Loosely coupled
- Flexible architecture

---

## SOLID in Practice

### Real-World Example: E-Commerce Order

```python
# ❌ BAD: Violates multiple SOLID principles
class OrderProcessor:
    def __init__(self):
        self.db = MySQLDatabase()
        self.email = EmailService()
        self.payment = StripePayment()
    
    def process_order(self, order_id: str):
        order = self.db.query(f"SELECT * FROM orders WHERE id = {order_id}")
        
        # Process payment
        result = self.payment.charge_card(
            order.total,
            order.card_number,
            order.cvv
        )
        
        # Email notification
        self.email.send(order.user_email, f"Your order total: {order.total}")
        
        # Update database
        self.db.execute(f"UPDATE orders SET status='completed' WHERE id = {order_id}")
        
        return result

# ✅ GOOD: Follows all SOLID principles
class Database(ABC):
    @abstractmethod
    def get_order(self, order_id: str) -> Order:
        pass
    
    @abstractmethod
    def update_order(self, order: Order):
        pass

class PaymentMethod(ABC):
    @abstractmethod
    def charge(self, amount: float) -> TransactionResult:
        pass

class Notification(ABC):
    @abstractmethod
    def send(self, message: str):
        pass

class OrderProcessor:
    """Depends on abstractions"""
    def __init__(
        self,
        database: Database,
        payment: PaymentMethod,
        notification: Notification
    ):
        self.database = database
        self.payment = payment
        self.notification = notification
    
    def process(self, order_id: str) -> bool:
        """Single responsibility: orchestrate order processing"""
        order = self.database.get_order(order_id)
        
        if not self._is_valid_order(order):
            return False
        
        result = self.payment.charge(order.total)
        
        if result.success:
            order.status = "completed"
            self.database.update_order(order)
            self._notify_customer(order)
            return True
        
        return False
    
    def _is_valid_order(self, order: Order) -> bool:
        """Validation logic"""
        return order.total > 0 and order.items
    
    def _notify_customer(self, order: Order):
        """Send notification"""
        self.notification.send(f"Order {order.id} completed")

# Usage: Easy to test, extend, modify
def create_order_processor(env: str) -> OrderProcessor:
    if env == "test":
        db = MockDatabase()
        payment = MockPayment()
        notification = MockNotification()
    else:
        db = MySQLDatabase()
        payment = StripePayment()
        notification = EmailNotification()
    
    return OrderProcessor(db, payment, notification)
```

---

## SOLID Principles Checklist

**SRP:**
- [ ] Each class has one reason to change
- [ ] Method names match responsibility
- [ ] No "and" in class descriptions

**OCP:**
- [ ] Add features via extension, not modification
- [ ] Use abstract base classes/interfaces
- [ ] No if/else for new types

**LSP:**
- [ ] Subtypes honor base type contracts
- [ ] No NotImplementedError in implementations
- [ ] Substitution works everywhere

**ISP:**
- [ ] Interfaces are small and focused
- [ ] Clients implement only needed methods
- [ ] No "fat" interfaces

**DIP:**
- [ ] Depend on abstractions
- [ ] Inject dependencies
- [ ] Easy to mock for testing

---

## Keywords
solid, single-responsibility, open-closed, liskov, interface-segregation, dependency-inversion, maintainability, design-patterns
