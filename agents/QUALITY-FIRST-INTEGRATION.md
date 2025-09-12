# 🎯 QUALITY-FIRST INTEGRATION STANDARD

## MANDATORY for ALL Agents

### Pre-Execution Protocol
Every agent MUST follow this sequence:

```yaml
1. RECEIVE TASK
   ↓
2. CHECK PREFLIGHT RESULTS
   - Requirements validated? ✓
   - Environment ready? ✓
   - Confidence > 90%? ✓
   ↓
3. REVIEW IMPACT ANALYSIS
   - Breaking changes? []
   - Performance impact? < 5%
   - Security risks? None
   ↓
4. CONSULT PATTERN LIBRARY
   - Existing solution? Use it
   - New pattern? Document it
   ↓
5. EXECUTE WITH QUALITY
   - TDD approach
   - Simulation first
   - Rollback ready
   ↓
6. LOG DECISIONS
   - What was done
   - Why this approach
   - Lessons learned
```

### Quality Metrics (MUST achieve)
- First-time success rate: > 95%
- Iterations per task: < 2
- Test coverage: > 80%
- Zero production bugs
- Decision documentation: 100%

### Integration Points

#### FROM Master Orchestrator
```javascript
{
  preflightResults: { confidence: 95, risks: [] },
  impactAnalysis: { breaking: 0, affected: ['file1.js'] },
  patternSuggestions: ['JWT-auth', 'repository-pattern'],
  qualityThresholds: { coverage: 80, performance: 3000 }
}
```

#### TO Session Memory
```javascript
{
  taskCompleted: true,
  decisionsLogged: ['used-pattern-X', 'avoided-Y'],
  metricsAchieved: { iterations: 1, coverage: 85 },
  lessonsLearned: ['pattern-X worked well for auth']
}
```

### Failure Protocol
If quality gates fail:
1. STOP immediately
2. Report to master-orchestrator
3. Document failure reason
4. Suggest remediation
5. Wait for new instructions

### Success Amplification
When quality gates pass:
1. Add to pattern library
2. Update decision log
3. Share with team
4. Optimize for next time

## Agent-Specific Enhancements

### qa-testing-engineer
- Use preflight to validate test requirements
- Use impact to focus test coverage
- Use patterns for test templates

### security-specialist
- Preflight checks for compliance requirements
- Impact analysis for vulnerability propagation
- Pattern library for security best practices

### devops-deployment-engineer
- Preflight for environment readiness
- Impact for deployment risks
- Simulation for rollback testing

### frontend/backend-specialist
- Preflight for API contracts
- Impact for breaking changes
- Patterns for architecture

### session-memory
- Track quality metrics over time
- Identify recurring issues
- Suggest process improvements

## Enforcement
- Master orchestrator BLOCKS tasks without quality gates
- Automatic rollback on quality failure
- Weekly quality metrics review
- Continuous pattern library updates

**Remember: Quality is not negotiable. Speed comes from doing it right the first time.**