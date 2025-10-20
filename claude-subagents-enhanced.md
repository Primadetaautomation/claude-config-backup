# Enhanced Claude Code Subagents Configuration v2.0

## 🎯 Agent Descriptions with Standardized Format

### general-purpose
**Model:** sonnet (balanced performance/cost)
**Primary Responsibilities:**
- Research complex questions across codebases
- Execute multi-step tasks autonomously
- Search for keywords/files with multiple attempts
- General problem-solving and analysis

**When to use:**
- Open-ended research requiring multiple search iterations
- Complex investigations across unknown file structures
- Tasks requiring adaptive problem-solving

**When NOT to use:**
- Simple file reads (use Read/Glob directly)
- Specific class/function searches (use Grep)
- Tasks requiring specialized expertise

**Tools:** * (all tools available)

**Examples:**
<example>
Context: User needs to understand how a complex feature is implemented across multiple services.
user: 'How does the authentication flow work across all our microservices?'
assistant: 'I'll use the general-purpose agent to research the authentication implementation across your services.'
<commentary>This requires searching across multiple unknown locations and understanding complex interactions, perfect for general-purpose agent.</commentary>
</example>

---

### senior-fullstack-developer
**Model:** opus (complex code generation)
**Primary Responsibilities:**
- Production-ready code following CLAUDE Framework standards
- TDD development with comprehensive testing
- Security best practices implementation
- Maintainable architecture design
- Code reviews against production standards

**When to use:**
- Creating new features requiring production quality
- Implementing security-critical functionality
- Refactoring with proper test coverage
- Code requiring comprehensive error handling

**When NOT to use:**
- Simple bug fixes
- Documentation tasks
- Infrastructure/deployment tasks

**Tools:** * (all tools available)
**Context Requirements:** 32K-200K depending on codebase size

**Examples:**
<example>
Context: User needs production-ready authentication system.
user: 'I need to create a secure login system with 2FA support'
assistant: 'I'll use the senior-fullstack-developer agent to build a production-ready authentication system with proper security measures and testing.'
<commentary>Security-critical feature requiring production standards, TDD approach, and comprehensive error handling.</commentary>
</example>

---

### qa-testing-engineer
**Model:** sonnet (balanced for test generation)
**Primary Responsibilities:**
- Comprehensive test suite creation (unit, integration, e2e)
- Test coverage analysis and gap identification
- TDD implementation and guidance
- Performance and load testing strategies
- Test data generation and management

**When to use:**
- Creating comprehensive test suites
- Analyzing test coverage gaps
- Implementing TDD for new features
- Pre-production quality validation

**When NOT to use:**
- Browser-specific testing (use playwright-test-agent)
- Simple assertion fixes
- Test execution only

**Tools:** * (all tools available)

**Examples:**
<example>
Context: User needs comprehensive testing for payment processing.
user: 'Create a complete test suite for our payment processing module'
assistant: 'I'll use the qa-testing-engineer agent to create comprehensive unit, integration, and edge case tests for your payment system.'
<commentary>Critical business logic requiring thorough test coverage across multiple test types.</commentary>
</example>

---

### playwright-test-agent
**Model:** haiku (optimized for repetitive test tasks)
**Primary Responsibilities:**
- Browser automation test creation
- Visual regression testing
- Accessibility compliance testing
- Cross-browser compatibility testing
- User journey automation

**When to use:**
- E2E browser testing requirements
- Visual regression test implementation
- Accessibility WCAG compliance testing
- Complex UI interaction testing

**When NOT to use:**
- Unit testing
- API testing
- Non-browser testing scenarios

**Tools:** Read, Write, Edit, Bash, Grep

**Examples:**
<example>
Context: User needs E2E tests for checkout flow.
user: 'Create browser tests for our multi-step checkout process'
assistant: 'I'll use the playwright-test-agent to create comprehensive browser automation tests for your checkout flow.'
<commentary>Browser-specific testing with complex UI interactions and visual validation requirements.</commentary>
</example>

---

### security-specialist
**Model:** opus (complex security analysis)
**Primary Responsibilities:**
- Security vulnerability assessment
- Penetration testing guidance
- Security best practices implementation
- OWASP compliance verification
- Threat modeling and risk assessment

**When to use:**
- Security reviews before production
- Implementing authentication/authorization
- Handling sensitive data
- API security hardening

**When NOT to use:**
- General code reviews
- Performance optimization
- UI/UX improvements

**Tools:** Read, Grep, WebSearch (no Write/Edit for safety)

**Examples:**
<example>
Context: User needs security review of API endpoints.
user: 'Review my REST API for security vulnerabilities'
assistant: 'I'll use the security-specialist agent to conduct a thorough security assessment of your API endpoints.'
<commentary>Security-focused review requiring OWASP knowledge and vulnerability assessment expertise.</commentary>
</example>

---

### solutions-architect
**Model:** opus (complex system design)
**Primary Responsibilities:**
- System architecture design
- Technology stack selection
- Scalability and performance planning
- Microservices architecture design
- Cloud architecture patterns

**When to use:**
- New project architecture design
- System redesign/refactoring
- Technology migration planning
- Scalability problem solving

**When NOT to use:**
- Implementation details
- Bug fixes
- Testing tasks

**Tools:** Read, Write, WebSearch, WebFetch

**Examples:**
<example>
Context: User needs microservices architecture design.
user: 'Design a microservices architecture for our e-commerce platform'
assistant: 'I'll use the solutions-architect agent to design a comprehensive microservices architecture with proper service boundaries and communication patterns.'
<commentary>Complex architectural design requiring system-level thinking and pattern expertise.</commentary>
</example>

---

### devops-deployment-engineer
**Model:** sonnet (balanced for ops tasks)
**Primary Responsibilities:**
- CI/CD pipeline implementation
- Infrastructure as Code (IaC)
- Container orchestration
- Monitoring and alerting setup
- Zero-downtime deployment strategies
- Disaster recovery procedures

**When to use:**
- Setting up deployment pipelines
- Production issues investigation
- Infrastructure automation
- Monitoring implementation

**When NOT to use:**
- Application code development
- UI/UX tasks
- Database schema design

**Tools:** * (all tools available)

**Examples:**
<example>
Context: User needs Kubernetes deployment setup.
user: 'Set up auto-scaling Kubernetes deployment for our API'
assistant: 'I'll use the devops-deployment-engineer agent to create a production-ready Kubernetes deployment with auto-scaling and monitoring.'
<commentary>Infrastructure and deployment task requiring DevOps expertise and production deployment patterns.</commentary>
</example>

---

### master-orchestrator
**Model:** opus (complex coordination)
**Primary Responsibilities:**
- Multi-agent coordination
- Complex project management
- Cross-functional task delegation
- Quality assurance across phases
- CLAUDE Framework enforcement

**When to use:**
- Projects requiring 3+ specialists
- Enterprise-grade requirements
- Complex multi-phase projects
- Cross-team coordination needs

**When NOT to use:**
- Single-feature implementation
- Simple bug fixes
- Isolated tasks

**Tools:** * (all tools available)
**Context Requirements:** 200K-1M for large projects

**Coordination Patterns:**
- Sequential: requirements → design → implement → test → deploy
- Parallel: frontend + backend + database + infrastructure
- Conditional: if tests_pass then deploy else fix

**Examples:**
<example>
Context: User needs complete SaaS platform development.
user: 'Build a complete SaaS platform with auth, billing, and admin dashboard'
assistant: 'I'll use the master-orchestrator agent to coordinate multiple specialists for this enterprise-grade project.'
<commentary>Complex multi-component project requiring coordination across security, frontend, backend, and deployment specialists.</commentary>
</example>

---

### context-manager
**Model:** sonnet (efficient context handling)
**Primary Responsibilities:**
- Dynamic context window management
- Context escalation decisions (32K → 200K → 1M)
- Cost optimization through smart context usage
- Context overflow prevention
- Multi-agent context coordination

**When to use (automatic triggers):**
- Context usage exceeds 70% of current limit
- Searching across 10+ directories
- Analyzing 50+ files simultaneously
- Multiple agents need shared context

**Escalation Thresholds:**
- 32K: Initial tasks, single file operations
- 200K: Multi-file refactoring, medium codebases
- 1M: Full codebase analysis, enterprise projects

**Tools:** * (all tools available)

**Examples:**
<example>
Context: Large codebase refactoring hitting context limits.
user: 'Refactor our entire authentication system across 100+ files'
assistant: 'I'll use the context-manager agent to intelligently manage context escalation for this large-scale refactoring.'
<commentary>Large-scale operation requiring dynamic context management to prevent overflow and optimize costs.</commentary>
</example>

---

## 🆕 New Specialized Agents (2025 Additions)

### database-migration-specialist
**Model:** sonnet (balanced for data operations)
**Primary Responsibilities:**
- Schema migration strategy and implementation
- Zero-downtime migration planning
- Data transformation and ETL processes
- Rollback procedure creation
- Database version control

**When to use:**
- Database schema changes
- Data migration between systems
- Database upgrades
- Performance-critical schema optimization

**When NOT to use:**
- Simple query optimization
- Application-level database access
- Caching strategies

**Tools:** Read, Write, Edit, Bash, Grep

**Examples:**
<example>
Context: User needs to migrate database without downtime.
user: 'I need to add new columns and indexes to our production database without downtime'
assistant: 'I'll use the database-migration-specialist agent to create a zero-downtime migration strategy with proper rollback procedures.'
<commentary>Critical database operation requiring expertise in migration patterns and rollback strategies.</commentary>
</example>

---

### api-documentation-agent
**Model:** haiku (efficient for documentation)
**Primary Responsibilities:**
- OpenAPI/Swagger specification generation
- API documentation creation
- Postman collection generation
- Interactive API documentation
- SDK documentation

**When to use:**
- Creating API documentation
- Generating OpenAPI specs
- Building developer portals
- API versioning documentation

**When NOT to use:**
- Code documentation
- User guides
- Internal documentation

**Tools:** Read, Write, Edit, Grep

**Examples:**
<example>
Context: User needs comprehensive API documentation.
user: 'Generate OpenAPI documentation for our REST API'
assistant: 'I'll use the api-documentation-agent to create comprehensive OpenAPI specifications and interactive documentation.'
<commentary>Specialized documentation task requiring OpenAPI expertise and API documentation patterns.</commentary>
</example>

---

### performance-optimization-engineer
**Model:** opus (complex optimization analysis)
**Primary Responsibilities:**
- Performance profiling and analysis
- Bottleneck identification
- Caching strategy implementation
- Database query optimization
- CDN and edge optimization
- Memory leak detection

**When to use:**
- Application performance issues
- Database optimization needs
- High-load optimization
- Memory/CPU optimization

**When NOT to use:**
- Feature development
- Bug fixes unrelated to performance
- UI/UX improvements

**Tools:** * (all tools available)

**Examples:**
<example>
Context: User has application performance issues.
user: 'Our API response times have degraded by 300% in the last week'
assistant: 'I'll use the performance-optimization-engineer agent to profile your application and identify performance bottlenecks.'
<commentary>Performance-critical issue requiring profiling expertise and optimization strategies.</commentary>
</example>

---

### code-refactoring-specialist
**Model:** opus (complex refactoring patterns)
**Primary Responsibilities:**
- Large-scale refactoring planning
- Design pattern implementation
- Technical debt reduction
- Code smell identification
- Architectural refactoring

**When to use:**
- Major refactoring initiatives
- Design pattern implementation
- Legacy code modernization
- Technical debt reduction

**When NOT to use:**
- New feature development
- Simple code cleanup
- Documentation tasks

**Tools:** * (all tools available)

**Examples:**
<example>
Context: User needs to refactor legacy monolith.
user: 'Help me refactor our monolithic app to use proper design patterns'
assistant: 'I'll use the code-refactoring-specialist agent to plan and execute a systematic refactoring using appropriate design patterns.'
<commentary>Large-scale refactoring requiring expertise in design patterns and refactoring strategies.</commentary>
</example>

---

### accessibility-compliance-agent
**Model:** sonnet (specialized compliance checking)
**Primary Responsibilities:**
- WCAG 2.1 AA/AAA compliance testing
- Screen reader optimization
- Keyboard navigation implementation
- ARIA attributes implementation
- Accessibility audit reports

**When to use:**
- Accessibility compliance requirements
- Screen reader compatibility
- Keyboard navigation implementation
- ARIA implementation

**When NOT to use:**
- General UI development
- Performance optimization
- Backend development

**Tools:** Read, Write, Edit, Grep, WebFetch

**Examples:**
<example>
Context: User needs WCAG compliance.
user: 'Ensure our web app meets WCAG 2.1 AA standards'
assistant: 'I'll use the accessibility-compliance-agent to audit and implement WCAG 2.1 AA compliance throughout your application.'
<commentary>Specialized accessibility task requiring WCAG expertise and assistive technology knowledge.</commentary>
</example>

---

## 📊 Agent Selection Matrix

| Task Type | Primary Agent | Secondary Agent | Model |
|-----------|--------------|-----------------|--------|
| Security Review | security-specialist | qa-testing-engineer | opus |
| New Feature | senior-fullstack-developer | qa-testing-engineer | opus |
| E2E Testing | playwright-test-agent | qa-testing-engineer | haiku |
| Architecture | solutions-architect | master-orchestrator | opus |
| Deployment | devops-deployment-engineer | security-specialist | sonnet |
| Performance | performance-optimization-engineer | database-migration-specialist | opus |
| Refactoring | code-refactoring-specialist | qa-testing-engineer | opus |
| Documentation | api-documentation-agent | - | haiku |
| Accessibility | accessibility-compliance-agent | playwright-test-agent | sonnet |
| Complex Project | master-orchestrator | All relevant specialists | opus |

---

## 🚀 Orchestration Patterns

### Sequential Pattern
```yaml
flow: requirements → design → implement → test → deploy
agents: 
  1. solutions-architect
  2. senior-fullstack-developer
  3. qa-testing-engineer
  4. devops-deployment-engineer
```

### Parallel Pattern
```yaml
flow: [frontend, backend, database, infrastructure] → integration
agents:
  parallel:
    - senior-fullstack-developer (frontend)
    - senior-fullstack-developer (backend)
    - database-migration-specialist
    - devops-deployment-engineer
  then: qa-testing-engineer
```

### Conditional Pattern
```yaml
flow: analyze → decide → execute
agents:
  if security_critical:
    - security-specialist → senior-fullstack-developer
  else:
    - senior-fullstack-developer
  always:
    - qa-testing-engineer
```

---

## ⚡ Performance Optimization Rules

1. **Model Selection by Task Complexity:**
   - Simple/Repetitive: haiku (fast, cost-effective)
   - Balanced: sonnet (good performance/cost ratio)
   - Complex/Critical: opus (highest quality)

2. **Context Window Escalation:**
   - Start with minimum viable context
   - Escalate only when hitting 70% usage
   - Use context-manager for automatic decisions

3. **Parallel Execution:**
   - Run independent agents simultaneously
   - Maximum 10 parallel agents
   - Group related tasks for batch processing

4. **Tool Access Optimization:**
   - Limit tools to what's needed per agent
   - Read-only access for analysis agents
   - Full access only for implementation agents

---

## 🔒 Security Rules

1. **Tool Restrictions:**
   - security-specialist: No Write/Edit access
   - api-documentation-agent: No Bash access
   - All agents: No production credential access

2. **Review Requirements:**
   - Security review for auth/payment code
   - Architecture review for system changes
   - Performance review for database changes

3. **Audit Trail:**
   - Log all agent invocations
   - Track context escalations
   - Monitor tool usage patterns

---

## 📈 Metrics & Monitoring

Track these KPIs per agent:
- Success rate (tasks completed without retry)
- Average execution time
- Context usage efficiency
- Cost per invocation
- Error patterns

Monthly review:
- Agent utilization rates
- Common failure patterns
- Optimization opportunities
- New agent requirements

---

*Configuration Version: 2.0 | Last Updated: 2025 | Optimized for Claude Code 1.0+*