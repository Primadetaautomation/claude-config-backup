# Agent Skills System

## Overview

Agent Skills are **organized bundles of instructions, patterns, scripts, and resources** that Claude Code agents can discover and load dynamically to enhance their capabilities for specific tasks.

This implementation follows Anthropic's Agent Skills framework as described in their [engineering blog](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills).

## What Are Agent Skills?

Agent Skills transform general-purpose agents into specialized agents by providing:

1. **Progressive Context Disclosure** - Load only what's needed (Levels 1-3)
2. **Reusable Patterns** - Proven implementation examples
3. **Executable Scripts** - Automation tools and utilities
4. **Dynamic Discovery** - Auto-load based on task intent

## Benefits Over Traditional Docs

| Traditional Docs | Agent Skills |
|-----------------|--------------|
| Static markdown files | Dynamic context loading |
| All or nothing loading | Progressive disclosure (3 levels) |
| Scattered across project | Organized bundles |
| Documentation only | Docs + Scripts + Tools |
| Manual discovery | Automatic intent detection |

## Available Skills

### 1. production-code-standards
**Purpose:** Production-ready code following CLAUDE Framework
**Triggers:** production, code quality, TDD, best practices, SOLID
**Agents:** senior-fullstack-developer, code-refactoring-specialist
**Location:** `.claude/skills/production-code-standards/`

**Contains:**
- SOLID principles and patterns
- Error handling best practices
- Code quality checklist
- Pre-commit quality gate script

**When to use:**
- Creating new features
- Code reviews
- Refactoring legacy code
- Quality validation

### 2. security-essentials
**Purpose:** OWASP compliance, authentication, vulnerability prevention
**Triggers:** security, auth, OWASP, vulnerability, XSS, CSRF
**Agents:** security-specialist, senior-fullstack-developer
**Location:** `.claude/skills/security-essentials/`

**Contains:**
- OWASP Top 10 quick reference
- Input validation patterns
- Authentication implementations
- Security scanning scripts

**When to use:**
- Implementing auth/authorization
- Security reviews
- Handling sensitive data
- Compliance requirements

### 3. testing-fundamentals
**Purpose:** TDD workflow, comprehensive test strategies
**Triggers:** test, TDD, coverage, unit test, integration test, e2e
**Agents:** qa-testing-engineer, senior-fullstack-developer
**Location:** `.claude/skills/testing-fundamentals/`

**Contains:**
- Red-Green-Refactor workflow
- AAA pattern examples
- Test data factories
- Coverage requirements (80%+)

**When to use:**
- Implementing new features (TDD)
- Creating test suites
- Analyzing coverage gaps
- Quality validation

### 4. deployment-workflows
**Purpose:** CI/CD pipelines, zero-downtime deployments
**Triggers:** deploy, CI/CD, pipeline, production, kubernetes, docker
**Agents:** devops-deployment-engineer, solutions-architect
**Location:** `.claude/skills/deployment-workflows/`

**Contains:**
- GitHub Actions pipelines
- Zero-downtime strategies
- Health check patterns
- Rollback procedures

**When to use:**
- Setting up CI/CD
- Production deployments
- Infrastructure automation
- Disaster recovery

### 5. backend-development-patterns
**Purpose:** API design, database patterns, microservices
**Triggers:** api, backend, REST, GraphQL, database, microservices
**Agents:** senior-fullstack-developer, database-migration-specialist
**Location:** `.claude/skills/backend-development-patterns/`

**Contains:**
- REST/GraphQL best practices
- Repository pattern
- Service layer pattern
- Authentication/authorization

**When to use:**
- Designing APIs
- Database schema design
- Backend architecture
- Microservices patterns

## Progressive Context Loading

Skills use 3 levels to minimize context usage:

### Level 1: Minimal (Always Loaded)
- Core principles
- Quick reference
- Critical rules
- Examples: ~2-3KB

**Example:**
```javascript
const skill = loadSkill('security-essentials', 1);
// Loads: OWASP quick reference, input validation examples
```

### Level 2: Detailed (Load on Request)
- Complete patterns
- Detailed examples
- Architecture guidance
- Examples: ~10-15KB

**Example:**
```javascript
const skill = loadSkill('backend-development-patterns', 2);
// Loads: Level 1 + Repository pattern + Service layer + Advanced examples
```

### Level 3: Full (Load When Needed)
- Executable scripts
- Templates
- Automation tools
- Examples: Full skill directory

**Example:**
```javascript
const skill = loadSkill('deployment-workflows', 3);
// Loads: Level 1 + Level 2 + All scripts in scripts/
```

## Using Skills

### Automatic Discovery

Claude Code automatically discovers and loads skills based on your task:

```bash
# User asks
"I need to create a secure login API"

# Claude automatically loads:
- security-essentials (Level 1)
- backend-development-patterns (Level 1)
- testing-fundamentals (Level 1)
```

### Manual Loading

Use the skill-loader utility:

```bash
# Discover skills for a task
node .claude/skills/skill-loader.js discover "create REST API with auth"

# List all skills
node .claude/skills/skill-loader.js list

# Show skills for specific agent
node .claude/skills/skill-loader.js agent senior-fullstack-developer

# Load skill content
node .claude/skills/skill-loader.js load security-essentials 2
```

### In Agent Prompts

Reference skills in your agent configurations:

```json
{
  "name": "senior-fullstack-developer",
  "skills": [
    "production-code-standards",
    "backend-development-patterns",
    "testing-fundamentals"
  ],
  "skill_loading": "dynamic"
}
```

## Creating New Skills

### 1. Create Skill Directory

```bash
mkdir -p .claude/skills/my-new-skill/{scripts,templates,examples}
```

### 2. Create SKILL.md

```markdown
---
name: my-new-skill
description: Brief description of what this skill provides
triggers: [keyword1, keyword2, keyword3]
version: 1.0.0
agents: [agent1, agent2]
context_levels:
  minimal: Core concepts
  detailed: Complete patterns
  full: Scripts and templates
---

# My New Skill

## Overview
What this skill provides...

## When to Use This Skill
- Use case 1
- Use case 2

## Core Patterns (Level 1 - Always Loaded)
Essential patterns here...

## Detailed Patterns (Level 2 - Load on Request)
See companion files...

## Scripts & Tools (Level 3 - Load When Needed)
See scripts directory...
```

### 3. Add to skill-loader.js

Update the `skillMetadata` object:

```javascript
const skillMetadata = {
  'my-new-skill': {
    triggers: ['keyword1', 'keyword2'],
    agents: ['agent1', 'agent2'],
    description: 'Brief description'
  },
  // ... other skills
};
```

## Best Practices

### Skill Design
- **Keep Level 1 lean** (< 5KB) - Core principles only
- **Split complex patterns** into Level 2 files
- **Bundle executable scripts** in scripts/ directory
- **Use clear naming** for files and patterns
- **Version your skills** for backward compatibility

### Context Optimization
- Start with Level 1, escalate if needed
- Don't load multiple Level 3 skills simultaneously
- Use skill discovery to select relevant skills
- Prefer specific skills over general ones

### Agent Integration
- Assign 3-5 core skills per agent
- Load additional skills dynamically based on task
- Run parallel agents with different skill sets
- Share skills across agent types when applicable

## Integration with Existing System

### Skills vs Docs

**Skills** (`.claude/skills/`):
- ✅ Reusable across projects
- ✅ Bundled with scripts/tools
- ✅ Progressive disclosure
- ✅ Agent-specific

**Docs** (`docs/`):
- ✅ Project-specific
- ✅ Team documentation
- ✅ Architecture decisions
- ✅ Project context

Use both: Skills for reusable patterns, Docs for project specifics.

### Skills vs Subagents

**Skills** = Knowledge bundles (what to do)
**Subagents** = Specialized workers (who does it)

Subagents **use** skills to perform tasks:
```
Senior-Fullstack-Developer Agent
  ├── Uses: production-code-standards
  ├── Uses: backend-development-patterns
  └── Uses: testing-fundamentals
```

## Troubleshooting

### Skill Not Found
```bash
# Check if skill exists
ls .claude/skills/
node .claude/skills/skill-loader.js list
```

### Skill Not Loading
```bash
# Verify SKILL.md exists
cat .claude/skills/my-skill/SKILL.md

# Check frontmatter format (YAML)
```

### Script Not Executable
```bash
# Make scripts executable
chmod +x .claude/skills/*/scripts/*.sh
```

## Examples

### Example 1: Creating a Secure API

**Task:** "Build a REST API with authentication"

**Skills auto-loaded:**
1. `backend-development-patterns` (Level 1) - API design
2. `security-essentials` (Level 1) - Auth patterns
3. `testing-fundamentals` (Level 1) - TDD workflow

**Agent used:** `senior-fullstack-developer`

### Example 2: Security Review

**Task:** "Review my authentication code for vulnerabilities"

**Skills auto-loaded:**
1. `security-essentials` (Level 2) - OWASP Top 10 details
2. `production-code-standards` (Level 1) - Code review checklist

**Agent used:** `security-specialist`

**Scripts executed:**
- `security-essentials/scripts/security-scan.sh`

### Example 3: Deployment Setup

**Task:** "Set up CI/CD pipeline for production"

**Skills auto-loaded:**
1. `deployment-workflows` (Level 2) - Pipeline configs
2. `security-essentials` (Level 1) - Security checklist

**Agent used:** `devops-deployment-engineer`

**Templates used:**
- GitHub Actions workflow
- Docker multi-stage build

## Metrics

Track skill usage and effectiveness:

- Skill load frequency
- Context size savings
- Task completion rate by skill
- Average iterations per skill
- Agent + Skill combinations

Store in: `.claude-memory/skills-metrics.md`

## Future Enhancements

Planned improvements:
- [ ] Automatic skill version updates
- [ ] Skill dependency management
- [ ] Community skill sharing
- [ ] Skill effectiveness analytics
- [ ] IDE integration for skill preview

## Resources

- [Anthropic Agent Skills Blog Post](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
- [CLAUDE Framework Documentation](../CLAUDE.md)
- [Subagents Configuration](../../claude-subagents-enhanced.md)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Compatible with:** Claude Code 1.0+, Claude 3.5 Sonnet+
