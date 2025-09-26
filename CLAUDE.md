# 🎯 Universele Coding Principes (CLAUDE)

Deze regels zorgen voor **hoogwaardige, veilige en maintainbare code**.  
**MUST = verplicht** | **SHOULD = aanbevolen** | **COULD = optioneel**

---

## 0 — Basis Missie
- Consistente codekwaliteit, beveiliging en documentatie.
- Code is **leesbaar voor de volgende developer**.
- **Efficiënte samenwerking met Claude voor foutloze code delivery**.
- **BM-1 (MUST)** Claude mag geen functionaliteit verzinnen, weglaten of overslaan.
- **BM-2 (MUST)** Claude volgt altijd de exacte vraag/opdracht van de gebruiker.
- **BM-3 (MUST)** Indien iets onduidelijk is → altijd vragen stellen, nooit aannames doen.

---

## 1 — Planning & Communicatie
- **P-1 (MUST)** Stel minimaal 3 clarifying questions vóór coding.
- **P-2 (MUST)** Maak een step-by-step plan en vraag expliciet om akkoord.
- **P-3 (MUST)** Bij meerdere opties: comparison table met pros/cons.
- **P-4 (MUST)** Definieer acceptance criteria.
- **P-5 (SHOULD)** Geef complexity level (Simple/Medium/Complex).
- **P-6 (MUST)** Leg altijd **WAAROM** je keuzes maakt.
- **P-7 (MUST)** Documenteer impact op bestaande code.
- **P-8 (SHOULD)** Noem welke files je gaat aanpassen.

---

## 2 — Code Kwaliteit
- **C-1 (MUST)** Single Responsibility Principle.
- **C-2 (MUST)** DRY (geen duplicatie).
- **C-3 (MUST)** KISS (simpel > complex).
- **C-4 (MUST)** Functions max 20 regels.
- **C-5 (SHOULD)** Composition > inheritance.
- **N-1 t/m N-6 (MUST)** Naming conventions (beschrijvend, verb/noun, booleans met `is/has`, constants in CAPS).
- **S-1 (MUST)** Consistente indentatie (2 of 4 spaces).
- **S-2 (MUST)** Max 120 karakters per regel.
- **S-3 (SHOULD)** Comments alleen voor **WHY**, niet WHAT.

---

## 3 — Error Handling
- **E-1 (MUST)** Handle alle error scenarios.
- **E-2 (MUST)** Specifieke error types/messages.
- **E-3 (MUST)** Logging mét context.
- **E-4 (MUST NOT)** Silent failures.
- **E-5 (SHOULD)** Fail fast: inputs vroeg valideren.

**Logging**
- **L-1 (MUST)** Structured logs (JSON waar mogelijk).
- **L-2 (MUST NOT)** Geen gevoelige data loggen.
- **L-3 (SHOULD)** Gebruik correlation IDs.
- **L-4 (SHOULD)** Levels: DEBUG, INFO, WARN, ERROR.

---

## 4 — Testing
- **T-1 (MUST)** TDD (Red → Green → Refactor).
- **T-2 (MUST)** Minimaal 80% coverage nieuwe code.
- **T-3 (MUST)** Test happy path, errors, edge cases.
- **TQ-1 (MUST)** Beschrijvende testnamen.
- **TQ-2 (MUST)** Arrange-Act-Assert pattern.
- **TQ-3 (MUST)** Realistische testdata.
- **TQ-4 (SHOULD)** 1 assertion per test.
- **TQ-5 (SHOULD)** Test isolation.

---

## 5 — Security & Privacy
- **SEC-1 (MUST)** Input validation aan system boundaries.
- **SEC-2 (MUST)** Sanitize outputs.
- **SEC-3 (MUST)** Secrets via env vars/vault, nooit hardcoded.
- **SEC-4 (MUST NOT)** Nooit gevoelige data loggen.
- **SEC-5 (SHOULD)** Least privilege.
- **SEC-6 (MUST)** Dependency scanning (Renovate/Dependabot).
- **SEC-7 (MUST)** Secret scanning (gitleaks).
- **SEC-8 (MUST)** TLS everywhere, HSTS, veilige cookies.

---

## 6 — Observability
- **OBS-1 (MUST)** Structured logging met trace_id / request_id.
- **OBS-2 (SHOULD)** Metrics & SLO's (error rate, latency).
- **OBS-3 (SHOULD)** Distributed tracing op API boundaries.
- **OBS-4 (MUST)** Runbooks bij kritieke services.

---

## 7 — Git & Version Control
- **GIT-1 (MUST)** Conventional Commits.
- **GIT-2 (MUST)** Atomic commits.
- **GIT-3 (MUST NOT)** Geen AI/Claude in commit messages.
- **B-1 (SHOULD)** Feature branches.
- **B-2 (MUST)** Code review voor merge naar main.
- **B-3 (SHOULD)** PR's max ±300 regels.

---

## 8 — Deployment & CI/CD
- **CI-1 (MUST)** Lint, typecheck, tests in CI pipeline.
- **CI-2 (MUST)** Secret scan & SAST in CI.
- **CI-3 (MUST)** PR blokkeert bij falende checks.
- **REL-1 (MUST)** Feature flags voor onvolledige features.
- **REL-2 (SHOULD)** Blue/green of canary deploys.
- **REL-3 (MUST)** Health checks verplicht.

---

## 9 — Database
- **DB-1 (MUST)** Transacties bij multi-step operations.
- **DB-2 (MUST)** Index-strategie documenteren.
- **DB-3 (MUST)** Migrations + rollback scripts.
- **DB-4 (SHOULD)** Vermijd N+1 queries.

---

## 10 — Project Context
- **JS/TS**: ESLint + Prettier, strict typing, Jest/Vitest.
- **Python**: PEP8, type hints, pytest, Black/Ruff.
- **Java**: CheckStyle, JUnit, duidelijke exception handling.
- **C#**: Async/await correct gebruik, xUnit.
- **React/Vue**: Component libraries, state management patterns.
- **Node.js**: Package.json security, dependency management.
- **Mobile**: Platform-specifieke guidelines (iOS/Android).

---

## 11 — Documentation & Knowledge Sharing
- **DOC-1 (MUST)** README met setup, usage en troubleshooting.
- **DOC-2 (SHOULD)** API documentatie (OpenAPI/Swagger).
- **DOC-3 (SHOULD)** Architecture Decision Records (ADR's) voor belangrijke keuzes.
- **DOC-4 (MUST)** Inline code comments voor complexe business logic.
- **DOC-5 (SHOULD)** Onboarding guides voor nieuwe teamleden.

---

## 12 — Performance & Monitoring
- **PERF-1 (MUST)** Performance budgets definiëren.
- **PERF-2 (SHOULD)** Load testing bij kritieke endpoints.
- **PERF-3 (MUST)** Memory leak monitoring.
- **PERF-4 (SHOULD)** Database query performance tracking.
- **PERF-5 (MUST)** Resource limits (CPU, memory) instellen.

---

## 13 — Accessibility & UX
- **A11Y-1 (SHOULD)** WCAG 2.1 AA compliance.
- **A11Y-2 (MUST)** Keyboard navigation support.
- **A11Y-3 (MUST)** Screen reader compatibility.
- **UX-1 (SHOULD)** Loading states en error feedback.
- **UX-2 (MUST)** Responsive design.

---

## 14 — Backup & Recovery
- **BCK-1 (MUST)** Geautomatiseerde backups.
- **BCK-2 (MUST)** Recovery procedures testen.
- **BCK-3 (SHOULD)** Data retention policies.
- **BCK-4 (MUST)** Disaster recovery plan.

---

## 15 — Claude Optimization Guidelines

### **Context & Communication**
- **CL-1 (MUST)** Geef altijd volledige file paths en project structuur.
- **CL-2 (MUST)** Specificeer exact welke files aangepast moeten worden.
- **CL-3 (MUST)** Geef bestaande code context mee (imports, dependencies).
- **CL-4 (MUST)** Vermeld target platform/framework versies expliciet.
- **CL-5 (SHOULD)** Deel relevante error logs en stack traces.
- **CL-6 (MUST)** Monitor context usage via context-manager agent.
- **CL-7 (MUST)** Start met 32K tokens, escaleer alleen indien nodig.

### **Output Format**
- **CL-8 (MUST)** Lever complete, uitvoerbare code (geen placeholders).
- **CL-9 (MUST)** Toon volledige file content, niet alleen snippets.
- **CL-10 (MUST)** Geef expliciete import statements en dependencies.
- **CL-11 (MUST)** Voeg installation/setup commands toe.
- **CL-12 (SHOULD)** Gebruik artifacts voor complexe code.

### **Error Prevention**
- **CL-13 (MUST)** Valideer syntax vóór delivery.
- **CL-14 (MUST)** Check dependency compatibility.
- **CL-15 (MUST)** Anticipeer common edge cases.
- **CL-16 (MUST)** Geef expliciete error handling.
- **CL-17 (SHOULD)** Test logica mentally doorlopen.

### **Iterative Improvement**
- **CL-18 (MUST)** Vraag om feedback na elke delivery.
- **CL-19 (MUST)** Documenteer lessons learned in session-memory.
- **CL-20 (SHOULD)** Bouw incrementeel (MVP eerst).
- **CL-21 (MUST)** Version control tussen iteraties.

### **Context Escalation Triggers**
- **CL-22 (MUST)** Request 200K voor multi-file projects (>5 files).
- **CL-23 (MUST)** Request 1M voor full codebase analysis.
- **CL-24 (SHOULD)** Use chunking strategy voor grote datasets.
- **CL-25 (MUST)** Track token costs per session.

### **Memory & Handover**
- **CL-26 (MUST)** Auto-save progress via session-memory agent.
- **CL-27 (MUST)** Create handover notes bij session end.
- **CL-28 (MUST)** Document unresolved issues voor next session.
- **CL-29 (SHOULD)** Include time estimates voor remaining work.
- **CL-30 (MUST)** Maintain `.claude-memory/` directory structure.

### **Strikte Opdracht Uitvoering**
- **CL-31 (MUST)** Geen eigen interpretatie van requirements → alles moet gebaseerd zijn op expliciete instructies.
- **CL-32 (MUST)** Indien een stap niet uitvoerbaar lijkt: stop en vraag bevestiging i.p.v. overslaan.
- **CL-33 (MUST)** Geen auto-activatie of -deactivatie van code, functies of features tenzij expliciet gevraagd.
- **CL-34 (MUST)** Alle output moet volledig aansluiten op de vraag, zonder creatieve toevoegingen die niet gevraagd zijn.

---

## 16 — Continuous Improvement
- **Weekly**: metrics review (bugs, velocity, perf).
- **Monthly**: guidelines + tooling herzien.
- **ADR's**: beslissingen vastleggen (Context → Options → Decision).

### **Claude Feedback Loop**
Na elke code delivery:
1. **Werkt het?** (Ja/Nee + error details)
2. **Performance issues?** 
3. **Missing functionality?**
4. **Improvement suggestions?**

### **Tracking Metrics**
- **First-time success rate** (code werkt zonder fixes)
- **Average iterations** per feature
- **Common error patterns**

---

## 17 — Emergency Procedures
- **Bugfix**: reproduce → failing test → minimale fix → regressietests → deploy.
- **Perf issue**: profile → bottleneck fix → meten → monitoren.

---

## 18 — API Development Standards

### **RESTful API Design**
- **API-1 (MUST)** Gebruik consistente resource naming (plural nouns: `/users`, `/products`).
- **API-2 (MUST)** Correct HTTP methods (GET=read, POST=create, PUT=full update, PATCH=partial, DELETE).
- **API-3 (MUST)** Proper HTTP status codes (200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found, 500 Server Error).
- **API-4 (MUST)** API versioning in URL (`/api/v1/`) of header.
- **API-5 (MUST)** Pagination voor collections (`?page=1&limit=20`).
- **API-6 (SHOULD)** Filtering, sorting en field selection support.
- **API-7 (MUST)** Rate limiting met headers (`X-RateLimit-Limit`, `X-RateLimit-Remaining`).

### **Response Format Standards**
- **RESP-1 (MUST)** Consistente response structure:
  ```json
  {
    "success": true,
    "data": {},
    "meta": { "page": 1, "total": 100 },
    "errors": []
  }
  ```
- **RESP-2 (MUST)** ISO 8601 timestamps (`2024-01-15T10:30:00Z`).
- **RESP-3 (MUST)** Camelcase voor JSON fields.
- **RESP-4 (MUST)** Include request ID in responses.

### **Error Handling**
- **ERR-1 (MUST)** Structured error responses:
  ```json
  {
    "success": false,
    "errors": [
      {
        "code": "VALIDATION_ERROR",
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
  ```
- **ERR-2 (MUST)** Machine-readable error codes.
- **ERR-3 (SHOULD)** Include error documentation links.

### **Security & Authentication**
- **AUTH-1 (MUST)** JWT tokens of OAuth2 implementatie.
- **AUTH-2 (MUST)** Token expiry en refresh mechanism.
- **AUTH-3 (MUST)** CORS configuration voor browser clients.
- **AUTH-4 (MUST)** API key rotation capability.
- **AUTH-5 (MUST NOT)** Passwords in responses.

### **Documentation**
- **APIDOC-1 (MUST)** OpenAPI/Swagger specification.
- **APIDOC-2 (MUST)** Request/response examples.
- **APIDOC-3 (MUST)** Authentication flow documentation.
- **APIDOC-4 (SHOULD)** Postman/Insomnia collections.

---

## 19 — Context & Memory Management

### **Context Window Management**
- **CTX-1 (MUST)** Start met 32K tokens tenzij pre-analyse anders aangeeft.
- **CTX-2 (MUST)** Monitor token usage realtime via context-manager agent.
- **CTX-3 (MUST)** Auto-escalate bij >75% usage EN incomplete task.
- **CTX-4 (SHOULD)** Use chunking voor grote datasets.
- **CTX-5 (MUST)** Track cost per context tier.

### **Context Escalation Tiers**
| Tier | Tokens | Use Case | Cost Factor |
|------|--------|----------|-------------|
| Standard | 32K | Simple CRUD, single files | 1x |
| Extended | 200K | Multi-file projects, complex logic | 6x |
| Maximum | 1M | Full codebase, enterprise refactoring | 31x |

### **Memory Management**
- **MEM-1 (MUST)** Use session-memory agent voor ALLE significant actions.
- **MEM-2 (MUST)** Auto-save na elke 5 acties.
- **MEM-3 (MUST)** Maintain `.claude-memory/` directory structure.
- **MEM-4 (MUST)** Document WHY decisions, niet alleen WHAT.
- **MEM-5 (SHOULD)** Archive sessions older than 30 days.

### **Session Continuity**
- **SESS-1 (MUST)** Create handover notes bij session end.
- **SESS-2 (MUST)** Load previous context bij session start.
- **SESS-3 (MUST)** Track unresolved issues tussen sessions.
- **SESS-4 (SHOULD)** Include time estimates voor next session.

### **Memory File Structure**
```
.claude-memory/
├── session-current.md      # Active work
├── session-history.md      # Past sessions
├── project-state.md        # Current snapshot
├── decisions-log.md        # Architecture decisions
├── errors-solutions.md     # Problem database
├── code-inventory.md       # File purposes
└── handover-notes.md       # Quick start
```

### **Token Optimization**
- **OPT-1 (SHOULD)** Pre-filter irrelevant files.
- **OPT-2 (SHOULD)** Use references voor repeated code.
- **OPT-3 (MUST)** Clear unused context regularly.
- **OPT-4 (SHOULD)** Compress historical data.

---

## 20 — Agent Integration Protocols

### **Agent Selection Matrix**
| Task Type | Primary Agent | Context Tier | Auto-Trigger | Context7 |
|-----------|--------------|--------------|--------------|----------|
| API Development | backend-specialist | 32K-200K | Yes | ✅ |
| Context Management | context-manager | 32K | Always | ⚙️ |
| Memory/Documentation | session-memory | 32K | Always | 📝 |
| Security Review | security-specialist | 200K | On deploy | ✅ |
| Testing | qa-testing-engineer | 200K | After code | ✅ |
| Performance | load-stress-test | 200K | Pre-deploy | ✅ |
| Architecture | solutions-architect | 200K-1M | On design | ✅ |
| Frontend Dev | frontend-specialist | 32K-200K | Yes | ✅ |
| ML/AI Integration | ml-ai-integration | 32K-200K | Yes | ✅ |
| Data Engineering | data-engineer | 32K-200K | Yes | ✅ |

### **Agent Communication**
- **AGENT-1 (MUST)** Use structured JSON for inter-agent messages.
- **AGENT-2 (MUST)** Include correlation ID in all communications.
- **AGENT-3 (SHOULD)** Batch parallel agent calls waar mogelijk.
- **AGENT-4 (MUST)** Handle agent timeout gracefully (max 10 min).

### **Automatic Triggers**
- **TRIG-1 (MUST)** session-memory after EVERY file change.
- **TRIG-2 (SHOULD)** security-specialist voor authentication code.
- **TRIG-3 (SHOULD)** qa-testing-engineer na nieuwe features.
- **TRIG-4 (MUST)** context-manager bij >75% token usage.

### **Master Orchestrator Protocol**
```python
# Standard agent invocation
agent_request = {
    "agent": "backend-specialist",
    "task": "Create REST API",
    "context_tier": "200K",
    "timeout": 600000,
    "correlation_id": "req-123",
    "session_memory": True,
    "auto_escalate": True
}
```

### **Cost Management**
- **COST-1 (MUST)** Set daily token budget per agent.
- **COST-2 (SHOULD)** Alert at 80% budget consumption.
- **COST-3 (MUST)** Require approval voor 1M context.
- **COST-4 (SHOULD)** Track ROI per agent usage.

### **Performance Monitoring**
- **PERF-6 (MUST)** Log agent response times.
- **PERF-7 (SHOULD)** Track success rates per agent.
- **PERF-8 (MUST)** Monitor context escalation patterns.
- **PERF-9 (SHOULD)** Optimize frequently used agent paths.

---

## 21 — External Documentation Integration (Context7)

### **Real-time Documentation Access**
- **CTX7-1 (MUST)** Configure Context7 MCP server in Claude Code/Cursor.
- **CTX7-2 (SHOULD)** Add "use context7" for external library documentation.
- **CTX7-3 (MUST)** Use API key for production (100 req/min vs 10 req/min).
- **CTX7-4 (SHOULD)** Cache documentation for 1 hour to optimize performance.
- **CTX7-5 (MUST)** Track Context7 usage in session-memory for handover.

### **Library Documentation Strategy**
- **LIB-1 (MUST)** Use Context7 for framework/library-specific code.
- **LIB-2 (SHOULD)** Specify versions when critical (e.g., "React 18", "Next.js 14").
- **LIB-3 (MUST)** Fall back to training data if Context7 unavailable.
- **LIB-4 (SHOULD)** Batch documentation requests for related libraries.

### **Token Optimization with Context7**
- **TOK-1 (SHOULD)** Use Context7's 5000 token default for docs.
- **TOK-2 (MUST)** Stay within 32K tier when using Context7.
- **TOK-3 (SHOULD)** Avoid context escalation for documentation needs.
- **TOK-4 (MUST)** Monitor token usage via Context7 responses.

### **Agent-Specific Integration**
| Agent | Context7 Usage | Example Libraries |
|-------|----------------|-------------------|
| backend-specialist | Always | Express, FastAPI, NestJS, Prisma |
| frontend-specialist | Always | React, Vue, Next.js, Tailwind |
| ml-ai-integration | Always | OpenAI, LangChain, Transformers |
| data-engineer | Always | Pandas, Spark, Airflow, dbt |
| security-specialist | On-demand | Auth0, JWT, OAuth libraries |
| qa-testing-engineer | On-demand | Jest, Playwright, Cypress |

### **Implementation Checklist**
- [ ] Install Context7 MCP server
- [ ] Configure API key in mcp.json
- [ ] Test with "use context7" trigger
- [ ] Update agent prompts to include Context7
- [ ] Document in session-memory when used

---

## 🚀 Claude Prompting Template

```markdown
CONTEXT:
- Project: [naam en beschrijving]
- Tech stack: [exact versions, bijv. React 18.2, Node 20.x]
- Files involved: [volledige paths naar relevante files]
- Current state: [wat werkt wel/niet, error messages]
- Project structure: [folder structuur indien relevant]

REQUIREMENTS:
- Functionality: [specifiek wat je wilt bereiken]
- Constraints: [beperkingen, performance eisen, compatibility]
- Success criteria: [hoe test je dat het werkt]
- Non-functional: [security, performance, accessibility eisen]

DELIVERY FORMAT:
- Complete files (geen snippets of placeholders)
- Installation/setup steps
- Testing instructions  
- Potential issues to watch
- Implementation steps for non-developers

FOLLOW-UP:
- Feedback verwacht na implementatie
- Next iteration planning indien nodig
```

---

## 📋 Shortcuts Checklist

- **QNEW**: Start nieuwe taak, lees regels, stel vragen, maak plan.
- **QPLAN**: Schrijf plan met patterns, security, perf, compat.
- **QCODE**: TDD flow + lint + tests.
- **QCHECK**: Senior review checklist.
- **QSECURITY**: Security checklist.
- **QTEST**: Test completeness checklist.
- **QREFACTOR**: Code quality checklist.
- **QGIT**: Commit & PR workflow checklist.
- **QCLAUDE**: Claude-optimized prompt checklist.
- **QFEEDBACK**: Post-delivery feedback template.
- **QCONTEXT**: Context gathering checklist.
- **QAPI**: API development standards checklist.
- **QMEMORY**: Session memory & handover checklist.
- **QAGENT**: Agent selection & integration checklist.
- **QCONTEXT7**: Context7 documentation fetch checklist.

---

## 💡 Implementation Tips

### Voor Non-Developers:
1. **Gebruik de prompting template** - kopieer en vul in
2. **Start klein** - vraag om MVP eerst
3. **Geef specifieke feedback** - "werkt niet" vs "krijg error X bij stap Y"
4. **Test systematisch** - volg de test instructies exact
5. **Documenteer problemen** - screenshots, error messages, steps to reproduce

### Voor Developers:
1. **Review Claude output** tegen deze checklist
2. **Enforce in PR reviews** - link naar relevante regels
3. **Update regelmatig** - maandelijkse retrospective
4. **Automatiseer waar mogelijk** - linting, testing, security scans
5. **Meet en verbeter** - track metrics en leer van fouten

---

*Versie 3.1 - Enhanced with API Standards, Context Management, Agent Integration & Context7 MCP*