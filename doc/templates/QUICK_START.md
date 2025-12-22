# Quick Start: Choosing the Right Template

Use this guide to quickly select the appropriate documentation template for your task.

## Decision Tree

```
What are you documenting?

├─ New Feature or Breaking Change
│  └─ Use: FEATURE_TEMPLATE.md
│     Example: Adding new lint rules, changing default behavior
│
├─ Version Upgrade Guide
│  └─ Use: MIGRATION_TEMPLATE.md
│     Example: v2.0 to v2.1 upgrade, breaking change migration
│
├─ Code Improvements or Refactoring
│  └─ Use: OPTIMIZATION_TEMPLATE.md
│     Example: Reducing code duplication, performance improvements
│
└─ Tutorial or How-to Guide
   └─ Use: HOW_TO_TEMPLATE.md
      Example: How to create a lint, how to contribute
```

---

## Quick Template Comparison

| Template | Purpose | Length | Audience | Update Frequency |
|----------|---------|--------|----------|------------------|
| **FEATURE** | Design & plan features | Long | Developers & Stakeholders | Throughout development |
| **MIGRATION** | Guide version upgrades | Medium | End Users | Once per version |
| **OPTIMIZATION** | Track improvements | Long | Developers | Throughout optimization |
| **HOW_TO** | Teach a task | Medium | Developers & Contributors | Rarely (unless API changes) |

---

## Common Scenarios

### "I'm adding a new feature to the package"

**Use:** `FEATURE_TEMPLATE.md`

**Steps:**
```bash
cp doc/templates/FEATURE_TEMPLATE.md doc/feature/$(date +%Y-%m-%d)-my-feature.md
```

**Fill in:**
- Executive Summary (what's changing and why)
- Motivation (the problem you're solving)
- Technical Design (how you'll implement it)
- Implementation Checklist (break down the work)

---

### "I'm making a breaking change"

**Use both:**
1. `FEATURE_TEMPLATE.md` - for design and planning
2. `MIGRATION_TEMPLATE.md` - for user upgrade guide

**Steps:**
```bash
# 1. Feature document
cp doc/templates/FEATURE_TEMPLATE.md doc/feature/$(date +%Y-%m-%d)-my-feature.md

# 2. Migration guide
cp doc/templates/MIGRATION_TEMPLATE.md doc/migration/v2.0-to-v2.1.md
```

**Key sections:**
- Feature doc: Focus on "Breaking Changes" and "Migration Guide" sections
- Migration doc: Provide multiple migration paths and examples

---

### "I want to refactor or optimize code"

**Use:** `OPTIMIZATION_TEMPLATE.md`

**Steps:**
```bash
cp doc/templates/OPTIMIZATION_TEMPLATE.md doc/optimization/$(date +%Y-%m-%d-%H%M)-optimization-name.md
```

**Fill in:**
- Executive Summary with metrics
- Categorize by priority (High/Medium/Low)
- Track before/after metrics
- Document implementation status

---

### "I'm writing a tutorial or guide"

**Use:** `HOW_TO_TEMPLATE.md`

**Steps:**
```bash
cp doc/templates/HOW_TO_TEMPLATE.md doc/how-to-my-task.md
```

**Fill in:**
- Prerequisites
- Step-by-step instructions with code examples
- Complete working example
- Common issues and solutions

---

## Template Quick Copy Commands

### Feature Document
```bash
cp doc/templates/FEATURE_TEMPLATE.md doc/feature/$(date +%Y-%m-%d)-[feature-name].md
```

### Migration Guide
```bash
cp doc/templates/MIGRATION_TEMPLATE.md doc/migration/v[old]-to-v[new].md
```

### Optimization Document
```bash
cp doc/templates/OPTIMIZATION_TEMPLATE.md doc/optimization/$(date +%Y-%m-%d-%H%M)-[optimization-name].md
```

### How-to Guide
```bash
cp doc/templates/HOW_TO_TEMPLATE.md doc/how-to-[task-name].md
```

---

## After Creating Your Document

1. **Replace all placeholders**
   - Search for `[` to find all bracketed placeholders
   - Fill in or remove each one

2. **Remove unnecessary sections**
   - If a section doesn't apply, remove it entirely
   - Don't leave empty sections

3. **Add to version control**
   ```bash
   git add doc/[category]/[your-document].md
   git commit -m "docs: add [document-type] for [topic]"
   ```

4. **Link from relevant places**
   - Update README.md if needed
   - Link from CLAUDE.md for AI context
   - Reference in CHANGELOG.md

---

## Examples

### Good Example: Feature Document

```markdown
# Opt-in Rules by Default

**Project:** Awesome Lints
**Target Version:** 2.1.0
**Document Date:** 2025-12-22
**Status:** Implemented
**Breaking Change:** Yes

## Executive Summary

This feature changes awesome_lints from an opt-out model...
[Clear, specific content]
```

### Bad Example: Feature Document

```markdown
# [Feature Name]

**Project:** [Project Name]
**Target Version:** [Version]
[Still has all the placeholders - not filled in]
```

---

## Need Help?

1. **Look at examples:** See existing docs for reference
   - `doc/feature/2025-12-22-opt-in-rules-by-default.md`
   - `doc/migration/v2.0-to-v2.1.md`
   - `doc/how-to-create-custom-lint.md`

2. **Read the full README:** `doc/templates/README.md`

3. **Ask questions:** Open a discussion or issue

---

## Tips for Success

✅ **Do:**
- Start with the template
- Fill in all sections thoroughly
- Use real examples from your code
- Test all code snippets
- Update status as you progress
- Keep it concise but complete

❌ **Don't:**
- Leave placeholder text
- Skip important sections
- Write without testing examples
- Forget to update the document as things change
- Make it too long - break into multiple docs if needed

---

**Last Updated:** 2025-12-22
