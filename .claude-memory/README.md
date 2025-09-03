# 📚 Claude Memory System

This directory contains the persistent memory system for Claude Code sessions.

## 📁 File Structure

- **session-current.md** - Active session documentation
- **session-history.md** - Archive of all past sessions
- **project-state.md** - Current project status snapshot
- **decisions-log.md** - Architectural and design decisions
- **errors-solutions.md** - Database of encountered errors and their solutions
- **code-inventory.md** - Catalog of all project files and their purposes
- **dependencies.md** - Package versions and configurations
- **test-status.md** - Testing progress and results
- **security-audit.md** - Security findings and remediation
- **handover-notes.md** - Quick start guide for next session

## 🚀 Quick Start

To continue from previous session:
```bash
cat handover-notes.md
```

## 🔄 Auto-Update Schedule

Files are automatically updated by the Session Memory Agent:
- **session-current.md** - Every 5 actions or significant change
- **handover-notes.md** - At session end or major milestone
- **project-state.md** - After component changes
- **Other files** - As relevant events occur

## ⚠️ Important Notes

- Do NOT manually edit these files during active sessions
- Files are auto-generated and managed by Session Memory Agent
- Backup important information before major changes
- Historical data older than 30 days may be compressed