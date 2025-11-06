# 🚀 Claude Dev Toolkit - Complete Development Plugin

**🇬🇧 English** | [🇳🇱 Nederlands](#-nederlandse-versie)

**Version 1.0.0 - Claude Code Plugin**

The ultimate Claude Code plugin for modern software development: 38 specialized agents, 6 core skills, defensive programming toolkit, Playwright optimization, and comprehensive automation scripts.

---

## 🎯 What is this?

**NEW:** This is now a **Claude Code Plugin** - installable with a single command!

A complete development ecosystem previously used as a backup configuration, now transformed into a professional Claude Code plugin. Everything you need for production-ready development, packaged in an easy-to-install format.

---

## ⚡ Quick Install

```bash
# Add the marketplace
/plugin marketplace add Primadetaautomation/claude-config-backup

# Install the plugin
/plugin install claude-dev-toolkit
```

**That's it!** All 38 agents, 6 skills, and tools are now available in Claude Code.

---

## 📦 What's Included

### 🤖 38 Specialized Agents

#### **Core Development (6)**
- `senior-fullstack-developer` - Production-ready fullstack development with TDD
- `backend-specialist` - API design, databases, Node.js/Python server architecture
- `frontend-specialist` - React/Vue/Next.js, Tailwind CSS, responsive design
- `database-architect` - Database design, optimization, migrations
- `solutions-architect` - System architecture, tech stack decisions, scalability
- `ux-ui-designer` - UI/UX design, Figma-to-code implementation

#### **Testing & QA (5)**
- `playwright-test-agent` - Browser automation, E2E testing, visual regression
- `qa-testing-engineer` - Test strategy, coverage analysis, quality assurance
- `test-automation-agent` - Automated testing pipelines, CI/CD integration
- `performance-testing-agent` - Load testing, performance optimization
- `accessibility-specialist` - WCAG compliance, inclusive design, ARIA

#### **Security & Compliance (3)**
- `security-compliance-agent` - Security best practices, OWASP Top 10
- `threat-modeling` - Threat analysis, risk assessment
- `lint-code-quality` - Code quality, linting, standards enforcement

#### **Data & ML/AI (3)**
- `data-engineer` - ETL/ELT pipelines, data warehouse design
- `ml-ai-integration` - LLM integration, RAG systems, vector databases
- `sql-universal-expert` - SQL optimization, query design

#### **DevOps & Infrastructure (4)**
- `devops-automation-agent` - CI/CD, infrastructure automation
- `monitoring-observability` - Logging, metrics, alerting
- `context7-documentation` - Real-time documentation fetching
- `session-memory-agent` - Session continuity management

#### **Specialized (7)**
- `n8n-workflow-creator` - n8n workflow automation
- `documentation-agent` - Technical documentation, API docs
- `master-orchestrator` - Multi-agent project coordination
- `context_manager_agent` - Dynamic context window management
- Plus more specialized agents for comprehensive development

[View all 38 agents →](agents/)

### 🎯 6 Core Skills (Progressive Disclosure)

Each skill loads only what you need, when you need it:

1. **production-code-standards** - SOLID principles, TDD, error handling
2. **security-essentials** - OWASP compliance, secret management, GDPR
3. **testing-fundamentals** - Test strategy, coverage, AAA pattern
4. **deployment-workflows** - CI/CD, zero-downtime deployments
5. **backend-development-patterns** - API design, repositories, services
6. **multi-tenant-patterns** - SaaS development, tenant isolation, RLS

[View all skills →](skills/)

### 🛠️ Advanced Development Toolkit

Extracted from Microsoft Amplifier:

- **Defensive Programming** (Python) - Safe LLM integration, retry patterns
- **Knowledge Extraction** - Extract and query codebase documentation
- **Transcript Management** - Auto-save conversations, search history
- **Git Worktrees** - Parallel development workflows

[View toolkit docs →](toolkit/)

### 🎭 Playwright Optimization

Complete Playwright setup with performance tuning:
- Optimized configuration (`playwright.config.ts`)
- Custom test scripts
- CPU optimization guide
- Browser automation best practices

### 📚 Comprehensive Documentation

Complete guides included:
- Backend Development
- Frontend Development
- Security & GDPR
- Infrastructure & Deployment
- Testing Strategies
- Chrome DevTools Integration
- Vitest Process Management

[View all docs →](docs/)

### ⚡ Automation Scripts

```bash
scripts/
├── auto-test-setup.sh           # Automated test environment
├── deploy-codex-agents.sh       # Agent deployment
├── kill-vitest.sh               # Kill stuck processes
├── memory-cleanup.sh            # Session cleanup
├── scan-secrets.sh              # Secret scanning (gitleaks)
└── setup-chrome-devtools.sh     # Chrome DevTools MCP
```

---

## 💡 Usage Examples

### Using Agents

```
You: "Use senior-fullstack-developer to build authentication"
Claude: *Loads agent with TDD, security, production standards*

You: "Use playwright-test-agent for E2E tests"
Claude: *Creates comprehensive browser automation tests*

You: "Use security-compliance-agent to review this API"
Claude: *Performs OWASP Top 10 security analysis*
```

### Automatic Skill Loading

Claude automatically loads relevant skills:

```
You: "Help me implement user authentication"
→ Auto-loads: security-essentials, backend-development-patterns

You: "Build a multi-tenant SaaS application"
→ Auto-loads: multi-tenant-patterns, security-essentials

You: "Create E2E tests for my app"
→ Auto-loads: testing-fundamentals, production-code-standards
```

---

## 🔄 Updates

```bash
# Check for updates
/plugin update claude-dev-toolkit
```

---

## 🎯 Perfect For

- ✅ Fullstack developers building production applications
- ✅ Teams using TDD and quality-first development
- ✅ SaaS developers needing multi-tenant patterns
- ✅ Security-conscious development teams
- ✅ QA engineers implementing comprehensive testing
- ✅ DevOps teams automating CI/CD pipelines
- ✅ ML/AI integration projects
- ✅ Accessibility-focused development

---

## 📂 Plugin Structure

```
claude-dev-toolkit/
├── .claude-plugin/
│   └── plugin.json              # Plugin metadata
├── agents/ (38 specialized agents)
├── skills/ (6 core skills)
├── toolkit/ (defensive programming, knowledge extraction)
├── scripts/ (automation scripts)
├── docs/ (comprehensive documentation)
├── memory/ (session templates)
└── README.md
```

---

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📜 License

MIT License - Free to use and modify

---

## 🔗 Links

- **GitHub**: https://github.com/Primadetaautomation/claude-config-backup
- **Issues**: https://github.com/Primadetaautomation/claude-config-backup/issues

---

<a id="-nederlandse-versie"></a>

# 🚀 Claude Dev Toolkit - Complete Development Plugin

**[🇬🇧 English](#-claude-dev-toolkit---complete-development-plugin)** | **🇳🇱 Nederlands**

**Versie 1.0.0 - Claude Code Plugin**

De ultieme Claude Code plugin voor moderne software development: 38 gespecialiseerde agents, 6 core skills, defensive programming toolkit, Playwright optimalisatie, en uitgebreide automation scripts.

---

## 🎯 Wat is dit?

**NIEUW:** Dit is nu een **Claude Code Plugin** - installeerbaar met één commando!

Een compleet development ecosystem dat voorheen als backup configuratie werd gebruikt, nu getransformeerd naar een professionele Claude Code plugin. Alles wat je nodig hebt voor production-ready development, verpakt in een makkelijk te installeren format.

---

## ⚡ Snelle Installatie

```bash
# Voeg marketplace toe
/plugin marketplace add Primadetaautomation/claude-config-backup

# Installeer de plugin
/plugin install claude-dev-toolkit
```

**Dat is alles!** Alle 38 agents, 6 skills, en tools zijn nu beschikbaar in Claude Code.

---

## 📦 Wat zit erin

### 🤖 38 Gespecialiseerde Agents

#### **Core Development (6)**
- `senior-fullstack-developer` - Production-ready fullstack development met TDD
- `backend-specialist` - API design, databases, Node.js/Python server architectuur
- `frontend-specialist` - React/Vue/Next.js, Tailwind CSS, responsive design
- `database-architect` - Database design, optimalisatie, migraties
- `solutions-architect` - Systeem architectuur, tech stack beslissingen, schaalbaarheid
- `ux-ui-designer` - UI/UX design, Figma-to-code implementatie

#### **Testing & QA (5)**
- `playwright-test-agent` - Browser automatisering, E2E testing, visual regression
- `qa-testing-engineer` - Test strategie, coverage analyse, quality assurance
- `test-automation-agent` - Geautomatiseerde test pipelines, CI/CD integratie
- `performance-testing-agent` - Load testing, performance optimalisatie
- `accessibility-specialist` - WCAG compliance, inclusive design, ARIA

#### **Security & Compliance (3)**
- `security-compliance-agent` - Security best practices, OWASP Top 10
- `threat-modeling` - Threat analyse, risk assessment
- `lint-code-quality` - Code kwaliteit, linting, standards enforcement

#### **Data & ML/AI (3)**
- `data-engineer` - ETL/ELT pipelines, data warehouse design
- `ml-ai-integration` - LLM integratie, RAG systemen, vector databases
- `sql-universal-expert` - SQL optimalisatie, query design

#### **DevOps & Infrastructure (4)**
- `devops-automation-agent` - CI/CD, infrastructure automation
- `monitoring-observability` - Logging, metrics, alerting
- `context7-documentation` - Real-time documentatie ophalen
- `session-memory-agent` - Sessie continuïteit management

#### **Gespecialiseerd (7)**
- `n8n-workflow-creator` - n8n workflow automatisering
- `documentation-agent` - Technische documentatie, API docs
- `master-orchestrator` - Multi-agent project coördinatie
- `context_manager_agent` - Dynamisch context window management
- Plus meer gespecialiseerde agents voor comprehensive development

[Bekijk alle 38 agents →](agents/)

### 🎯 6 Core Skills (Progressive Disclosure)

Elke skill laadt alleen wat je nodig hebt:

1. **production-code-standards** - SOLID principes, TDD, error handling
2. **security-essentials** - OWASP compliance, secret management, GDPR
3. **testing-fundamentals** - Test strategie, coverage, AAA pattern
4. **deployment-workflows** - CI/CD, zero-downtime deployments
5. **backend-development-patterns** - API design, repositories, services
6. **multi-tenant-patterns** - SaaS development, tenant isolatie, RLS

[Bekijk alle skills →](skills/)

### 🛠️ Advanced Development Toolkit

Geëxtraheerd uit Microsoft Amplifier:

- **Defensive Programming** (Python) - Veilige LLM integratie, retry patterns
- **Knowledge Extraction** - Codebase documentatie extractie en query
- **Transcript Management** - Auto-save conversaties, zoek geschiedenis
- **Git Worktrees** - Parallelle development workflows

[Bekijk toolkit docs →](toolkit/)

### 🎭 Playwright Optimalisatie

Complete Playwright setup met performance tuning:
- Geoptimaliseerde configuratie (`playwright.config.ts`)
- Custom test scripts
- CPU optimalisatie gids
- Browser automatisering best practices

### 📚 Uitgebreide Documentatie

Complete gidsen inbegrepen:
- Backend Development
- Frontend Development
- Security & GDPR
- Infrastructure & Deployment
- Testing Strategieën
- Chrome DevTools Integratie
- Vitest Process Management

[Bekijk alle docs →](docs/)

### ⚡ Automation Scripts

```bash
scripts/
├── auto-test-setup.sh           # Geautomatiseerde test omgeving
├── deploy-codex-agents.sh       # Agent deployment
├── kill-vitest.sh               # Kill vastzittende processen
├── memory-cleanup.sh            # Sessie cleanup
├── scan-secrets.sh              # Secret scanning (gitleaks)
└── setup-chrome-devtools.sh     # Chrome DevTools MCP
```

---

## 💡 Gebruik Voorbeelden

### Agents Gebruiken

```
Jij: "Gebruik senior-fullstack-developer om authenticatie te bouwen"
Claude: *Laadt agent met TDD, security, production standards*

Jij: "Gebruik playwright-test-agent voor E2E tests"
Claude: *Maakt uitgebreide browser automatisering tests*

Jij: "Gebruik security-compliance-agent om deze API te reviewen"
Claude: *Voert OWASP Top 10 security analyse uit*
```

### Automatische Skill Loading

Claude laadt automatisch relevante skills:

```
Jij: "Help me user authentication te implementeren"
→ Auto-laadt: security-essentials, backend-development-patterns

Jij: "Bouw een multi-tenant SaaS applicatie"
→ Auto-laadt: multi-tenant-patterns, security-essentials

Jij: "Maak E2E tests voor mijn app"
→ Auto-laadt: testing-fundamentals, production-code-standards
```

---

## 🔄 Updates

```bash
# Check voor updates
/plugin update claude-dev-toolkit
```

---

## 🎯 Perfect Voor

- ✅ Fullstack developers die production applicaties bouwen
- ✅ Teams die TDD en quality-first development gebruiken
- ✅ SaaS developers die multi-tenant patterns nodig hebben
- ✅ Security-bewuste development teams
- ✅ QA engineers die comprehensive testing implementeren
- ✅ DevOps teams die CI/CD pipelines automatiseren
- ✅ ML/AI integratie projecten
- ✅ Accessibility-focused development

---

## 📜 Licentie

MIT License - Gratis te gebruiken en aanpassen

---

## 🔗 Links

- **GitHub**: https://github.com/Primadetaautomation/claude-config-backup
- **Issues**: https://github.com/Primadetaautomation/claude-config-backup/issues

---

## 📋 Changelog

### v1.0.0 (2025-11-06)

**Initial plugin release**

- ✅ Transformed backup configuration to Claude Code plugin
- ✅ 38 specialized agents for all development aspects
- ✅ 6 core skills with progressive disclosure
- ✅ Complete defensive programming toolkit
- ✅ Playwright optimization and configs
- ✅ Automation scripts for common tasks
- ✅ Comprehensive documentation
- ✅ Session memory templates
- ✅ Multi-tenant SaaS patterns

---

**Made with ❤️ for the Claude Code community**

*Transform your Claude Code experience with professional-grade development tools*
