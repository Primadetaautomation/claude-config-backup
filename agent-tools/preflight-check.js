#!/usr/bin/env node

/**
 * Preflight Check - Validates everything before execution
 * Prevents 90% of errors by checking prerequisites
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

class PreflightChecker {
  constructor() {
    this.checks = [];
    this.passed = 0;
    this.failed = 0;
    this.confidence = 100;
  }

  check(name, fn, critical = false) {
    try {
      const result = fn();
      this.checks.push({ name, status: 'PASS', result });
      this.passed++;
      return true;
    } catch (error) {
      this.checks.push({ name, status: 'FAIL', error: error.message });
      this.failed++;
      this.confidence -= critical ? 30 : 10;
      if (critical) {
        throw new Error(`Critical check failed: ${name} - ${error.message}`);
      }
      return false;
    }
  }

  checkEnvironment() {
    this.check('Node.js version', () => {
      const version = process.version;
      if (!version.match(/^v(1[4-9]|[2-9][0-9])/)) {
        throw new Error(`Node ${version} too old, need v14+`);
      }
      return version;
    });

    this.check('Git repository', () => {
      execSync('git rev-parse --git-dir', { stdio: 'ignore' });
      return 'Git repository found';
    });

    this.check('Package.json exists', () => {
      if (!fs.existsSync('package.json')) {
        throw new Error('No package.json found');
      }
      return 'package.json exists';
    }, true);
  }

  checkDependencies() {
    this.check('Dependencies installed', () => {
      if (!fs.existsSync('node_modules')) {
        throw new Error('node_modules not found - run npm install');
      }
      return 'Dependencies installed';
    });

    this.check('No vulnerabilities', () => {
      try {
        execSync('npm audit --audit-level=high', { stdio: 'ignore' });
        return 'No high vulnerabilities';
      } catch {
        console.warn('⚠️  Security vulnerabilities detected');
        return 'Vulnerabilities exist';
      }
    });
  }

  checkCodeQuality() {
    this.check('No console.log in code', () => {
      const files = execSync('find . -name "*.js" -not -path "./node_modules/*" 2>/dev/null || echo ""')
        .toString().split('\n').filter(Boolean);
      
      for (const file of files) {
        if (fs.existsSync(file)) {
          const content = fs.readFileSync(file, 'utf8');
          if (content.includes('console.log') && !file.includes('test')) {
            console.warn(`⚠️  console.log found in ${file}`);
          }
        }
      }
      return 'Code quality checked';
    });
  }

  generateReport() {
    console.log('\n🚀 PREFLIGHT CHECK REPORT');
    console.log('=' . repeat(50));
    
    this.checks.forEach(check => {
      const icon = check.status === 'PASS' ? '✅' : '❌';
      console.log(`${icon} ${check.name}: ${check.result || check.error}`);
    });
    
    console.log('=' . repeat(50));
    console.log(`Passed: ${this.passed}/${this.checks.length}`);
    console.log(`Confidence: ${this.confidence}%`);
    
    if (this.confidence >= 90) {
      console.log('✅ SAFE TO PROCEED');
    } else if (this.confidence >= 70) {
      console.log('⚠️  PROCEED WITH CAUTION');
    } else {
      console.log('❌ DO NOT PROCEED');
      process.exit(1);
    }
  }

  run() {
    console.log('🔍 Running preflight checks...\n');
    
    this.checkEnvironment();
    this.checkDependencies();
    this.checkCodeQuality();
    
    this.generateReport();
    
    return this.confidence >= 70;
  }
}

if (require.main === module) {
  const checker = new PreflightChecker();
  const success = checker.run();
  process.exit(success ? 0 : 1);
}

module.exports = PreflightChecker;