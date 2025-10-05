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

### **Test Data Management**
- **TD-1 (MUST)** Factories/fixtures voor test data.
- **TD-2 (MUST NOT)** Production data in tests.
- **TD-3 (SHOULD)** Faker/faker.js voor realistic data.
- **TD-4 (MUST)** Seed scripts voor consistent state.

### **Visual Testing**
- **VIS-1 (SHOULD)** Screenshot tests (Percy, Chromatic).
- **VIS-2 (SHOULD)** Cross-browser testing matrix.
- **VIS-3 (MUST)** Mobile viewport testing.

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
- **CL-7 (MUST)** Bepaal context size automatisch op basis van task complexity (zie §19).

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
- **CL-22 (MUST)** Auto-escalate op basis van task complexity assessment (zie §19).
- **CL-23 (MUST)** Monitor en documenteer escalatie redenen voor optimalisatie.
- **CL-24 (SHOULD)** Use chunking strategy voor grote datasets.
- **CL-25 (MUST)** Track token costs per session en context tier.

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

### **File Size Management**
- **CL-35 (MUST)** Split files >500 lines voor betere context.
- **CL-36 (SHOULD)** Use file references i.p.v. full content indien mogelijk.
- **CL-37 (MUST)** Prioriteer relevante files in context window.

### **Iterative Development**
- **CL-38 (MUST)** Start met wireframes/pseudocode.
- **CL-39 (MUST)** Incrementele commits per feature component.
- **CL-40 (SHOULD)** Use feature flags voor WIP features.

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
- **CTX-1 (MUST)** Bepaal context size automatisch op basis van task complexity.
- **CTX-2 (MUST)** Monitor token usage realtime via context-manager agent.
- **CTX-3 (MUST)** Auto-escalate bij >75% usage EN incomplete task.
- **CTX-4 (SHOULD)** Use chunking voor grote datasets.
- **CTX-5 (MUST)** Track cost per context tier.

### **Context Escalation Tiers**
| Tier | Tokens | Use Case | Cost Factor | Auto-Select Criteria |
|------|--------|----------|-------------|----------------------|
| Minimal | 32K | Single file edits, simple queries, documentation lookup | 1x | ≤1 file, no dependencies, simple task |
| Small | 64K | Few files (2-3), isolated feature, single component | 2x | 2-3 files, limited scope, clear boundaries |
| Medium | 128K | Multiple files (4-8), related components, moderate complexity | 4x | 4-8 files, related systems, moderate logic |
| Standard | 200K | Multi-file projects (9-15), cross-cutting features, complex logic | 6x | 9-15 files, multiple systems, integrations |
| Large | 500K | Major features (16-30 files), architectural changes, refactoring | 16x | 16-30 files, architecture impact, migrations |
| Maximum | 1M | Full codebase analysis, enterprise refactoring, system redesign | 31x | >30 files, full system analysis, major refactor |

### **Task Complexity Assessment**
Claude analyseert automatisch:
1. **File Count**: Aantal betrokken files
2. **Dependency Depth**: Hoe diep gaan de dependencies
3. **Code Complexity**: Cyclomatic complexity, nesting levels
4. **Task Type**:
   - Simple: Bug fix, typo, config change → 32K-64K
   - Moderate: New feature, component addition → 128K-200K
   - Complex: Refactoring, architecture changes → 500K-1M
5. **Cross-cutting Concerns**: Security, performance, testing impact

### **Praktische Voorbeelden**

**Voorbeeld 1: Simple Task (32K)**
```
Task: "Fix typo in error message in src/utils/validator.ts"
Analysis:
- Files: 1
- Dependencies: None
- Complexity: Minimal
- Impact: Isolated
→ Context: 32K
```

**Voorbeeld 2: Moderate Task (128K)**
```
Task: "Add email validation to user registration form"
Analysis:
- Files: 3 (form component, validation util, tests)
- Dependencies: Validation library
- Complexity: Moderate (regex, error handling)
- Impact: Single feature
→ Context: 128K
```

**Voorbeeld 3: Complex Task (500K)**
```
Task: "Refactor authentication system to support OAuth2"
Analysis:
- Files: 15-20 (auth services, middleware, routes, tests, config)
- Dependencies: OAuth libraries, session management, security
- Complexity: High (state management, token handling, security)
- Impact: Cross-cutting (affects multiple modules)
→ Context: 500K
```

**Voorbeeld 4: Maximum Task (1M)**
```
Task: "Migrate entire application from REST to GraphQL"
Analysis:
- Files: 50+ (all API routes, resolvers, schema, client code)
- Dependencies: GraphQL libraries, schema design
- Complexity: Very high (architectural change)
- Impact: System-wide
→ Context: 1M
```

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

### **Context Selection Decision Tree**
```
START
  ↓
Hoeveel files zijn betrokken?
  1 file → 32K (Minimal)
  2-3 files → Check complexity ↓
  4-8 files → Check dependencies ↓
  9-15 files → 200K (Standard)
  16-30 files → 500K (Large)
  >30 files → 1M (Maximum)
  ↓
Is het een architecturale wijziging?
  YES → +1 tier (min 500K)
  NO → Continue
  ↓
Zijn er cross-cutting concerns (security, perf, testing)?
  YES → +1 tier
  NO → Continue
  ↓
Wat is de code complexity?
  Low (< 5 cyclomatic) → Huidige tier
  Medium (5-10) → +1 tier
  High (>10) → +2 tiers
  ↓
FINAL CONTEXT SIZE SELECTED
```

### **Token Optimization**
- **OPT-1 (SHOULD)** Pre-filter irrelevant files.
- **OPT-2 (SHOULD)** Use references voor repeated code.
- **OPT-3 (MUST)** Clear unused context regularly.
- **OPT-4 (SHOULD)** Compress historical data.
- **OPT-5 (MUST)** Document actual vs estimated context usage voor verbetering.

---

## 20 — Agent Integration Protocols

### **Agent Selection Matrix**
| Task Type | Primary Agent | Context Tier | Auto-Trigger | Context7 |
|-----------|--------------|--------------|--------------|----------|
| API Development | backend-specialist | Auto (128K-1M) | Yes | ✅ |
| Context Management | context-manager | Auto (32K-200K) | Always | ⚙️ |
| Memory/Documentation | session-memory | Auto (32K-128K) | Always | 📝 |
| Security Review | security-specialist | Auto (128K-1M) | On deploy | ✅ |
| Testing | qa-testing-engineer | Auto (64K-500K) | After code | ✅ |
| Performance | load-stress-test | Auto (128K-500K) | Pre-deploy | ✅ |
| Architecture | solutions-architect | Auto (200K-1M) | On design | ✅ |
| Frontend Dev | frontend-specialist | Auto (64K-500K) | Yes | ✅ |
| ML/AI Integration | ml-ai-integration | Auto (128K-1M) | Yes | ✅ |
| Data Engineering | data-engineer | Auto (128K-1M) | Yes | ✅ |

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
- **TOK-2 (MUST)** Stay within 200K tier when using Context7.
- **TOK-3 (SHOULD)** Use 200K context for comprehensive documentation analysis.
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

## 22 — Infrastructure as Code

### **IaC Standards**
- **IAC-1 (MUST)** Terraform/Pulumi voor infrastructure definitions.
- **IAC-2 (MUST)** Version control voor alle infra configs (Git).
- **IAC-3 (SHOULD)** Environment parity (dev ≈ staging ≈ prod).
- **IAC-4 (MUST)** Secrets management via Vault/AWS Secrets Manager.
- **IAC-5 (MUST)** State file backup en locking mechanism.
- **IAC-6 (SHOULD)** Modular infrastructure (reusable modules).

### **Cloud Provider Standards**
- **CLOUD-1 (MUST)** Tagging strategy (environment, owner, cost-center).
- **CLOUD-2 (MUST)** Cost monitoring en alerts.
- **CLOUD-3 (SHOULD)** Multi-region setup voor HA.
- **CLOUD-4 (MUST)** Automated backup voor critical resources.

### **Configuration Management**
- **CFG-1 (MUST)** Environment-specific configs (dev/staging/prod).
- **CFG-2 (MUST)** Config validation pre-deployment.
- **CFG-3 (SHOULD)** Feature flags voor gradual rollout.
- **CFG-4 (MUST)** Rollback plan voor config changes.

---

## 23 — Container & Orchestration

### **Docker Best Practices**
- **CONT-1 (MUST)** Multi-stage builds voor size optimization.
- **CONT-2 (MUST)** .dockerignore voor security (exclude .env, secrets).
- **CONT-3 (SHOULD)** Container scanning (Trivy, Snyk, Grype).
- **CONT-4 (MUST)** Non-root user in containers.
- **CONT-5 (MUST)** Health checks in Dockerfile.
- **CONT-6 (SHOULD)** Minimize layers (combine RUN commands).

### **Kubernetes Standards**
- **K8S-1 (MUST)** Resource limits & requests voor alle pods.
- **K8S-2 (MUST)** Liveness en readiness probes.
- **K8S-3 (MUST)** ConfigMaps/Secrets voor configuratie.
- **K8S-4 (SHOULD)** HorizontalPodAutoscaler voor scaling.
- **K8S-5 (MUST)** NetworkPolicies voor security.
- **K8S-6 (SHOULD)** Pod Disruption Budgets voor HA.

### **Registry Management**
- **REG-1 (MUST)** Image tagging strategy (semantic versioning).
- **REG-2 (MUST)** Vulnerability scanning in CI/CD.
- **REG-3 (SHOULD)** Image retention policy (cleanup old images).
- **REG-4 (MUST)** Private registry voor production images.

---

## 24 — Data Privacy & Compliance

### **GDPR Compliance**
- **GDPR-1 (MUST)** Data retention policies (max retention period).
- **GDPR-2 (MUST)** Right to deletion implementation (data erasure).
- **GDPR-3 (MUST)** Data export functionality (portability).
- **GDPR-4 (MUST)** Consent management system.
- **GDPR-5 (MUST)** PII logging prevention (mask sensitive data).
- **GDPR-6 (SHOULD)** Data anonymization in non-prod environments.
- **GDPR-7 (MUST)** Privacy by design (minimal data collection).

### **Data Classification**
- **CLASS-1 (MUST)** Classify data (public, internal, confidential, restricted).
- **CLASS-2 (MUST)** Access control based on classification.
- **CLASS-3 (MUST)** Encryption at rest voor confidential data.
- **CLASS-4 (MUST)** Audit trail voor restricted data access.

### **Compliance Documentation**
- **COMP-1 (MUST)** Data processing registry.
- **COMP-2 (MUST)** Privacy impact assessments (DPIA).
- **COMP-3 (SHOULD)** Regular compliance audits.
- **COMP-4 (MUST)** Incident response plan voor data breaches.

---

## 25 — Debugging & Troubleshooting

### **Debugging Workflows**
- **DEBUG-1 (MUST)** Reproducible bug reports (exact steps, environment, logs).
- **DEBUG-2 (SHOULD)** Binary search voor regression bugs (git bisect).
- **DEBUG-3 (MUST)** Profiling tools per language:
  - Go: pprof
  - Python: py-spy, cProfile
  - Node.js: clinic.js, 0x
  - Java: VisualVM, JProfiler
- **DEBUG-4 (SHOULD)** Remote debugging setup documentation.
- **DEBUG-5 (MUST)** Core dump analysis procedures voor crashes.

### **Common Issues Database**
- **ISSUE-1 (MUST)** Maintain known issues wiki/documentation.
- **ISSUE-2 (SHOULD)** Link error codes naar solutions.
- **ISSUE-3 (MUST)** Update database na elke incident resolution.
- **ISSUE-4 (SHOULD)** Categorize by severity en frequency.

### **Performance Debugging**
- **PERF-DEBUG-1 (MUST)** Baseline metrics voor comparison.
- **PERF-DEBUG-2 (SHOULD)** APM tools (New Relic, DataDog, Dynatrace).
- **PERF-DEBUG-3 (MUST)** Query analysis tools (explain plans, slow query logs).
- **PERF-DEBUG-4 (SHOULD)** Memory profiling voor leak detection.

### **Production Debugging**
- **PROD-DEBUG-1 (MUST)** Feature flags voor quick disable.
- **PROD-DEBUG-2 (MUST)** Log level adjustment zonder redeploy.
- **PROD-DEBUG-3 (SHOULD)** Request replay capability.
- **PROD-DEBUG-4 (MUST)** Metrics export voor external analysis.

---

## 26 — Team Communication & Collaboration

### **Communication Standards**
- **COMM-1 (MUST)** Daily async standups (written format):
  - Yesterday: What was accomplished
  - Today: What's planned
  - Blockers: Any impediments
- **COMM-2 (SHOULD)** RFC process voor major technical changes.
- **COMM-3 (MUST)** Incident communication templates (status updates).
- **COMM-4 (SHOULD)** Weekly knowledge sharing sessions.
- **COMM-5 (MUST)** Decision documentation (ADRs, meeting notes).

### **Code Review Standards**
- **CR-1 (MUST)** Review binnen 24 uur (SLA).
- **CR-2 (MUST)** Constructive feedback format:
  - Issue: What's wrong
  - Impact: Why it matters
  - Suggestion: How to fix
- **CR-3 (SHOULD)** Pair programming voor complex features.
- **CR-4 (MUST)** Block merge op unresolved comments.
- **CR-5 (SHOULD)** Review checklist per PR template.
- **CR-6 (MUST)** Separate feedback (blocking vs. suggestions).

### **Meeting Efficiency**
- **MEET-1 (SHOULD)** Agenda vóór meeting (24h notice).
- **MEET-2 (MUST)** Meeting notes met action items.
- **MEET-3 (SHOULD)** Default to async waar mogelijk.
- **MEET-4 (MUST)** Time-box discussions (avoid overruns).

### **Documentation Culture**
- **DOC-CULTURE-1 (MUST)** Write-first culture (document before discussing).
- **DOC-CULTURE-2 (SHOULD)** Wiki/Confluence voor centralized docs.
- **DOC-CULTURE-3 (MUST)** Living documentation (update with code changes).
- **DOC-CULTURE-4 (SHOULD)** Onboarding checklist voor new team members.

---

## 27 — Development Environment Setup

### **Local Development**
- **ENV-1 (MUST)** One-command setup (`make setup` / `npm run setup`).
- **ENV-2 (MUST)** `.env.example` met alle required variables.
- **ENV-3 (SHOULD)** Docker Compose voor local services (DB, Redis, etc.).
- **ENV-4 (MUST)** Pre-commit hooks (Husky, pre-commit framework).
- **ENV-5 (SHOULD)** VS Code workspace settings in repo (.vscode/).

### **IDE Configuration**
- **IDE-1 (SHOULD)** Shared IDE configs (ESLint, Prettier, editor config).
- **IDE-2 (SHOULD)** Recommended extensions list.
- **IDE-3 (MUST)** Debugger launch configurations.
- **IDE-4 (SHOULD)** Code snippets voor common patterns.

### **Dependency Management**
- **DEP-1 (MUST)** Lock files committed (package-lock.json, poetry.lock).
- **DEP-2 (MUST)** Dependency update policy (weekly/monthly).
- **DEP-3 (SHOULD)** Renovate/Dependabot voor automated updates.
- **DEP-4 (MUST)** Security vulnerability scanning.

### **Development Tools**
- **TOOLS-1 (SHOULD)** CLI tools documented in README.
- **TOOLS-2 (SHOULD)** Make/Task/npm scripts voor common tasks.
- **TOOLS-3 (MUST)** Version requirements documented (Node 20+, Python 3.11+).
- **TOOLS-4 (SHOULD)** Troubleshooting guide voor common setup issues.

---

## 28 — Real-World Workflows

### **Nieuwe Feature Development**
```bash
# 1. Clarify & Plan (5-10 min)
- Gebruik /qcontext → gather all requirements
- Gebruik /qplan → create detailed technical plan
- Gebruik /qagent → select appropriate specialist (backend/frontend/etc.)
- Review plan met stakeholder/tech lead

# 2. Development (30-120 min)
- Gebruik /qcontext7 → fetch latest library documentation
- Gebruik /qtdd → write tests first (Red-Green-Refactor)
- Gebruik /qcode → implement feature
- Continuous commits (atomic, conventional commits)

# 3. Quality Checks (10-20 min)
- Gebruik /qsecurity → run security checklist
- Gebruik /qtest → verify test coverage >80%
- Gebruik /qrefactor → code quality review
- Run linter & type checker

# 4. Deploy (5-15 min)
- Gebruik /qgit → create commit & PR
- Gebruik /qagent load-stress-test → performance validation
- CI/CD pipeline completion
- Deploy to staging → smoke tests → production
```

### **Bug Fix Workflow**
```bash
# 1. Reproduce (10-20 min)
- Get exact steps to reproduce
- Check logs, stack traces, error messages
- Isolate problematic code section
- Gebruik /qdebug → debugging checklist

# 2. Fix (15-45 min)
- Write failing test first (TDD)
- Implement minimal fix (KISS principle)
- Verify fix works locally
- Run full test suite

# 3. Prevent (10-15 min)
- Add regression test
- Update error handling if needed
- Document in known issues database
- Post-mortem (if critical bug)
```

### **Code Review Workflow**
```bash
# Voor Reviewer:
- [ ] Alle MUST regels uit CLAUDE.md gevolgd?
- [ ] Tests aanwezig & coverage >80%?
- [ ] Security checklist compleet (OWASP top 10)?
- [ ] Performance impact < 100ms added latency?
- [ ] Documentation updated (README, API docs)?
- [ ] Breaking changes documented & communicated?
- [ ] Database migrations tested (up & down)?
- [ ] Error handling comprehensive?

# Voor Author:
- Self-review tegen checklist
- Run /qcheck voor senior review simulation
- Address all comments binnen 24h
- Request re-review when ready
```

### **Hotfix Workflow (Production Issue)**
```bash
# 1. Immediate Response (0-5 min)
- Alert team via incident channel
- Create incident ticket (severity, impact)
- Rollback if possible (feature flag/deployment)

# 2. Investigation (5-30 min)
- Check monitoring/logs (last 1-2 hours)
- Identify root cause
- Estimate fix complexity

# 3. Fix & Deploy (15-60 min)
- Create hotfix branch from main/production
- Minimal fix + test
- Fast-track PR review (1 reviewer minimum)
- Deploy to production
- Monitor for 30 minutes

# 4. Post-Mortem (within 24-48h)
- Document timeline
- Root cause analysis (5 Whys)
- Action items to prevent recurrence
```

### **Refactoring Workflow**
```bash
# 1. Preparation
- Identify code smell (duplication, complexity, etc.)
- Ensure test coverage >80% for target area
- Create refactor plan (step-by-step)

# 2. Execution
- Make changes incrementally
- Run tests after each step (Green → Green)
- Commit frequently (atomic commits)
- No functionality changes (behavior preserving)

# 3. Validation
- Full test suite passes
- Performance benchmarks (no regression)
- Code review with focus on readability
```

### **Database Migration Workflow**
```bash
# 1. Planning
- Design migration (schema changes, data transformations)
- Write both UP and DOWN migrations
- Test on copy of production data

# 2. Execution
- Run migration in staging
- Validate data integrity
- Backup production database
- Run migration in production (maintenance window if needed)
- Verify application works

# 3. Monitoring
- Check application logs (first 30 min)
- Monitor database performance
- Have rollback plan ready
```

---

## 29 — Priority Matrix

### **🔴 CRITICAL - Always Apply**
**Core Requirements (Breaking these = delivery rejected)**
- **BM-1, BM-2, BM-3** → Basis missie (no assumptions, follow instructions exactly)
- **SEC-1 to SEC-8** → Security (input validation, secrets management, TLS)
- **E-1 to E-4** → Error handling (no silent failures)
- **CL-31 to CL-34** → Strikte opdracht uitvoering
- **GDPR-1 to GDPR-7** → Data privacy compliance

**Security & Safety**
- Input sanitization at all boundaries
- Secrets via env vars (never hardcoded)
- PII/sensitive data never in logs
- Dependency scanning enabled
- TLS/HTTPS everywhere

**Code Quality Fundamentals**
- Single Responsibility Principle
- DRY (no duplication)
- KISS (simple > complex)
- Error handling voor alle scenarios

---

### **🟠 HIGH - Most Projects**

**Testing & Validation**
- **T-1, T-2, T-3** → TDD, 80% coverage, edge cases
- **TQ-1 to TQ-5** → Test quality standards
- **CI-1 to CI-3** → CI/CD pipeline checks

**Code Standards**
- **C-1 to C-5** → Code quality principles
- **API-1 to API-7** → API development standards
- **GIT-1 to GIT-3** → Git conventions

**Context & Memory**
- **CTX-1 to CTX-5** → Automatische context sizing op basis van task complexity
- **MEM-1 to MEM-5** → Session memory & handover
- **CL-1 to CL-21** → Claude optimization basics

**Performance & Monitoring**
- **PERF-1, PERF-3, PERF-5** → Performance budgets, monitoring, resource limits
- **OBS-1, OBS-4** → Structured logging, runbooks

---

### **🟡 MEDIUM - Team/Project Dependent**

**Documentation**
- **DOC-1 to DOC-5** → README, API docs, ADRs, onboarding
- **APIDOC-1 to APIDOC-4** → API documentation standards

**Accessibility & UX**
- **A11Y-1 to A11Y-3** → WCAG compliance, keyboard nav, screen readers
- **UX-1, UX-2** → Loading states, responsive design

**Infrastructure**
- **IAC-1 to IAC-6** → Infrastructure as Code
- **CLOUD-1 to CLOUD-4** → Cloud provider standards
- **K8S-1 to K8S-6** → Kubernetes standards

**Collaboration**
- **COMM-1 to COMM-5** → Team communication
- **CR-1 to CR-6** → Code review standards

---

### **🟢 NICE-TO-HAVE - When Time/Budget Permits**

**Advanced Testing**
- **VIS-1 to VIS-3** → Visual/screenshot testing
- Cross-browser testing matrix
- Load testing voor alle endpoints

**Advanced Monitoring**
- Distributed tracing
- APM tools (DataDog, New Relic)
- Custom dashboards

**Developer Experience**
- IDE configs & extensions
- Advanced debugging setups
- Custom CLI tools

**Documentation Extras**
- Video tutorials
- Interactive examples
- Comprehensive troubleshooting guides

---

### **Decision Tree - "Wat Nu?"**

```
START
  ↓
Is it a security issue?
  YES → 🔴 CRITICAL - Fix immediately
  NO  → Continue
  ↓
Does it break core functionality?
  YES → 🔴 CRITICAL - Fix immediately
  NO  → Continue
  ↓
Is it required for production?
  YES → 🟠 HIGH - Schedule this sprint
  NO  → Continue
  ↓
Does it improve user experience significantly?
  YES → 🟡 MEDIUM - Backlog, prioritize
  NO  → Continue
  ↓
Is it a "nice-to-have" optimization?
  YES → 🟢 LOW - Future enhancement
  NO  → Document & defer
```

---

## 30 — Automation & Tooling

### **Pre-commit Automation**
```bash
# .husky/pre-commit (Node.js projects)
#!/bin/bash
npm run lint
npm run typecheck
npm run test:changed
python scripts/check-claude-compliance.py

# .pre-commit-config.yaml (Python projects)
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/psf/black
    hooks:
      - id: black

  - repo: https://github.com/PyCQA/flake8
    hooks:
      - id: flake8
```

### **CI/CD Pipeline Template**
```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Lint
        run: npm run lint

      - name: Type Check
        run: npm run typecheck

      - name: Tests
        run: npm run test:coverage

      - name: Security Scan
        run: |
          npm audit
          npx snyk test

      - name: CLAUDE.md Compliance
        run: python scripts/check-compliance.py

      - name: Coverage Check
        run: |
          if [ $(coverage report | grep TOTAL | awk '{print $4}' | sed 's/%//') -lt 80 ]; then
            echo "Coverage below 80%"
            exit 1
          fi
```

### **CLAUDE.md Compliance Checker**
```python
# scripts/check-claude-compliance.py
import re
import sys
from pathlib import Path

def check_compliance():
    """Check if code follows CLAUDE.md MUST rules"""

    errors = []

    # Check for hardcoded secrets
    for file in Path('.').rglob('*.py'):
        content = file.read_text()
        if re.search(r'password\s*=\s*["\']', content, re.IGNORECASE):
            errors.append(f"{file}: Hardcoded password detected (SEC-3)")

    # Check for missing error handling
    for file in Path('.').rglob('*.py'):
        content = file.read_text()
        if 'try:' in content and 'except:' in content:
            if 'pass' in content:
                errors.append(f"{file}: Silent failure detected (E-4)")

    # Check test coverage
    # (integrate with coverage.py)

    if errors:
        print("❌ CLAUDE.md Compliance Issues:")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    else:
        print("✅ All CLAUDE.md MUST rules passed")

if __name__ == "__main__":
    check_compliance()
```

### **Session Memory Auto-save**
```bash
# .claude/hooks/post-edit
#!/bin/bash
# Auto-save to session memory after file edits

echo "$(date): File edited - $1" >> .claude-memory/session-current.md
python scripts/update-session-memory.py "$1"
```

### **Context Manager Script**
```python
# scripts/context-manager.py
import os
import anthropic

def estimate_tokens(text):
    """Rough estimation: 1 token ≈ 4 characters"""
    return len(text) // 4

def check_context_usage(files):
    total_tokens = 0

    for file in files:
        with open(file) as f:
            total_tokens += estimate_tokens(f.read())

    print(f"Estimated tokens: {total_tokens:,}")

    if total_tokens < 150_000:
        print("✅ Safe for 200K context")
    elif total_tokens < 750_000:
        print("⚠️  Consider 1M context for better performance")
    else:
        print("🔴 Requires 1M context - optimize file selection")

    return total_tokens

if __name__ == "__main__":
    import sys
    files = sys.argv[1:]
    check_context_usage(files)
```

### **Agent Orchestrator Template**
```python
# scripts/agent-orchestrator.py
import json
from anthropic import Anthropic

class AgentOrchestrator:
    def __init__(self):
        self.client = Anthropic()
        self.agents = {
            "backend-specialist": "You are a backend development expert...",
            "frontend-specialist": "You are a frontend development expert...",
            "security-specialist": "You are a security expert...",
        }

    def invoke_agent(self, agent_name, task, context_tier="200K"):
        """Invoke specialized agent with task"""

        max_tokens = 200_000 if context_tier == "200K" else 1_000_000

        response = self.client.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=max_tokens,
            system=self.agents[agent_name],
            messages=[{
                "role": "user",
                "content": task
            }]
        )

        return response.content[0].text

    def multi_agent_workflow(self, task):
        """Execute multi-agent workflow"""

        # 1. Planning phase
        plan = self.invoke_agent("backend-specialist", f"Create plan for: {task}")

        # 2. Security review
        security = self.invoke_agent("security-specialist", f"Review security: {plan}")

        # 3. Implementation
        code = self.invoke_agent("backend-specialist", f"Implement: {plan}\nSecurity: {security}")

        return {
            "plan": plan,
            "security_review": security,
            "implementation": code
        }

# Usage
orchestrator = AgentOrchestrator()
result = orchestrator.multi_agent_workflow("Create user authentication API")
print(json.dumps(result, indent=2))
```

---

## 🚀 Claude Prompting Template

### **Standard Prompt Format**
```markdown
CONTEXT:
- Project: [naam en beschrijving]
- Tech stack: [exact versions - React 18.2, Node 20.x, PostgreSQL 15]
- Files involved: [volledige paths naar relevante files]
  - /src/api/users.ts
  - /src/components/UserList.tsx
- Current state: [wat werkt wel/niet, error messages]
- Project structure: [folder structuur indien relevant]

REQUIREMENTS:
- Functionality: [specifiek wat je wilt bereiken]
  - User moet kunnen inloggen met email/password
  - JWT token-based authentication
  - Session expiry na 24 uur
- Constraints: [beperkingen, performance eisen, compatibility]
  - Response time < 200ms
  - Compatible with IE11+ (legacy requirement)
- Success criteria: [hoe test je dat het werkt]
  - [ ] User can login successfully
  - [ ] Invalid credentials show error
  - [ ] Token refreshes automatically
- Non-functional: [security, performance, accessibility eisen]
  - OWASP top 10 compliance
  - WCAG 2.1 AA for login form

DELIVERY FORMAT:
- Complete files (geen snippets of placeholders)
- Installation/setup steps met exact commands
- Testing instructions (unit + integration)
- Potential issues to watch
- Implementation steps for non-developers:
  1. Stop development server
  2. Run: npm install [packages]
  3. Copy .env.example to .env
  4. Fill in: DATABASE_URL, JWT_SECRET
  5. Run: npm run migrate
  6. Start server: npm run dev
  7. Test: open http://localhost:3000/login

FOLLOW-UP:
- Feedback verwacht na implementatie:
  1. Werkt het? (Ja/Nee + screenshots/errors)
  2. Performance OK? (response times)
  3. Ontbrekende functionaliteit?
  4. Verbetersuggesties?
- Next iteration planning indien nodig
```

### **Voor Bug Reports**
```markdown
BUG REPORT:
- Descriptie: [wat gebeurt er fout]
- Expected behavior: [wat zou moeten gebeuren]
- Actual behavior: [wat gebeurt er echt]
- Steps to reproduce:
  1. Ga naar /dashboard
  2. Klik op "Export Data"
  3. Selecteer date range
  4. Error verschijnt
- Error logs: [volledige stack trace]
- Environment:
  - Browser: Chrome 120
  - OS: macOS 14.2
  - Node: 20.10.0
- Screenshots: [indien relevant]
```

---

## 📋 Quick Command Reference

### **Planning & Context**
- **`/qnew`** → Start nieuwe taak: lees CLAUDE.md, stel 3+ vragen, maak plan
- **`/qplan`** → Schrijf gedetailleerd plan met patterns, security, performance
- **`/qcontext`** → Gather all context (files, structure, dependencies)
- **`/qcontext7`** → Fetch library documentation via Context7

### **Development**
- **`/qcode`** → TDD flow: tests → implementation → verification
- **`/qtdd`** → Test-Driven Development checklist
- **`/qrefactor`** → Code quality & refactoring checklist

### **Quality Assurance**
- **`/qcheck`** → Senior review simulation (alle MUST regels)
- **`/qsecurity`** → Security checklist (OWASP top 10)
- **`/qtest`** → Test completeness (coverage, edge cases)

### **Operations**
- **`/qgit`** → Commit & PR workflow (conventional commits)
- **`/qdebug`** → Debugging workflow checklist
- **`/qapi`** → API development standards checklist

### **Memory & Context**
- **`/qmemory`** → Session memory & handover checklist
- **`/qagent`** → Agent selection & integration guide
- **`/qfeedback`** → Post-delivery feedback template

---

## 💡 Implementation Guide for Non-Developers

### **1. Setup (One-time)**
```bash
# A. Clone this CLAUDE.md to your project root
cp CLAUDE.md /path/to/your/project/

# B. Create memory directory
mkdir -p .claude-memory

# C. Install pre-commit hooks (if applicable)
# Voor Node.js:
npx husky install
npx husky add .husky/pre-commit "npm run lint && npm run test"

# Voor Python:
pip install pre-commit
pre-commit install
```

### **2. Working with Claude**

**Voor Elke Nieuwe Taak:**
1. Open Claude chat
2. Type: `/qnew` (of paste prompt template)
3. Vul context in:
   - Wat wil je bouwen?
   - Welke files zijn relevant?
   - Welke tech stack gebruik je?
4. Wacht op Claude's vragen
5. Beantwoord vragen zo specifiek mogelijk
6. Review het plan
7. Geef akkoord voor implementatie

**Tijdens Development:**
1. Claude levert code → kopieer naar juiste files
2. Run de tests: `npm test` of `pytest`
3. Werkt niet? → kopieer error message terug naar Claude
4. Werkt wel? → gebruik `/qgit` voor commit

**Na Implementatie:**
1. Test de feature handmatig
2. Geef feedback via `/qfeedback` template:
   - ✅ Werkt perfect
   - ⚠️ Werkt maar met issues: [beschrijf]
   - ❌ Werkt niet: [error logs]

### **3. Troubleshooting Common Issues**

**"Code werkt niet"**
1. Kopieer exacte error message
2. Check of alle dependencies geïnstalleerd zijn: `npm install` / `pip install -r requirements.txt`
3. Check .env file (zijn alle variabelen ingevuld?)
4. Deel error + environment info met Claude

**"Te veel context / slow responses"**
1. Type: `/qcontext` → laat Claude files selecteren
2. Gebruik chunking: splits grote taak in kleinere stukken
3. Clear oude context: begin nieuwe chat voor nieuwe feature

**"Claude begrijpt me niet"**
1. Gebruik het prompt template (zie boven)
2. Wees specifieker: geen "maak een login", maar "maak login met email/password, JWT tokens, en session expiry"
3. Voeg screenshots toe indien UI-related

### **4. Cheatsheet**

**Goede Prompts:**
- ✅ "Maak een REST API voor user CRUD met PostgreSQL, include input validation en error handling volgens CLAUDE.md SEC-1 en E-1"
- ✅ "Fix de bug in /src/auth/login.ts waar users met uppercase emails niet kunnen inloggen. Error: 'User not found'"
- ✅ "Refactor /src/utils/validator.ts om DRY principe te volgen (C-2), er is veel duplicatie"

**Slechte Prompts:**
- ❌ "Maak een login" (te vaag)
- ❌ "Fix de code" (geen context)
- ❌ "Het werkt niet" (geen error info)

---

## 🎯 Success Metrics

### **Weekly Review**
- [ ] First-time success rate > 70% (code werkt zonder fixes)
- [ ] Average iterations per feature < 3
- [ ] Test coverage > 80%
- [ ] Security issues found: 0
- [ ] Production bugs: < 2 per week

### **Monthly Review**
- [ ] Update CLAUDE.md met lessons learned
- [ ] Review common error patterns
- [ ] Update tooling (dependencies, linters, etc.)
- [ ] Team retrospective: wat werkt, wat niet?

### **Continuous Improvement**
1. Track metrics in `.claude-memory/metrics.md`
2. Identify bottlenecks (waar gaat tijd verloren?)
3. Update workflows & templates
4. Share learnings met team

---

*Versie 4.1 - Intelligent Context Management Edition*
*Includes: Infrastructure, Privacy/GDPR, Debugging, Communication, Dev Environment, Real-World Workflows, Priority Matrix, Automation & Tooling*
*NEW: Automatische context sizing (32K-1M) op basis van task complexity analysis*
