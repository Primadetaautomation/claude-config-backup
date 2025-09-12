#!/bin/bash

# Quality-First Integration Update Script
# Updates all agents with quality-first mandate

AGENTS=(
  "security-specialist"
  "devops-deployment-engineer"
  "session-memory-agent"
  "frontend-specialist"
  "backend-specialist"
  "solutions-architect"
  "code-reviewer"
  "playwright-test-agent"
  "database-architect"
  "ml-ai-integration"
  "data-engineer"
  "accessibility-specialist"
  "performance-engineer"
  "monitoring-observability"
)

QUALITY_FIRST_TEXT="

## QUALITY-FIRST INTEGRATION
- **MUST** verify preflight-checklist passed with 90%+ confidence
- **MUST** review impact-analyzer report before any changes
- **MUST** use pattern-library for proven solutions
- **MUST** run simulation mode for risky operations
- **MUST** maintain 95% first-time success rate
- **MUST** log all decisions to decision-log.md
- **REFER TO**: agents/QUALITY-FIRST-INTEGRATION.md for full protocol"

for agent in "${AGENTS[@]}"; do
  AGENT_FILE="agents/${agent}.md"
  
  if [ -f "$AGENT_FILE" ]; then
    echo "Updating $agent..."
    
    # Check if already has quality-first section
    if ! grep -q "QUALITY-FIRST INTEGRATION" "$AGENT_FILE"; then
      # Find line number after the agent description (after first ---)
      LINE_NUM=$(grep -n "^---$" "$AGENT_FILE" | sed -n '2p' | cut -d: -f1)
      
      if [ ! -z "$LINE_NUM" ]; then
        # Insert quality-first text after the metadata section
        sed -i.bak "${LINE_NUM}a\\
${QUALITY_FIRST_TEXT}
" "$AGENT_FILE"
        echo "✅ Updated $agent"
      else
        echo "⚠️  Could not find insertion point for $agent"
      fi
    else
      echo "✓ $agent already has quality-first integration"
    fi
  else
    echo "❌ $agent file not found"
  fi
done

echo "
🎯 Quality-First Integration Complete!
All agents now follow the zero-errors framework.
"