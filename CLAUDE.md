# 🎯 CLAUDE - Smart Development Standards

**Versie 5.0 - Modular Intent-Based System**

Deze regels zorgen voor **hoogwaardige, veilige en maintainbare code**.
**MUST = verplicht** | **SHOULD = aanbevolen** | **COULD = optioneel**

---

## 📋 Automatische Context Loading (NIEUW!)

**BELANGRIJKE WIJZIGING:** Claude laadt nu automatisch relevante documentatie op basis van je vraag.

### Hoe het werkt:

**STAP 1: Jij stelt een vraag** (in gewone taal)
- "Ik wil dat gebruikers kunnen inloggen"
- "Maak een verbinding met de database"
- "Toon een lijst van producten"

**STAP 2: Claude analyseert de intent**
- Wat wil je bereiken?
- Welke onderdelen zijn betrokken?
- Welke expertise is nodig?

**STAP 3: Claude laadt automatisch de juiste docs**
```bash
/add docs/backend.md      # Voor data, API's, databases
/add docs/frontend.md     # Voor UI, formulieren, pagina's
/add docs/security.md     # Voor inloggen, privacy, beveiliging
/add docs/infrastructure.md  # Voor deployment, hosting
/add docs/testing.md      # Voor bugs, testen, kwaliteit
```

**STAP 4: Claude werkt met volledige context**

---

### Intent → Docs Mapping

**💾 Data opslaan, ophalen, wijzigen:**
→ Automatisch laadt: `docs/backend.md`

Herkenbare zinnen:
- "verbinding met database"
- "data opslaan/bewaren/ophalen"
- "API maken"
- "gegevens uit database halen"

**🎨 Iets tonen op het scherm:**
→ Automatisch laadt: `docs/frontend.md`

Herkenbare zinnen:
- "knop toevoegen"
- "formulier maken"
- "pagina bouwen"
- "lijst tonen"
- "gebruiker moet kunnen zien"

**🔒 Gebruikers, inloggen, beveiliging:**
→ Automatisch laadt: `docs/security.md`

Herkenbare zinnen:
- "inloggen/registreren"
- "wachtwoord"
- "account aanmaken"
- "privacy/GDPR"
- "gebruikersgegevens"

**🚀 Online zetten, deployen:**
→ Automatisch laadt: `docs/infrastructure.md`

Herkenbare zinnen:
- "website live zetten"
- "deployen/publiceren"
- "hosting"
- "online beschikbaar maken"

**🐛 Probleem oplossen, testen:**
→ Automatisch laadt: `docs/testing.md`

Herkenbare zinnen:
- "error/fout"
- "werkt niet"
- "crash"
- "test"
- "bug fix"

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

### 🔍 Impact Analysis (CRITICAL)
- **IA-1 (MUST)** Vóór ELKE code wijziging: analyseer impact op bestaande functionaliteit.
- **IA-2 (MUST)** Check alle afhankelijkheden die geraakt kunnen worden.
- **IA-3 (MUST)** Zoek naar alle files die de te wijzigen code importeren/gebruiken.
- **IA-4 (MUST)** Run bestaande tests VOOR wijzigingen om baseline te bepalen.
- **IA-5 (MUST)** Bij overwriting: backup/documenteer originele implementatie.
- **IA-6 (MUST NOT)** Nooit code overschrijven zonder impact check.
- **IA-7 (MUST)** Bij twijfel: vraag expliciet "Mag ik X overschrijven? Dit heeft impact op Y"

---

## 2 — Code Kwaliteit

- **C-1 (MUST)** Single Responsibility Principle.
- **C-2 (MUST)** DRY (geen duplicatie).
- **C-3 (MUST)** KISS (simpel > complex).
- **C-4 (MUST)** Functions max 20 regels.
- **C-5 (SHOULD)** Composition > inheritance.
- **N-1 (MUST)** Beschrijvende namen (geen `x`, `temp`, `data`).
- **N-2 (MUST)** Functions: werkwoorden (`getUserData`, `calculateTotal`).
- **N-3 (MUST)** Variables: zelfstandig naamwoorden (`user`, `totalAmount`).
- **N-4 (MUST)** Booleans: `is/has` prefix (`isValid`, `hasPermission`).
- **N-5 (MUST)** Constants: UPPERCASE (`MAX_RETRY_COUNT`).
- **N-6 (MUST)** Classes: PascalCase (`UserService`, `OrderController`).
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

### Logging
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

## 6 — Git & Version Control

- **GIT-1 (MUST)** Conventional Commits.
- **GIT-2 (MUST)** Atomic commits.
- **GIT-3 (MUST NOT)** Geen AI/Claude in commit messages.
- **B-1 (SHOULD)** Feature branches.
- **B-2 (MUST)** Code review voor merge naar main.
- **B-3 (SHOULD)** PR's max ±300 regels.

---

## 7 — Context & Memory Management

### Context Window Tiers
| Tier | Tokens | Use Case | Cost | Auto-Select |
|------|--------|----------|------|-------------|
| Minimal | 32K | 1 file, simple edits | 1x | ≤1 file, no deps |
| Small | 64K | 2-3 files, isolated feature | 2x | 2-3 files, limited scope |
| Medium | 128K | 4-8 files, related components | 4x | 4-8 files, moderate logic |
| Standard | 200K | 9-15 files, complex logic | 6x | 9-15 files, integrations |
| Large | 500K | 16-30 files, architecture changes | 16x | 16-30 files, refactoring |
| Maximum | 1M | 30+ files, system redesign | 31x | Full codebase analysis |

### Task Complexity Assessment
Claude analyseert automatisch:
1. **File Count** - Aantal betrokken files
2. **Dependency Depth** - Hoe diep gaan dependencies
3. **Code Complexity** - Cyclomatic complexity
4. **Task Type**:
   - Simple: Bug fix, typo → 32K-64K
   - Moderate: New feature → 128K-200K
   - Complex: Refactoring → 500K-1M
5. **Cross-cutting Concerns** - Security, performance impact

---

## 8 — Claude Optimization

### Context & Communication
- **CL-1 (MUST)** Geef volledige file paths en project structuur.
- **CL-2 (MUST)** Specificeer exact welke files aangepast moeten worden.
- **CL-3 (MUST)** Geef bestaande code context mee (imports, dependencies).
- **CL-4 (MUST)** Vermeld target platform/framework versies expliciet.
- **CL-5 (SHOULD)** Deel relevante error logs en stack traces.
- **CL-6 (MUST)** Monitor context usage via context-manager agent.
- **CL-7 (MUST)** Bepaal context size automatisch op basis van task complexity.

### Agent Usage & Delegation
- **AGENT-1 (MUST)** Analyseer elke complexe taak en bepaal of een gespecialiseerde agent nodig is.
- **AGENT-2 (MUST)** Gebruik subagents voor multi-step taken die meerdere expertise gebieden raken.
- **AGENT-3 (SHOULD)** Delegeer naar specifieke agents op basis van taaktype:
  - **backend-specialist**: API's, databases, server-side logic
  - **frontend-specialist**: UI components, styling, client-side interactie
  - **security-specialist**: Authentication, authorization, GDPR compliance
  - **qa-testing-engineer**: Test strategie, coverage analysis, quality assurance
  - **accessibility-specialist**: WCAG compliance, inclusive design
  - **data-engineer**: ETL pipelines, data warehouse, data quality
  - **ml-ai-integration**: LLM integration, RAG systems, vector databases
  - **playwright-test-agent**: Browser automation, E2E testing
  - **solutions-architect**: System design, tech stack decisions, scalability
- **AGENT-4 (MUST)** Run agents in parallel waar mogelijk voor optimale performance.
- **AGENT-5 (SHOULD)** Gebruik general-purpose agent voor open-ended research taken.

### Output Format
- **CL-8 (MUST)** Lever complete, uitvoerbare code (geen placeholders).
- **CL-9 (MUST)** Toon volledige file content, niet alleen snippets.
- **CL-10 (MUST)** Geef expliciete import statements en dependencies.
- **CL-11 (MUST)** Voeg installation/setup commands toe.

### Strikte Opdracht Uitvoering
- **CL-12 (MUST)** Geen eigen interpretatie - volg exacte instructies.
- **CL-13 (MUST)** Bij onduidelijkheid: stop en vraag, niet overslaan.
- **CL-14 (MUST)** Geen auto-activatie/deactivatie zonder expliciete vraag.

---

## 9 — Priority Matrix

### 🔴 CRITICAL - Always Apply
**Core Requirements (Breaking these = delivery rejected)**
- **BM-1, BM-2, BM-3** - Basis missie
- **IA-1 to IA-7** - Impact Analysis (NIEUW!)
- **SEC-1 to SEC-8** - Security
- **E-1 to E-4** - Error handling
- **CL-12 to CL-14** - Strikte opdracht uitvoering

### 🟠 HIGH - Most Projects
- **T-1, T-2, T-3** - TDD, 80% coverage
- **C-1 to C-5** - Code quality
- **GIT-1 to GIT-3** - Git conventions
- **CL-1 to CL-11** - Claude optimization

### 🟡 MEDIUM - Team/Project Dependent
- Documentation standards
- Accessibility requirements
- Team communication protocols

### 🟢 NICE-TO-HAVE
- Advanced testing (visual, cross-browser)
- Advanced monitoring tools
- IDE configurations

---

## 📚 Agent Skills System (NIEUW!)

**Claude gebruikt nu Agent Skills** - georganiseerde bundles van instructies, patronen en scripts die automatisch geladen worden op basis van je taak.

### 🎯 Automatische Skill Loading

Claude detecteert automatisch welke skills nodig zijn:

**Backend Development:**
→ Laadt: `backend-development-patterns`
- API design (REST/GraphQL)
- Database patterns
- Repository & Service layers
- Authentication patterns

**Security Review:**
→ Laadt: `security-essentials`
- OWASP Top 10 checklist
- Input validation patterns
- Secret management
- Security scan scripts

**Testing & QA:**
→ Laadt: `testing-fundamentals`
- TDD workflow (Red-Green-Refactor)
- Test coverage requirements
- AAA pattern
- Test data factories

**Production Deployment:**
→ Laadt: `deployment-workflows`
- CI/CD pipelines
- Zero-downtime strategies
- Health checks
- Rollback procedures

**Code Quality:**
→ Laadt: `production-code-standards`
- SOLID principles
- Error handling patterns
- Code review checklist
- Quality gate scripts

### 📦 Skills Locatie

Alle skills zijn beschikbaar in: `.claude-skills/`

Elke skill bevat:
- `SKILL.md` - Hoofd documentatie met progressive disclosure
- Detailed patterns - Diepgaande implementatie voorbeelden
- Scripts - Uitvoerbare tools en automatisering

### 🔄 Progressive Context Loading

Skills gebruiken 3 context levels:
1. **Minimal** (Level 1) - Altijd geladen, core principles
2. **Detailed** (Level 2) - Op verzoek, complete patronen
3. **Full** (Level 3) - Scripts en templates wanneer nodig

Dit bespaart context tokens en laadt alleen wat nodig is.

### 🎨 Skills vs Docs

**Skills** (`.claude/skills/`) = Reusable patterns + scripts + tools
**Docs** (`docs/`) = Project-specifieke documentatie

Skills zijn herbruikbaar over projecten heen, docs zijn project-specifiek.

### 📚 Beschikbare Extended Docs

Als je meer detail nodig hebt, zeg dan expliciet:
- **"Gebruik ook backend docs"** → laadt `docs/backend.md`
- **"Gebruik ook frontend docs"** → laadt `docs/frontend.md`
- **"Gebruik ook security docs"** → laadt `docs/security.md`
- **"Gebruik ook infrastructure docs"** → laadt `docs/infrastructure.md`
- **"Gebruik ook testing docs"** → laadt `docs/testing.md`

Claude doet dit meestal automatisch, maar je kunt het ook handmatig vragen.

---

## 🚀 Quick Commands

### Planning & Context
- **`/qnew`** - Start nieuwe taak (auto-load relevante docs)
- **`/qplan`** - Maak gedetailleerd plan
- **`/qcontext`** - Gather context

### Development
- **`/qcode`** - TDD flow
- **`/qrefactor`** - Code quality review

### Quality
- **`/qcheck`** - Senior review
- **`/qsecurity`** - Security checklist
- **`/qtest`** - Test completeness

### Operations
- **`/qgit`** - Commit & PR workflow

---

## 💡 Voor Niet-Technische Gebruikers

**Je hoeft GEEN technische taal te gebruiken!**

Zeg gewoon wat je wilt:
- ✅ "Ik wil dat bezoekers hun email kunnen achterlaten"
- ✅ "Maak een knop die data opslaat"
- ✅ "Gebruikers moeten kunnen inloggen"

Claude herkent dit automatisch en laadt de juiste documentatie.

---

## 🎯 Success Metrics

### Weekly Review
- [ ] First-time success rate > 70%
- [ ] Average iterations < 3
- [ ] Test coverage > 80%
- [ ] Security issues: 0
- [ ] Production bugs: < 2/week

### Continuous Improvement
1. Track metrics in `.claude-memory/metrics.md`
2. Identify bottlenecks
3. Update workflows
4. Share learnings

---

*Versie 5.0 - Modular Intent-Based System*
*Character count: ~8,500 (well under 40,000 limit)*
*Extended docs: docs/backend.md, docs/frontend.md, docs/security.md, docs/infrastructure.md, docs/testing.md*
