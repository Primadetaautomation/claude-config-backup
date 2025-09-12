# 🚀 UNIVERSAL QUALITY-FIRST DIRECTIVE

## APPLIES TO ALL AGENTS

As of today, ALL agents in this system MUST follow the Quality-First Integration Protocol.

### MANDATORY WORKFLOW FOR EVERY AGENT:

```yaml
BEFORE EXECUTION:
1. Check preflight-checklist results (must be > 90%)
2. Review impact-analyzer report
3. Consult pattern-library
4. Prepare rollback strategy

DURING EXECUTION:
1. Use simulation mode for risky operations
2. Follow TDD approach
3. Maintain test coverage > 80%
4. Zero tolerance for "it works on my machine"

AFTER EXECUTION:
1. Log decisions to decision-log.md
2. Update pattern-library if new pattern
3. Report metrics to session-memory
4. Document lessons learned
```

### INTEGRATION HIERARCHY:

```
USER REQUEST
    ↓
MASTER-ORCHESTRATOR (coordinates everything)
    ↓
PREFLIGHT-CHECKLIST (validates requirements)
    ↓
IMPACT-ANALYZER (predicts consequences)
    ↓
[ANY SPECIALIST AGENT] (executes with quality)
    ↓
SESSION-MEMORY (tracks everything)
```

### QUALITY METRICS (NON-NEGOTIABLE):
- First-time success rate: > 95%
- Iterations per task: < 2
- Test coverage: > 80%
- Production bugs: 0
- Decision documentation: 100%

### AGENT COMMUNICATION PROTOCOL:

Every agent receives from orchestrator:
```javascript
{
  preflightCheck: { passed: true, confidence: 95 },
  impactAnalysis: { risk: 'low', breaking: [] },
  patterns: ['auth-jwt', 'repository-pattern'],
  simulationMode: false,
  qualityGates: { coverage: 80, performance: 3000 }
}
```

Every agent reports back:
```javascript
{
  success: true,
  iterations: 1,
  coverage: 85,
  decisions: ['used-pattern-X', 'avoided-Y'],
  lessons: ['pattern-X optimal for this case']
}
```

### ENFORCEMENT:
- Master orchestrator WILL NOT execute agents without quality gates
- Automatic rollback on quality failure
- All agents share pattern library
- Continuous improvement via decision log

### LIST OF AGENTS UNDER THIS DIRECTIVE:
1. master-orchestrator ✅ (Enhanced)
2. preflight-checklist ✅ (New)
3. impact-analyzer ✅ (New)
4. senior-fullstack-developer ✅
5. qa-testing-engineer ✅
6. security-specialist ✅
7. devops-deployment-engineer ✅
8. session-memory-agent ✅
9. frontend-specialist ✅
10. backend-specialist ✅
11. solutions-architect ✅
12. playwright-test-agent ✅
13. ml-ai-integration ✅
14. data-engineer ✅
15. accessibility-specialist ✅
16. monitoring-observability ✅
17. code-reviewer ✅
18. database-architect ✅
19. performance-engineer ✅
20. load-stress-test ✅
21. lint-code-quality ✅
22. context_manager_agent ✅
23. business-analyst ✅
24. content-strategist ✅
25. product-manager ✅
26. technical-writer ✅
27. ux-ui-designer ✅
28. threat-modeling ✅
29. privacy-gdpr ✅
30. infra-as-code ✅
31. ci-cd-pipeline ✅
32. n8n-workflow-creator ✅

**ALL 32+ AGENTS NOW OPERATE UNDER QUALITY-FIRST PROTOCOL**

---
*Effective immediately. No exceptions.*