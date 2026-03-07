---
name: testing-strategies
description: >
  Comprehensive testing strategy: unit, integration, and E2E tests.
  Trigger: When planning test coverage, setting up testing infrastructure, or improving test quality.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Testing Pyramid

```
        E2E (5-10%)
       /           \
    Integration (20-30%)
    /                    \
Unit Tests (60-70%)
```

## Unit Tests (Individual Functions)

### TypeScript/JavaScript (Vitest)

```typescript
// ✅ Test single function in isolation
import { describe, it, expect } from "vitest";
import { calculateTotal } from "./order";

describe("calculateTotal", () => {
  it("should sum item prices with tax", () => {
    const items = [
      { name: "item1", price: 10 },
      { name: "item2", price: 20 }
    ];
    const result = calculateTotal(items, 0.1); // 10% tax
    expect(result).toBe(33); // 10 + 20 + 3 (tax)
  });

  it("should handle empty items", () => {
    expect(calculateTotal([], 0.1)).toBe(0);
  });

  it("should handle zero tax", () => {
    const items = [{ name: "item1", price: 50 }];
    expect(calculateTotal(items, 0)).toBe(50);
  });
});

// ✅ Mock external dependencies
import { describe, it, expect, vi } from "vitest";
import { getUserOrder } from "./user-service";
import * as db from "./db";

describe("getUserOrder", () => {
  it("should fetch order from database", async () => {
    const mockOrder = { id: "1", total: 100 };
    vi.spyOn(db, "query").mockResolvedValue(mockOrder);

    const result = await getUserOrder("user-123");
    expect(result).toEqual(mockOrder);
    expect(db.query).toHaveBeenCalledWith(
      "SELECT * FROM orders WHERE user_id = ?",
      ["user-123"]
    );
  });
});
```

### Python (Pytest)

```python
# ✅ Simple unit test
import pytest
from order import calculate_total

def test_calculate_total_with_tax():
    items = [{"name": "item1", "price": 10}, {"name": "item2", "price": 20}]
    result = calculate_total(items, tax=0.1)
    assert result == 33

def test_calculate_total_empty():
    assert calculate_total([], tax=0.1) == 0

# ✅ Parametrized tests (test multiple inputs)
@pytest.mark.parametrize("items,tax,expected", [
    ([{"price": 10}], 0.1, 11),
    ([{"price": 100}], 0.1, 110),
    ([], 0, 0),
])
def test_calculate_total_parametrized(items, tax, expected):
    assert calculate_total(items, tax=tax) == expected

# ✅ Mocking
from unittest.mock import patch, MagicMock

@patch("order.db.query")
def test_get_user_order(mock_query):
    mock_query.return_value = {"id": "1", "total": 100}
    
    result = get_user_order("user-123")
    
    assert result == {"id": "1", "total": 100}
    mock_query.assert_called_once_with(
        "SELECT * FROM orders WHERE user_id = ?",
        ["user-123"]
    )

# ✅ Fixtures (reusable test setup)
@pytest.fixture
def sample_user():
    return {"id": "1", "name": "John", "email": "john@example.com"}

def test_user_email(sample_user):
    assert sample_user["email"] == "john@example.com"
```

## Integration Tests (Multiple Components)

### API Integration (Django DRF + Pytest)

```python
import pytest
from rest_framework.test import APIClient
from django.contrib.auth.models import User

@pytest.fixture
def api_client():
    return APIClient()

@pytest.fixture
def user():
    return User.objects.create_user(
        username="testuser",
        email="test@example.com",
        password="testpass123"
    )

@pytest.mark.django_db
class TestUserAPI:
    def test_create_user(self, api_client):
        data = {"username": "newuser", "email": "new@example.com", "password": "pass123"}
        response = api_client.post("/api/v1/users/", data)
        
        assert response.status_code == 201
        assert response.json()["username"] == "newuser"

    def test_list_users_authenticated(self, api_client, user):
        api_client.force_authenticate(user=user)
        response = api_client.get("/api/v1/users/")
        
        assert response.status_code == 200
        assert len(response.json()["data"]) >= 1

    def test_update_user(self, api_client, user):
        api_client.force_authenticate(user=user)
        data = {"email": "updated@example.com"}
        response = api_client.patch(f"/api/v1/users/{user.id}/", data)
        
        assert response.status_code == 200
        assert response.json()["email"] == "updated@example.com"
```

### Database Integration (SQLAlchemy)

```python
# ✅ Test with real database (in-memory SQLite)
@pytest.fixture
def db_session():
    engine = create_engine("sqlite:///:memory:")
    Session = sessionmaker(bind=engine)
    Base.metadata.create_all(engine)
    session = Session()
    yield session
    session.close()

@pytest.mark.asyncio
async def test_user_creation(db_session):
    user = User(username="john", email="john@example.com")
    db_session.add(user)
    db_session.commit()
    
    retrieved = db_session.query(User).filter_by(username="john").first()
    assert retrieved.email == "john@example.com"

# ✅ Test transaction rollback
def test_transaction_rollback(db_session):
    user = User(username="john", email="john@example.com")
    db_session.add(user)
    db_session.commit()
    
    db_session.delete(user)
    assert db_session.query(User).count() == 0
```

## E2E Tests (Full User Workflows)

### Playwright (Browser Testing)

```typescript
// ✅ Complete user flow test
import { test, expect } from "@playwright/test";

test.describe("User Registration Flow", () => {
  test("should register new user successfully", async ({ page }) => {
    // Navigate to signup page
    await page.goto("http://localhost:3000/signup");
    
    // Fill form
    await page.fill('input[name="email"]', "newuser@example.com");
    await page.fill('input[name="password"]', "SecurePass123!");
    await page.fill('input[name="confirmPassword"]', "SecurePass123!");
    
    // Submit
    await page.click("button[type=submit]");
    
    // Verify redirect to dashboard
    await expect(page).toHaveURL(/.*dashboard/);
    await expect(page.locator("h1")).toContainText("Welcome");
  });

  test("should show validation errors", async ({ page }) => {
    await page.goto("http://localhost:3000/signup");
    
    // Submit empty form
    await page.click("button[type=submit]");
    
    // Check for error messages
    await expect(page.locator("text=Email is required")).toBeVisible();
    await expect(page.locator("text=Password is required")).toBeVisible();
  });
});

// ✅ Use Page Objects for maintainability
class SignupPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto("/signup");
  }

  async fillEmail(email: string) {
    await this.page.fill('input[name="email"]', email);
  }

  async fillPassword(password: string) {
    await this.page.fill('input[name="password"]', password);
  }

  async submit() {
    await this.page.click("button[type=submit]");
  }

  async hasError(message: string) {
    return await this.page.locator(`text=${message}`).isVisible();
  }
}

test("signup with page object", async ({ page }) => {
  const signup = new SignupPage(page);
  await signup.goto();
  await signup.fillEmail("user@example.com");
  await signup.fillPassword("pass123");
  await signup.submit();
  
  await expect(page).toHaveURL(/.*dashboard/);
});
```

## Test Organization & Structure

```
tests/
├── unit/              # Test individual functions
│   ├── order.test.ts
│   ├── user.test.ts
│   └── payment.test.ts
├── integration/       # Test component interactions
│   ├── api.test.ts
│   ├── database.test.ts
│   └── auth.test.ts
├── e2e/               # Full workflow tests
│   ├── user-signup.spec.ts
│   ├── product-checkout.spec.ts
│   └── admin-dashboard.spec.ts
└── fixtures/          # Test data
    └── users.json
```

## Coverage Requirements

```bash
# Generate coverage report
npm test -- --coverage
pytest --cov=app --cov-report=html

# Coverage targets
Statements: 80%+
Branches: 75%+
Functions: 80%+
Lines: 80%+

# View reports
open htmlcov/index.html
```

## Continuous Integration (GitHub Actions)

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:16-alpine
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "20"
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run unit tests
        run: npm run test:unit
      
      - name: Run integration tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test
      
      - name: Run E2E tests
        run: npm run test:e2e
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

## Testing Best Practices Checklist

- ✅ Test behavior, not implementation
- ✅ One assertion per test (or related group)
- ✅ Clear, descriptive test names
- ✅ DRY: Use fixtures and utilities
- ✅ Mock external dependencies
- ✅ Test error cases and edge cases
- ✅ Keep tests fast (unit > integration > e2e)
- ✅ Run tests on every push
- ✅ Aim for 80%+ coverage
- ✅ Use Page Objects for E2E (maintainability)
- ✅ Test happy path AND sad path
- ✅ Keep test data realistic
- ✅ Isolate tests (no dependencies between them)
- ✅ Use parametrized tests for multiple inputs

## Common Testing Pitfalls

```typescript
// ❌ NEVER: Test implementation details
it("should call setState", () => {
  // Wrong: testing internal behavior
  expect(mockSetState).toHaveBeenCalled();
});

// ✅ INSTEAD: Test visible behavior
it("should display updated count", () => {
  render(<Counter />);
  expect(screen.getByText("Count: 0")).toBeInTheDocument();
  fireEvent.click(screen.getByRole("button"));
  expect(screen.getByText("Count: 1")).toBeInTheDocument();
});

// ❌ NEVER: Tests that depend on each other
it("test 1", () => { /* ... */ });
it("test 2", () => { /* needs test 1 to run first */ });

// ✅ INSTEAD: Each test is independent
it("test A", () => { /* setup, execute, assert */ });
it("test B", () => { /* setup, execute, assert */ });
```

## Keywords
testing, unit-tests, integration-tests, e2e, playwright, pytest, vitest, coverage, testing-pyramid
