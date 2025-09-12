# 📚 Pattern Library - Proven Solutions

## Purpose
Collect and reuse proven patterns to avoid reinventing the wheel and repeating mistakes.

## Categories

### 🔐 Authentication Patterns

#### JWT with Refresh Tokens ✅
```javascript
// PATTERN: Stateless auth with refresh capability
const authPattern = {
  use: "JWT + Refresh Token",
  why: "Stateless, scalable, secure",
  implementation: {
    accessToken: "15 minutes expiry",
    refreshToken: "7 days expiry",
    storage: "httpOnly cookies",
    rotation: "on each refresh"
  },
  avoid: ["localStorage for tokens", "infinite expiry", "same token for all"]
};
```

#### Session-based Auth ⚠️
```javascript
// USE ONLY: When stateful sessions required
const sessionPattern = {
  when: "Banking, high-security apps",
  requirements: ["Redis/Memcached", "Sticky sessions", "CSRF protection"],
  avoid: ["Microservices", "Serverless", "Multi-region"]
};
```

### 🎨 React Component Patterns

#### Container/Presenter Pattern ✅
```typescript
// PATTERN: Separation of concerns
// Container: Logic and state
const UserContainer = () => {
  const [users, setUsers] = useState([]);
  useEffect(() => { fetchUsers(); }, []);
  return <UserList users={users} />;
};

// Presenter: Pure presentation
const UserList = ({ users }) => (
  <ul>{users.map(u => <li>{u.name}</li>)}</ul>
);
```

#### Compound Components ✅
```typescript
// PATTERN: Flexible component composition
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>Content</Card.Body>
  <Card.Footer>Actions</Card.Footer>
</Card>
```

### 🗄️ Database Patterns

#### Repository Pattern ✅
```typescript
// PATTERN: Abstract data access
class UserRepository {
  async findById(id: string): Promise<User> {
    // Implementation agnostic
    return db.query('SELECT * FROM users WHERE id = ?', [id]);
  }
  
  async save(user: User): Promise<void> {
    // Handles both insert and update
    return user.id ? this.update(user) : this.insert(user);
  }
}
```

#### Unit of Work ✅
```typescript
// PATTERN: Transactional consistency
class UnitOfWork {
  async execute(callback) {
    const trx = await db.transaction();
    try {
      const result = await callback(trx);
      await trx.commit();
      return result;
    } catch (error) {
      await trx.rollback();
      throw error;
    }
  }
}
```

### 🚦 Error Handling Patterns

#### Result Type Pattern ✅
```typescript
// PATTERN: Explicit error handling
type Result<T, E> = 
  | { ok: true; value: T }
  | { ok: false; error: E };

function divide(a: number, b: number): Result<number, string> {
  if (b === 0) return { ok: false, error: "Division by zero" };
  return { ok: true, value: a / b };
}
```

#### Error Boundary Pattern ✅
```typescript
// PATTERN: Graceful React error handling
class ErrorBoundary extends React.Component {
  componentDidCatch(error, info) {
    logError(error, info);
    this.setState({ hasError: true });
  }
  
  render() {
    if (this.state.hasError) {
      return <FallbackComponent />;
    }
    return this.props.children;
  }
}
```

### 🔄 API Patterns

#### REST with HATEOAS ✅
```json
// PATTERN: Self-documenting APIs
{
  "id": 123,
  "name": "John Doe",
  "_links": {
    "self": "/users/123",
    "orders": "/users/123/orders",
    "update": { "href": "/users/123", "method": "PUT" }
  }
}
```

#### GraphQL with DataLoader ✅
```javascript
// PATTERN: Solve N+1 queries
const userLoader = new DataLoader(async (userIds) => {
  const users = await db.query('SELECT * FROM users WHERE id IN (?)', [userIds]);
  return userIds.map(id => users.find(u => u.id === id));
});
```

### 🏗️ Architecture Patterns

#### Hexagonal Architecture ✅
```
PATTERN: Ports and Adapters
├── domain/        (Business logic)
├── application/   (Use cases)
├── infrastructure/(External services)
└── presentation/  (UI/API)
```

#### Event Sourcing ✅
```javascript
// PATTERN: Audit trail and time travel
const events = [
  { type: 'USER_CREATED', data: { name: 'John' }, timestamp: '...' },
  { type: 'USER_UPDATED', data: { email: 'john@example.com' }, timestamp: '...' }
];

const currentState = events.reduce(applyEvent, initialState);
```

### 🧪 Testing Patterns

#### AAA Pattern ✅
```javascript
// PATTERN: Arrange, Act, Assert
test('should calculate total', () => {
  // Arrange
  const items = [{ price: 10 }, { price: 20 }];
  
  // Act
  const total = calculateTotal(items);
  
  // Assert
  expect(total).toBe(30);
});
```

#### Test Data Builders ✅
```javascript
// PATTERN: Flexible test data creation
class UserBuilder {
  constructor() {
    this.user = { id: 1, name: 'Test', email: 'test@test.com' };
  }
  
  withName(name) {
    this.user.name = name;
    return this;
  }
  
  build() {
    return this.user;
  }
}

// Usage
const user = new UserBuilder().withName('John').build();
```

### 🚀 Performance Patterns

#### Memoization ✅
```javascript
// PATTERN: Cache expensive computations
const memoize = (fn) => {
  const cache = new Map();
  return (...args) => {
    const key = JSON.stringify(args);
    if (!cache.has(key)) {
      cache.set(key, fn(...args));
    }
    return cache.get(key);
  };
};
```

#### Virtual Scrolling ✅
```javascript
// PATTERN: Render only visible items
<VirtualList
  items={millionItems}
  itemHeight={50}
  containerHeight={500}
  renderItem={(item) => <Item {...item} />}
/>
```

## Anti-Patterns to Avoid

### ❌ God Object
```javascript
// AVOID: Classes that do everything
class UserService {
  authenticate() {}
  sendEmail() {}
  generateReport() {}
  backupDatabase() {}
  // 100 more methods...
}
```

### ❌ Callback Hell
```javascript
// AVOID: Nested callbacks
getData(function(a) {
  getMoreData(a, function(b) {
    getMoreData(b, function(c) {
      // ...
    });
  });
});
```

### ❌ Premature Optimization
```javascript
// AVOID: Optimizing before measuring
// Use simple solution first, optimize when proven necessary
```

## Usage Guidelines

1. **Check here first** before implementing new features
2. **Copy patterns** don't reinvent
3. **Document deviations** if pattern doesn't fit
4. **Update patterns** when better solution found
5. **Share learnings** with the team

## Contribution

To add a new pattern:
1. Prove it works in production
2. Document pros/cons
3. Include code example
4. Add to appropriate category
5. Update index

---
*"Smart developers copy, genius developers paste from the pattern library"*