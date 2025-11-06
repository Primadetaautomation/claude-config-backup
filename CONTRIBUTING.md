# Contributing to Claude Dev Toolkit

**Thank you for your interest in contributing!** 🎉

This plugin is open source and welcomes contributions from the community.

---

## 🤝 How to Contribute

### **Ways to Contribute**

- 🐛 **Report bugs** - Found an issue? Let us know!
- 💡 **Suggest features** - Have an idea? Create an issue!
- 📝 **Improve documentation** - Help others understand better
- 🤖 **Add new agents** - Share your specialized agents
- 🎯 **Add new skills** - Contribute reusable patterns
- 🛠️ **Improve toolkit** - Enhance existing utilities
- 🌍 **Translations** - Add more languages

---

## 🚀 Quick Start for Contributors

### **1. Fork & Clone**

```bash
# Fork the repo on GitHub (click "Fork" button)

# Clone YOUR fork
git clone https://github.com/YOUR-USERNAME/claude-dev-toolkit.git
cd claude-dev-toolkit

# Add upstream remote
git remote add upstream https://github.com/Primadetaautomation/claude-dev-toolkit.git
```

### **2. Create a Branch**

```bash
# Always create a new branch for your changes
git checkout -b feature/your-feature-name

# Examples:
# git checkout -b feature/add-rust-agent
# git checkout -b fix/playwright-config
# git checkout -b docs/improve-installation
```

### **3. Make Your Changes**

Follow these guidelines:

#### **Adding a New Agent**

```bash
# Create agent file in agents/
touch agents/your-agent-name.md

# Follow this template:
```

```markdown
# Agent Name

**Purpose:** Brief description of what this agent does

## Expertise

- Area 1
- Area 2
- Area 3

## When to Use

Use this agent when you need to...

## Tools & Technologies

- Tool 1
- Tool 2

## Best Practices

1. Practice 1
2. Practice 2

## Example Usage

\`\`\`
You: "Use your-agent-name to help me..."
Agent: *Response*
\`\`\`
```

#### **Adding a New Skill**

```bash
# Create skill directory
mkdir -p skills/your-skill-name

# Create SKILL.md
touch skills/your-skill-name/SKILL.md
```

Follow the progressive disclosure pattern:
- Level 1: Core principles (always loaded)
- Level 2: Detailed patterns (on request)
- Level 3: Scripts and templates (when needed)

#### **Improving Documentation**

- Keep it clear and concise
- Add examples where possible
- Maintain bilingual support (EN/NL) where applicable
- Use proper markdown formatting

### **4. Test Your Changes**

```bash
# Test the plugin locally
cd ~/claude-dev-toolkit

# Install locally
/plugin marketplace add ~/claude-dev-toolkit
/plugin install claude-dev-toolkit

# Verify your changes work
# Try using the new agent/skill/feature
```

### **5. Commit Your Changes**

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git add .

# Format: type(scope): description
# Examples:
git commit -m "feat(agents): add rust-specialist agent"
git commit -m "fix(playwright): correct CPU throttling config"
git commit -m "docs(readme): improve installation instructions"
git commit -m "refactor(toolkit): simplify retry pattern"
```

**Commit Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

### **6. Push & Create Pull Request**

```bash
# Push to YOUR fork
git push origin feature/your-feature-name

# GitHub will show a "Compare & pull request" button
# Click it and fill in:
# - Clear title
# - Description of what you changed
# - Why you made this change
# - Any testing you did
```

**Pull Request Template:**

```markdown
## Description
Brief description of your changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
How did you test this?

## Checklist
- [ ] My code follows the project style
- [ ] I have tested my changes
- [ ] I have updated the documentation
- [ ] My commits follow conventional commits
```

---

## 📋 Contribution Guidelines

### **Code Standards**

- **Agents**: Clear purpose, well-documented, follows existing patterns
- **Skills**: Progressive disclosure (3 levels), includes examples
- **Toolkit**: Defensive programming, comprehensive error handling
- **Documentation**: Clear, concise, examples included

### **File Structure**

```
agents/           # Specialized agents
skills/           # Reusable skills with progressive disclosure
toolkit/          # Utilities and tools
  defensive/      # Defensive programming patterns
  knowledge/      # Knowledge extraction tools
  transcripts/    # Transcript management
  worktrees/      # Git worktree helpers
docs/             # Documentation
scripts/          # Automation scripts
memory/           # Session templates
```

### **What We Look For**

✅ **Good Pull Requests:**
- Focused on one thing
- Well-tested
- Documented
- Follows existing patterns
- Clear commit messages

❌ **Pull Requests We Can't Accept:**
- Breaking changes without discussion
- Undocumented features
- Code without tests
- Multiple unrelated changes
- Poor code quality

---

## 🐛 Reporting Bugs

Found a bug? Help us fix it!

**Create an issue with:**

1. **Title**: Brief description
2. **Description**:
   - What you expected to happen
   - What actually happened
   - Steps to reproduce
3. **Environment**:
   - Claude Code version
   - Plugin version
   - Operating system
4. **Additional Context**:
   - Screenshots if applicable
   - Error messages
   - Logs

**Issue Template:**

```markdown
**Describe the bug**
Clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Install plugin
2. Run command '...'
3. See error

**Expected behavior**
What you expected to happen.

**Environment**
- Claude Code version:
- Plugin version:
- OS:

**Additional context**
Add any other context, screenshots, or logs.
```

---

## 💡 Suggesting Features

Have an idea? We'd love to hear it!

**Create an issue with:**

1. **Title**: Feature request: [Your idea]
2. **Description**:
   - What problem does this solve?
   - How would it work?
   - Why is it valuable?
3. **Examples**: How would someone use this?
4. **Alternatives**: Other solutions you considered

---

## 🔄 Keeping Your Fork Updated

```bash
# Fetch latest changes from upstream
git fetch upstream

# Merge into your local main
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

---

## 📜 Code of Conduct

### **Our Standards**

✅ **Be respectful and inclusive**
✅ **Constructive feedback**
✅ **Focus on the best outcome**
✅ **Help others learn and grow**

❌ **No harassment or discrimination**
❌ **No trolling or insulting**
❌ **No spam or off-topic content**

---

## 🎯 Recognition

Contributors will be:
- Added to CONTRIBUTORS.md
- Mentioned in release notes
- Credited in their contributed code

---

## 📞 Questions?

- **Issues**: https://github.com/Primadetaautomation/claude-dev-toolkit/issues
- **Discussions**: https://github.com/Primadetaautomation/claude-dev-toolkit/discussions

---

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for making Claude Dev Toolkit better!** 🙏

Every contribution, no matter how small, is valued and appreciated.
