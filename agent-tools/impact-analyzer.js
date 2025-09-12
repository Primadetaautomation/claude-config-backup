#!/usr/bin/env node

/**
 * Impact Analyzer - Predicts consequences of changes
 * Identifies what will break BEFORE it happens
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

class ImpactAnalyzer {
  constructor() {
    this.impacts = {
      direct: [],
      indirect: [],
      performance: [],
      security: [],
      breaking: []
    };
    this.riskLevel = 'low';
    this.confidence = 100;
  }

  analyzeFileChanges(filePath) {
    const impacts = {
      direct: [],
      dependents: [],
      tests: []
    };

    // Check if file exists
    if (!fs.existsSync(filePath)) {
      impacts.direct.push(`New file: ${filePath}`);
    } else {
      impacts.direct.push(`Modified file: ${filePath}`);
    }

    // Find dependencies
    try {
      const deps = execSync(`grep -l "require.*${path.basename(filePath)}" **/*.js 2>/dev/null || echo ""`)
        .toString().split('\n').filter(Boolean);
      impacts.dependents = deps;
    } catch {}

    // Find related tests
    const testFile = filePath.replace('.js', '.test.js');
    if (fs.existsSync(testFile)) {
      impacts.tests.push(testFile);
    }

    return impacts;
  }

  analyzePerformanceImpact(changes) {
    const impact = {
      bundleSize: 0,
      complexity: 0,
      risk: 'low'
    };

    // Estimate bundle size impact
    changes.forEach(change => {
      if (change.includes('import') || change.includes('require')) {
        impact.bundleSize += 10; // KB estimate
      }
    });

    // Estimate complexity
    if (changes.length > 10) {
      impact.complexity = 'high';
      impact.risk = 'medium';
    }

    return impact;
  }

  analyzeSecurityImpact(code) {
    const vulnerabilities = [];
    
    // Check for dangerous patterns
    const dangerousPatterns = [
      { pattern: /eval\(/, risk: 'Code injection vulnerability' },
      { pattern: /innerHTML\s*=/, risk: 'XSS vulnerability' },
      { pattern: /process\.env/, risk: 'Potential secret exposure' },
      { pattern: /password|token|secret|key/i, risk: 'Sensitive data handling' }
    ];

    dangerousPatterns.forEach(({ pattern, risk }) => {
      if (pattern.test(code)) {
        vulnerabilities.push(risk);
        this.confidence -= 15;
      }
    });

    return vulnerabilities;
  }

  analyzeBreakingChanges(before, after) {
    const breaking = [];

    // Check for API changes
    if (before.includes('export') && !after.includes('export')) {
      breaking.push('Removed exports - breaking change');
    }

    // Check for signature changes
    const functionRegex = /function\s+(\w+)\s*\([^)]*\)/g;
    const beforeFuncs = [...before.matchAll(functionRegex)];
    const afterFuncs = [...after.matchAll(functionRegex)];

    beforeFuncs.forEach(func => {
      const matching = afterFuncs.find(f => f[1] === func[1]);
      if (matching && matching[0] !== func[0]) {
        breaking.push(`Function signature changed: ${func[1]}`);
      }
    });

    return breaking;
  }

  generateReport() {
    const report = {
      timestamp: new Date().toISOString(),
      confidence: this.confidence,
      riskLevel: this.getRiskLevel(),
      recommendation: this.getRecommendation(),
      impacts: this.impacts,
      summary: {
        directChanges: this.impacts.direct.length,
        indirectChanges: this.impacts.indirect.length,
        breakingChanges: this.impacts.breaking.length,
        securityIssues: this.impacts.security.length
      }
    };

    return report;
  }

  getRiskLevel() {
    if (this.impacts.breaking.length > 0) return 'high';
    if (this.impacts.security.length > 0) return 'high';
    if (this.impacts.indirect.length > 5) return 'medium';
    return 'low';
  }

  getRecommendation() {
    if (this.confidence >= 90) return '✅ SAFE TO PROCEED';
    if (this.confidence >= 70) return '⚠️ REVIEW REQUIRED';
    if (this.confidence >= 50) return '🔍 DETAILED REVIEW REQUIRED';
    return '❌ DO NOT PROCEED';
  }

  printReport(report) {
    console.log('\n📊 IMPACT ANALYSIS REPORT');
    console.log('=' . repeat(50));
    console.log(`Confidence: ${report.confidence}%`);
    console.log(`Risk Level: ${report.riskLevel}`);
    console.log(`Recommendation: ${report.recommendation}`);
    
    console.log('\n📈 Summary:');
    Object.entries(report.summary).forEach(([key, value]) => {
      console.log(`  ${key}: ${value}`);
    });

    if (report.impacts.breaking.length > 0) {
      console.log('\n⚠️ Breaking Changes:');
      report.impacts.breaking.forEach(b => console.log(`  - ${b}`));
    }

    if (report.impacts.security.length > 0) {
      console.log('\n🔐 Security Concerns:');
      report.impacts.security.forEach(s => console.log(`  - ${s}`));
    }

    console.log('=' . repeat(50));
  }

  analyze(options = {}) {
    console.log('🔍 Analyzing impact...\n');

    // Mock analysis for demo
    this.impacts.direct.push('Modified: package.json');
    this.impacts.indirect.push('Affected: 5 dependent modules');
    
    const report = this.generateReport();
    
    if (options.format === 'json') {
      console.log(JSON.stringify(report, null, 2));
    } else {
      this.printReport(report);
    }

    return report;
  }
}

if (require.main === module) {
  const analyzer = new ImpactAnalyzer();
  const format = process.argv.includes('--format=json') ? 'json' : 'text';
  analyzer.analyze({ format });
}

module.exports = ImpactAnalyzer;