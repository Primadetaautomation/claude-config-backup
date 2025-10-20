# Agent Skills - Quick Start Guide

## 🚀 What You Need to Know

Agent Skills are **smart bundles of patterns + scripts** that Claude loads automatically based on your task.

## 💡 How It Works

1. **You ask:** "Create a secure login API"
2. **Claude detects:** backend + security + auth keywords
3. **Auto-loads:**
   - `backend-development-patterns` → API design
   - `security-essentials` → Auth patterns
   - `testing-fundamentals` → TDD workflow
4. **Claude codes** with full context

## 📦 5 Core Skills Available

| Skill | Use For | Agent |
|-------|---------|-------|
| `production-code-standards` | Quality code, TDD, reviews | senior-fullstack-developer |
| `security-essentials` | Auth, OWASP, security | security-specialist |
| `testing-fundamentals` | Tests, coverage, QA | qa-testing-engineer |
| `deployment-workflows` | CI/CD, deploy, infrastructure | devops-deployment-engineer |
| `backend-development-patterns` | APIs, databases, backend | senior-fullstack-developer |

## 🎯 Common Scenarios

### Scenario 1: Build New Feature
```
You: "Create user registration with email verification"

Claude loads:
✓ production-code-standards (TDD workflow)
✓ backend-development-patterns (API design)
✓ security-essentials (input validation)
✓ testing-fundamentals (test patterns)
```

### Scenario 2: Security Review
```
You: "Review my auth code for vulnerabilities"

Claude loads:
✓ security-essentials (OWASP Top 10)
✓ production-code-standards (code review checklist)

Claude runs:
✓ security-scan.sh (automated security check)
```

### Scenario 3: Deploy to Production
```
You: "Set up CI/CD pipeline"

Claude loads:
✓ deployment-workflows (pipeline configs)
✓ security-essentials (deployment security)

Claude provides:
✓ GitHub Actions workflow
✓ Docker configuration
✓ Health check endpoints
```

## 🔧 Using the CLI

### Discover Skills for Your Task
```bash
node ~/.claude/skills/skill-loader.js discover "create REST API"
# Output: backend-development-patterns, security-essentials, testing-fundamentals
```

### List All Skills
```bash
node ~/.claude/skills/skill-loader.js list
```

### Load Specific Skill
```bash
# Level 1 - Quick reference
node ~/.claude/skills/skill-loader.js load security-essentials 1

# Level 2 - Detailed patterns
node ~/.claude/skills/skill-loader.js load security-essentials 2

# Level 3 - Including scripts
node ~/.claude/skills/skill-loader.js load security-essentials 3
```

### Check Skills for Agent
```bash
node ~/.claude/skills/skill-loader.js agent senior-fullstack-developer
```

## 📊 Context Levels Explained

### Level 1: Minimal (Auto-loaded)
- ✅ Core principles
- ✅ Quick reference
- ✅ ~2-5KB
- **When:** Always loaded first

### Level 2: Detailed (On request)
- ✅ Complete patterns
- ✅ Detailed examples
- ✅ ~10-15KB
- **When:** Complex implementations

### Level 3: Full (When needed)
- ✅ All scripts
- ✅ Templates
- ✅ Automation tools
- **When:** Need executable tools

## 🎨 Skills vs Docs vs Agents

```
┌─────────────────────────────────────┐
│ YOUR QUESTION                        │
│ "Build secure login"                 │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ AGENT SELECTED                       │
│ senior-fullstack-developer           │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ SKILLS AUTO-LOADED                   │
│ • security-essentials                │
│ • backend-development-patterns       │
│ • testing-fundamentals               │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ PROJECT DOCS REFERENCED              │
│ • docs/backend.md                    │
│ • docs/security.md                   │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ CODE GENERATED                       │
│ Production-ready implementation      │
└─────────────────────────────────────┘
```

## 🏃 Quick Commands

### Run Quality Gate
```bash
.claude/skills/production-code-standards/scripts/pre-commit-check.sh
```

### Run Security Scan
```bash
.claude/skills/security-essentials/scripts/security-scan.sh
```

### Check Skill Structure
```bash
tree .claude/skills/
```

## ✅ Best Practices

### DO ✅
- Let Claude auto-load skills (trust the system)
- Start with Level 1, escalate if needed
- Use specific skills over general ones
- Run provided scripts for validation

### DON'T ❌
- Don't manually load all skills at once
- Don't skip Level 1 (it's optimized)
- Don't modify skills without versioning
- Don't load Level 3 for simple tasks

## 🔍 Troubleshooting

### Skill not loading?
```bash
# Check if skill exists
ls ~/.claude/skills/
```

### Need to update skills?
```bash
# Pull latest from your setup
cd ~/.claude/skills/
git pull  # if versioned
```

### Script not working?
```bash
# Make executable
chmod +x ~/.claude/skills/*/scripts/*.sh
```

## 📚 Learn More

- Full documentation: `.claude/skills/README.md`
- CLAUDE Framework: `~/CLAUDE.md`
- Subagents config: `~/claude-subagents-enhanced.md`

## 💬 Examples in Plain English

**"I need users to log in"**
→ Loads: security-essentials, backend-development-patterns

**"Write tests for my API"**
→ Loads: testing-fundamentals, backend-development-patterns

**"Deploy to production"**
→ Loads: deployment-workflows, security-essentials

**"Review my code quality"**
→ Loads: production-code-standards

**"Make it secure"**
→ Loads: security-essentials

## 🎯 Success Indicators

You're using skills effectively when:
- ✅ Claude loads 2-3 relevant skills per task
- ✅ Context stays under 100K tokens
- ✅ First-time implementation success rate > 70%
- ✅ Security/quality issues caught early
- ✅ Less back-and-forth clarification needed

---

**That's it!** Just describe your task naturally and Claude will load the right skills automatically. 🚀
