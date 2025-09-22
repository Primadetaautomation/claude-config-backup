# 🧪 TEST AUTOMATION SUBAGENT
**Auto-Test Framework for All Projects**  
**Version**: 2.0  
**Auto-Triggers**: After code changes, pre-commit, pre-deployment

---

## 🎯 AGENT CAPABILITIES

This specialized test agent automatically:
1. **Detects project type** (React, Node, Python, etc.)
2. **Installs test dependencies** automatically
3. **Creates test infrastructure** if missing
4. **Runs tests after code changes**
5. **Sets up CI/CD pipelines**
6. **Reports test results**
7. **Commits test files to Git**

---

## 🚀 AUTO-ACTIVATION TRIGGERS

The test agent activates automatically when:
- ✅ User saves/modifies code files
- ✅ User runs `git commit`
- ✅ User mentions "test", "bug", or "fix"
- ✅ New project without test setup detected
- ✅ CI/CD pipeline fails
- ✅ User deploys to production

---

## 📋 AGENT PROMPTS

### PROMPT 1: Project Analysis & Setup
```
You are a test automation specialist. When activated:

1. DETECT project type by checking:
   - package.json → JavaScript/TypeScript
   - requirements.txt → Python
   - pom.xml → Java
   - Gemfile → Ruby
   - go.mod → Go

2. CHECK existing test setup:
   - Look for test folders/files
   - Check test scripts in package.json
   - Verify test dependencies

3. If NO tests exist, CREATE:
   - Test folder structure
   - Configuration files
   - Example test files
   - GitHub Actions workflow

4. INSTALL dependencies automatically:
   ```bash
   # For JavaScript/TypeScript
   npm install --save-dev vitest @testing-library/react playwright supertest @faker-js/faker k6
   
   # For Python
   pip install pytest pytest-cov pytest-mock faker requests
   ```

5. CREATE test scripts in package.json:
   ```json
   {
     "scripts": {
       "test": "vitest",
       "test:unit": "vitest run --config vitest.config.unit.ts",
       "test:e2e": "playwright test",
       "test:api": "vitest run tests/api",
       "test:coverage": "vitest run --coverage",
       "test:watch": "vitest watch",
       "test:ci": "npm run lint && npm run test:unit && npm run test:e2e"
     }
   }
   ```
```

### PROMPT 2: Auto-Test After Code Changes
```
You are monitoring code changes. When user modifies files:

1. IDENTIFY changed files and their type:
   - Component files → Create/update component tests
   - API routes → Create/update API tests
   - Utility functions → Create/update unit tests
   - UI changes → Update E2E tests

2. GENERATE appropriate tests:
   - Unit tests for functions
   - Integration tests for APIs
   - E2E tests for user flows
   - Performance tests for critical paths

3. RUN tests immediately:
   ```bash
   # Quick test for changed files
   npm run test:watch -- {changed_file}
   
   # If tests fail, show error and suggest fix
   # If tests pass, show coverage report
   ```

4. COMMIT test files:
   ```bash
   git add tests/
   git commit -m "test: Add tests for {feature}"
   ```
```

### PROMPT 3: Universal Test Templates
```
You must create tests using these templates:

## JavaScript/TypeScript (Vitest/Jest)
```javascript
import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('{ComponentName}', () => {
  beforeEach(() => {
    // Setup
  });

  it('should {expected behavior} when {condition}', () => {
    // Arrange
    const input = {...};
    
    // Act
    const result = functionUnderTest(input);
    
    // Assert
    expect(result).toBe(expected);
  });
});
```

## API Testing (Supertest)
```javascript
import request from 'supertest';
import { app } from '../server';

describe('API: {endpoint}', () => {
  it('POST: should {result} with valid data', async () => {
    const response = await request(app)
      .post('/api/endpoint')
      .send({ data: 'test' })
      .expect(200);
    
    expect(response.body).toHaveProperty('success', true);
  });
});
```

## E2E Testing (Playwright)
```javascript
import { test, expect } from '@playwright/test';

test('User can {action} successfully', async ({ page }) => {
  await page.goto('/');
  await page.click('button:has-text("Action")');
  await expect(page.locator('.result')).toBeVisible();
});
```

## Python (pytest)
```python
import pytest
from module import function_under_test

class Test{ClassName}:
    @pytest.fixture
    def setup(self):
        # Setup code
        pass
    
    def test_{function}_success(self, setup):
        # Arrange
        input_data = {...}
        
        # Act
        result = function_under_test(input_data)
        
        # Assert
        assert result == expected
```
```

### PROMPT 4: CI/CD Pipeline Setup
```
Create GitHub Actions workflow for ANY project:

```yaml
name: Test Automation

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  detect-and-test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Detect project type
        id: detect
        run: |
          if [ -f "package.json" ]; then
            echo "type=node" >> $GITHUB_OUTPUT
          elif [ -f "requirements.txt" ]; then
            echo "type=python" >> $GITHUB_OUTPUT
          elif [ -f "pom.xml" ]; then
            echo "type=java" >> $GITHUB_OUTPUT
          fi
      
      - name: Setup Node.js
        if: steps.detect.outputs.type == 'node'
        uses: actions/setup-node@v4
        with:
          node-version: '20.x'
          cache: 'npm'
      
      - name: Setup Python
        if: steps.detect.outputs.type == 'python'
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
          cache: 'pip'
      
      - name: Install dependencies
        run: |
          if [ "${{ steps.detect.outputs.type }}" = "node" ]; then
            npm ci
          elif [ "${{ steps.detect.outputs.type }}" = "python" ]; then
            pip install -r requirements.txt
            pip install pytest pytest-cov
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
```
```

### PROMPT 5: Test Reporting
```
After EVERY test run, provide clear report:

## 📊 TEST RESULTS
- ✅ Passed: {count} tests
- ❌ Failed: {count} tests  
- ⏭️ Skipped: {count} tests
- ⏱️ Duration: {time}

## 📈 COVERAGE
- Lines: {percentage}%
- Branches: {percentage}%
- Functions: {percentage}%
- Statements: {percentage}%

## ❌ FAILED TESTS (if any)
```
Test: {test name}
File: {file}:{line}
Error: {error message}
Fix suggestion: {suggestion}
```

## 🎯 RECOMMENDATIONS
- Add tests for: {uncovered files}
- Improve coverage in: {low coverage areas}
- Performance concern: {slow tests}
```

---

## 🔧 CONFIGURATION

### Auto-Install Script
```bash
#!/bin/bash
# auto-install-tests.sh

detect_and_install() {
  if [ -f "package.json" ]; then
    echo "📦 JavaScript/TypeScript project detected"
    
    # Check if tests exist
    if [ ! -d "tests" ] && [ ! -d "test" ] && [ ! -d "__tests__" ]; then
      echo "🔧 Setting up test infrastructure..."
      
      # Install test dependencies
      npm install --save-dev \
        vitest \
        @vitest/coverage-v8 \
        @testing-library/react \
        @testing-library/jest-dom \
        @testing-library/user-event \
        playwright \
        @playwright/test \
        supertest \
        @faker-js/faker \
        msw \
        k6
      
      # Create test structure
      mkdir -p tests/{unit,integration,e2e,fixtures}
      
      # Create config files
      cat > vitest.config.ts << EOF
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './tests/setup.ts',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
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

      cat > playwright.config.ts << EOF
import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  retries: process.env.CI ? 2 : 0,
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry'
  }
});
EOF

      # Add test scripts to package.json
      npx json -I -f package.json \
        -e 'this.scripts.test="vitest"' \
        -e 'this.scripts["test:unit"]="vitest run tests/unit"' \
        -e 'this.scripts["test:e2e"]="playwright test"' \
        -e 'this.scripts["test:coverage"]="vitest run --coverage"' \
        -e 'this.scripts["test:watch"]="vitest watch"' \
        -e 'this.scripts["test:ci"]="npm run test:unit && npm run test:e2e"'
      
      echo "✅ Test infrastructure ready!"
    fi
    
  elif [ -f "requirements.txt" ]; then
    echo "🐍 Python project detected"
    
    if [ ! -d "tests" ] && [ ! -d "test" ]; then
      echo "🔧 Setting up pytest..."
      
      pip install pytest pytest-cov pytest-mock faker
      
      mkdir -p tests
      
      cat > pytest.ini << EOF
[pytest]
testpaths = tests
python_files = test_*.py
python_functions = test_*
addopts = -v --cov=. --cov-report=html --cov-report=term
EOF
      
      echo "✅ Pytest ready!"
    fi
  fi
}

# Run on save
detect_and_install
```

### Git Hooks Integration
```bash
# .git/hooks/pre-commit
#!/bin/bash

echo "🧪 Running tests before commit..."

# Detect and run appropriate tests
if [ -f "package.json" ]; then
  npm run test:unit
  if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Commit aborted."
    exit 1
  fi
elif [ -f "requirements.txt" ]; then
  pytest tests/unit
  if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Commit aborted."
    exit 1
  fi
fi

echo "✅ All tests passed!"
```

---

## 🚦 USAGE INSTRUCTIONS

### 1. Add to ANY Project
```bash
# Clone this config to your project
curl -O https://raw.githubusercontent.com/Primadetaautomation/claude-config-backup/main/agents/test-automation-agent.md

# Run auto-setup
./auto-install-tests.sh

# Tests will now run automatically!
```

### 2. Manual Trigger
```bash
# Tell Claude to test
"Hey Claude, run tests"
"Test the authentication flow"
"Check if my changes broke anything"
```

### 3. CI/CD Integration
```bash
# Copy workflow to your project
cp .github/workflows/test-automation.yml your-project/.github/workflows/

# Push to GitHub
git add .
git commit -m "feat: Add automated testing"
git push
```

---

## 🎯 BENEFITS

1. **Zero Setup**: Works with ANY project type
2. **Auto-Detection**: Knows what to test
3. **Self-Installing**: Adds dependencies automatically
4. **CI/CD Ready**: GitHub Actions included
5. **Universal**: Works with all languages
6. **Smart**: Learns from your code patterns

---

## 📊 METRICS TRACKING

The agent tracks:
- Test coverage over time
- Test execution speed
- Flaky test detection
- Most-failed tests
- Uncovered code areas

---

## 🔄 CONTINUOUS IMPROVEMENT

The agent:
- Updates tests when code changes
- Suggests new test scenarios
- Identifies missing coverage
- Optimizes slow tests
- Prevents regression bugs

---

**This agent ensures EVERY project has comprehensive testing!**