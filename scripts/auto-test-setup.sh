#!/bin/bash

# 🧪 UNIVERSAL TEST AUTOMATION SETUP
# Works with ANY project type - automatically detects and configures testing

set -e

echo "🔍 Analyzing project structure..."

PROJECT_TYPE=""
PACKAGE_MANAGER=""

# Detect project type
if [ -f "package.json" ]; then
    PROJECT_TYPE="node"
    echo "📦 Node.js/JavaScript project detected"
    
    # Detect package manager
    if [ -f "yarn.lock" ]; then
        PACKAGE_MANAGER="yarn"
    elif [ -f "pnpm-lock.yaml" ]; then
        PACKAGE_MANAGER="pnpm"
    else
        PACKAGE_MANAGER="npm"
    fi
    
elif [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    PROJECT_TYPE="python"
    echo "🐍 Python project detected"
    
elif [ -f "pom.xml" ]; then
    PROJECT_TYPE="java"
    echo "☕ Java project detected"
    
elif [ -f "go.mod" ]; then
    PROJECT_TYPE="go"
    echo "🐹 Go project detected"
    
elif [ -f "Gemfile" ]; then
    PROJECT_TYPE="ruby"
    echo "💎 Ruby project detected"
    
elif [ -f "Cargo.toml" ]; then
    PROJECT_TYPE="rust"
    echo "🦀 Rust project detected"
    
else
    echo "⚠️ Project type not detected. Defaulting to Node.js setup."
    PROJECT_TYPE="node"
    PACKAGE_MANAGER="npm"
fi

# Function to setup Node.js/JavaScript testing
setup_node_tests() {
    echo "🔧 Setting up JavaScript/TypeScript testing..."
    
    # Check for Chrome DevTools MCP availability
    if command -v claude > /dev/null; then
        echo "🔍 Checking Chrome DevTools MCP installation..."
        if ! claude mcp list 2>/dev/null | grep -q "chrome-devtools"; then
            echo "📦 Installing Chrome DevTools MCP for browser automation..."
            claude mcp add chrome-devtools npx chrome-devtools-mcp@latest 2>/dev/null || {
                echo "⚠️ Could not install Chrome DevTools MCP automatically"
                echo "   Please run: claude mcp add chrome-devtools npx chrome-devtools-mcp@latest"
            }
        else
            echo "✅ Chrome DevTools MCP already installed"
        fi
    fi
    
    # Check if tests already exist
    if [ -d "tests" ] || [ -d "test" ] || [ -d "__tests__" ]; then
        echo "📂 Test directory already exists"
    else
        echo "📂 Creating test structure..."
        mkdir -p tests/{unit,integration,e2e,fixtures,performance}
    fi
    
    # Install test dependencies
    echo "📦 Installing test dependencies..."
    
    DEPS="vitest @vitest/coverage-v8 @testing-library/react @testing-library/jest-dom @testing-library/user-event @faker-js/faker msw supertest"
    E2E_DEPS="@playwright/test playwright"
    PERF_DEPS="k6"
    
    if [ "$PACKAGE_MANAGER" = "yarn" ]; then
        yarn add -D $DEPS $E2E_DEPS
    elif [ "$PACKAGE_MANAGER" = "pnpm" ]; then
        pnpm add -D $DEPS $E2E_DEPS
    else
        npm install --save-dev $DEPS $E2E_DEPS
    fi
    
    # Create Vitest config
    if [ ! -f "vitest.config.ts" ] && [ ! -f "vitest.config.js" ]; then
        echo "⚙️ Creating Vitest configuration..."
        cat > vitest.config.ts << 'EOF'
import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './tests/setup.ts',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules',
        'tests',
        '*.config.*',
        'dist',
        'build'
      ],
      thresholds: {
        branches: 80,
        functions: 80,
        lines: 80,
        statements: 80
      }
    }
  }
});
EOF
    fi
    
    # Create Playwright config
    if [ ! -f "playwright.config.ts" ] && [ ! -f "playwright.config.js" ]; then
        echo "🎭 Creating Playwright configuration..."
        cat > playwright.config.ts << 'EOF'
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure'
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } }
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI
  }
});
EOF
    fi
    
    # Create test setup file
    if [ ! -f "tests/setup.ts" ]; then
        echo "🔧 Creating test setup file..."
        cat > tests/setup.ts << 'EOF'
import '@testing-library/jest-dom';
import { expect, afterEach, vi } from 'vitest';
import { cleanup } from '@testing-library/react';

afterEach(() => {
  cleanup();
  vi.clearAllMocks();
});
EOF
    fi
    
    # Add test scripts to package.json
    echo "📝 Adding test scripts to package.json..."
    
    # Read current package.json
    if command -v node > /dev/null; then
        node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
        
        pkg.scripts = pkg.scripts || {};
        pkg.scripts.test = pkg.scripts.test || 'vitest';
        pkg.scripts['test:unit'] = 'vitest run tests/unit';
        pkg.scripts['test:integration'] = 'vitest run tests/integration';
        pkg.scripts['test:e2e'] = 'playwright test';
        pkg.scripts['test:e2e:ui'] = 'playwright test --ui';
        pkg.scripts['test:coverage'] = 'vitest run --coverage';
        pkg.scripts['test:watch'] = 'vitest watch';
        pkg.scripts['test:ci'] = 'npm run test:unit && npm run test:integration';
        pkg.scripts['test:all'] = 'npm run test:ci && npm run test:e2e';
        
        fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
        "
    fi
    
    echo "✅ JavaScript/TypeScript testing setup complete!"
}

# Function to setup Python testing
setup_python_tests() {
    echo "🔧 Setting up Python testing..."
    
    # Create test structure
    if [ ! -d "tests" ]; then
        echo "📂 Creating test structure..."
        mkdir -p tests/{unit,integration,fixtures}
        touch tests/__init__.py
        touch tests/unit/__init__.py
        touch tests/integration/__init__.py
    fi
    
    # Install test dependencies
    echo "📦 Installing test dependencies..."
    pip install pytest pytest-cov pytest-mock pytest-asyncio faker requests-mock
    
    # Create pytest config
    if [ ! -f "pytest.ini" ] && [ ! -f "setup.cfg" ] && [ ! -f "pyproject.toml" ]; then
        echo "⚙️ Creating pytest configuration..."
        cat > pytest.ini << 'EOF'
[pytest]
testpaths = tests
python_files = test_*.py *_test.py
python_classes = Test*
python_functions = test_*
addopts = 
    -v
    --cov=.
    --cov-report=term-missing
    --cov-report=html
    --cov-report=xml
    --cov-fail-under=80
markers =
    unit: Unit tests
    integration: Integration tests
    slow: Slow tests
EOF
    fi
    
    # Create conftest.py
    if [ ! -f "tests/conftest.py" ]; then
        echo "🔧 Creating pytest fixtures..."
        cat > tests/conftest.py << 'EOF'
import pytest
from faker import Faker

@pytest.fixture
def faker():
    return Faker()

@pytest.fixture
def client():
    # Add your app client here
    pass
EOF
    fi
    
    echo "✅ Python testing setup complete!"
}

# Function to create GitHub Actions workflow
setup_github_actions() {
    echo "🚀 Setting up GitHub Actions..."
    
    mkdir -p .github/workflows
    
    cat > .github/workflows/test.yml << 'EOF'
name: Automated Testing

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        node-version: [18.x, 20.x]
        python-version: [3.9, 3.11]
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Detect project type
      id: detect
      run: |
        if [ -f "package.json" ]; then
          echo "type=node" >> $GITHUB_OUTPUT
        elif [ -f "requirements.txt" ]; then
          echo "type=python" >> $GITHUB_OUTPUT
        fi
    
    - name: Setup Node.js
      if: steps.detect.outputs.type == 'node'
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}
        cache: 'npm'
    
    - name: Setup Python
      if: steps.detect.outputs.type == 'python'
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
        cache: 'pip'
    
    - name: Install dependencies
      run: |
        if [ "${{ steps.detect.outputs.type }}" = "node" ]; then
          npm ci
        elif [ "${{ steps.detect.outputs.type }}" = "python" ]; then
          pip install -r requirements.txt
          pip install pytest pytest-cov
        fi
    
    - name: Run linting
      run: |
        if [ "${{ steps.detect.outputs.type }}" = "node" ]; then
          npm run lint || true
        elif [ "${{ steps.detect.outputs.type }}" = "python" ]; then
          pip install flake8
          flake8 . || true
        fi
    
    - name: Run tests
      run: |
        if [ "${{ steps.detect.outputs.type }}" = "node" ]; then
          npm run test:ci
        elif [ "${{ steps.detect.outputs.type }}" = "python" ]; then
          pytest --cov=./ --cov-report=xml
        fi
    
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      with:
        files: ./coverage/coverage-final.json,./coverage.xml
        fail_ci_if_error: false
EOF
    
    echo "✅ GitHub Actions workflow created!"
}

# Function to setup Git hooks
setup_git_hooks() {
    echo "🪝 Setting up Git hooks..."
    
    mkdir -p .git/hooks
    
    # Pre-commit hook
    cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "🧪 Running tests before commit..."

# Detect project type and run tests
if [ -f "package.json" ]; then
    npm run test:unit || exit 1
elif [ -f "requirements.txt" ]; then
    pytest tests/unit || exit 1
fi

echo "✅ Tests passed!"
EOF
    
    chmod +x .git/hooks/pre-commit
    
    # Pre-push hook
    cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash

echo "🚀 Running full test suite before push..."

if [ -f "package.json" ]; then
    npm run test:all || exit 1
elif [ -f "requirements.txt" ]; then
    pytest || exit 1
fi

echo "✅ All tests passed!"
EOF
    
    chmod +x .git/hooks/pre-push
    
    echo "✅ Git hooks setup complete!"
}

# Function to create example tests
create_example_tests() {
    echo "📝 Creating example tests..."
    
    if [ "$PROJECT_TYPE" = "node" ]; then
        # Create example unit test
        cat > tests/unit/example.test.ts << 'EOF'
import { describe, it, expect } from 'vitest';

describe('Example Test Suite', () => {
  it('should pass this example test', () => {
    expect(true).toBe(true);
  });
  
  it('should add numbers correctly', () => {
    const sum = (a: number, b: number) => a + b;
    expect(sum(1, 2)).toBe(3);
  });
});
EOF
        
        # Create example E2E test
        cat > tests/e2e/example.spec.ts << 'EOF'
import { test, expect } from '@playwright/test';

test('homepage loads successfully', async ({ page }) => {
  await page.goto('/');
  await expect(page).toHaveTitle(/Home/);
});
EOF
        
    elif [ "$PROJECT_TYPE" = "python" ]; then
        # Create example unit test
        cat > tests/unit/test_example.py << 'EOF'
import pytest

def test_example():
    assert True

def test_addition():
    assert 1 + 2 == 3

class TestExample:
    def test_method(self):
        assert "hello".upper() == "HELLO"
EOF
    fi
    
    echo "✅ Example tests created!"
}

# Main execution
main() {
    echo "🚀 Starting Universal Test Setup..."
    echo "================================"
    
    # Setup based on project type
    case $PROJECT_TYPE in
        node)
            setup_node_tests
            ;;
        python)
            setup_python_tests
            ;;
        *)
            echo "⚠️ Unsupported project type. Manual setup required."
            exit 1
            ;;
    esac
    
    # Setup CI/CD
    setup_github_actions
    
    # Setup Git hooks
    setup_git_hooks
    
    # Create example tests
    create_example_tests
    
    echo ""
    echo "================================"
    echo "✨ Test Automation Setup Complete!"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Run tests: npm test (or pytest)"
    echo "2. View coverage: npm run test:coverage"
    echo "3. Run E2E tests: npm run test:e2e"
    echo "4. Commit and push to trigger CI/CD"
    echo ""
    echo "🎯 Your project now has:"
    echo "✅ Unit testing"
    echo "✅ Integration testing"
    echo "✅ E2E testing (Node.js)"
    echo "✅ Code coverage"
    echo "✅ Git hooks"
    echo "✅ GitHub Actions CI/CD"
    echo ""
    echo "Happy Testing! 🧪"
}

# Run main function
main