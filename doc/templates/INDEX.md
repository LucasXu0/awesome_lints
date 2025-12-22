# Documentation Templates Index

This directory contains reusable markdown templates for creating consistent, high-quality documentation in the Awesome Lints project.

## 📚 Available Templates

### 1. [FEATURE_TEMPLATE.md](FEATURE_TEMPLATE.md)
**Size:** ~430 lines | **Complexity:** High

Design and document new features, breaking changes, and architectural decisions.

**Sections:** Executive Summary, Motivation, Technical Design, Implementation Checklist, Testing Strategy, Migration Guide

**Best for:** Major features, breaking changes, architectural refactors

---

### 2. [MIGRATION_TEMPLATE.md](MIGRATION_TEMPLATE.md)
**Size:** ~290 lines | **Complexity:** Medium

Guide users through version upgrades and breaking changes.

**Sections:** Impact Assessment, Migration Paths, Examples, Troubleshooting, Rollback Plan, FAQ

**Best for:** Version upgrade guides, breaking change documentation

---

### 3. [OPTIMIZATION_TEMPLATE.md](OPTIMIZATION_TEMPLATE.md)
**Size:** ~460 lines | **Complexity:** High

Document optimization opportunities, performance improvements, and refactoring work.

**Sections:** Analysis by Priority, Metrics & Impact, Implementation Roadmap, Risk Assessment, Lessons Learned

**Best for:** Code refactoring, performance improvements, technical debt reduction

---

### 4. [HOW_TO_TEMPLATE.md](HOW_TO_TEMPLATE.md)
**Size:** ~330 lines | **Complexity:** Medium

Create step-by-step tutorials and guides for common tasks.

**Sections:** Prerequisites, Step-by-Step Instructions, Examples, Best Practices, Troubleshooting, FAQ

**Best for:** Tutorials, onboarding guides, workflow documentation

---

## 🚀 Quick Start

**New to these templates?** Read [QUICK_START.md](QUICK_START.md) for:
- Decision tree to choose the right template
- Quick copy commands
- Common scenarios and examples
- Tips for success

**Need detailed guidance?** Read [README.md](README.md) for:
- Comprehensive template descriptions
- Usage guidelines and best practices
- Naming conventions
- Review checklist
- Template maintenance

---

## 📖 Real-World Examples

See these documents for examples of templates in use:

| Template Type | Example Document | Description |
|---------------|-----------------|-------------|
| Feature | [opt-in-rules-by-default.md](../feature/2025-12-22-opt-in-rules-by-default.md) | Breaking change feature with migration guide |
| Migration | [v2.0-to-v2.1.md](../migration/v2.0-to-v2.1.md) | Version upgrade guide |
| Optimization | [code-optimization-opportunities.md](../optimization/2025-12-22-1413-code-optimization-opportunities.md) | Comprehensive refactoring analysis |
| How-to | [how-to-create-custom-lint.md](../how-to-create-custom-lint.md) | Step-by-step tutorial |

---

## 🎯 Choosing the Right Template

```
┌─────────────────────────────────────────────────────┐
│ What are you documenting?                           │
├─────────────────────────────────────────────────────┤
│                                                     │
│  📋 New Feature / Breaking Change                   │
│     → FEATURE_TEMPLATE.md                           │
│                                                     │
│  🔄 Version Upgrade                                 │
│     → MIGRATION_TEMPLATE.md                         │
│                                                     │
│  ⚡ Code Optimization / Refactoring                 │
│     → OPTIMIZATION_TEMPLATE.md                      │
│                                                     │
│  📖 Tutorial / Guide                                │
│     → HOW_TO_TEMPLATE.md                            │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 🛠️ Template Usage Workflow

### 1. Choose Template
Use the decision tree above or consult [QUICK_START.md](QUICK_START.md)

### 2. Copy Template
```bash
# Feature
cp doc/templates/FEATURE_TEMPLATE.md doc/feature/$(date +%Y-%m-%d)-my-feature.md

# Migration
cp doc/templates/MIGRATION_TEMPLATE.md doc/migration/vX.Y-to-vA.B.md

# Optimization
cp doc/templates/OPTIMIZATION_TEMPLATE.md doc/optimization/$(date +%Y-%m-%d-%H%M)-my-optimization.md

# How-to
cp doc/templates/HOW_TO_TEMPLATE.md doc/how-to-my-task.md
```

### 3. Fill in Content
- Replace all `[bracketed placeholders]`
- Remove sections that don't apply
- Add real code examples
- Test all examples

### 4. Review
- [ ] All placeholders replaced
- [ ] Code examples tested
- [ ] Links verified
- [ ] Consistent formatting
- [ ] Table of contents updated

### 5. Commit
```bash
git add doc/[category]/[your-document].md
git commit -m "docs: add [document-type] for [topic]"
```

---

## 📊 Template Statistics

| Template | Lines | Size | Sections | Code Examples |
|----------|-------|------|----------|---------------|
| FEATURE_TEMPLATE.md | ~430 | 7.5K | 12 | Multiple |
| MIGRATION_TEMPLATE.md | ~290 | 5.4K | 11 | Multiple |
| OPTIMIZATION_TEMPLATE.md | ~460 | 8.0K | 10 | Multiple |
| HOW_TO_TEMPLATE.md | ~330 | 5.8K | 14 | Multiple |

**Total:** ~2,250 lines of comprehensive documentation templates

---

## 🎨 Template Structure

All templates follow this pattern:

```markdown
# [Document Title]

**Metadata:** Project, Version, Date, Status

---

## Table of Contents
[Auto-generated or manual]

---

## Main Sections
[Template-specific content]

---

## Status Tracking
✅ Completed
🚧 In Progress
⏸️ Pending

---

**Document Version:** X.Y
**Last Updated:** YYYY-MM-DD
```

---

## 🔧 Customization

Templates are starting points. You can:

✅ Add sections specific to your use case
✅ Reorder sections for better flow
✅ Combine related sections
✅ Split long sections

❌ Don't remove essential sections:
- Executive Summary / Overview
- Problem description
- Solution description
- Examples
- Status tracking

---

## 📝 Contributing to Templates

Found ways to improve the templates?

1. **Create an issue** describing the improvement
2. **Submit a PR** with template changes
3. **Update template version** number
4. **Document changes** in template README

---

## 🔗 Related Resources

- [Main Project README](../../README.md)
- [CLAUDE.md - AI Context](../../CLAUDE.md)
- [CHANGELOG](../../CHANGELOG.md)
- [Contributing Guidelines](../../CONTRIBUTING.md) (if exists)

---

## 📮 Getting Help

**Questions about templates?**
1. Read [README.md](README.md) for detailed guidance
2. Read [QUICK_START.md](QUICK_START.md) for quick reference
3. Look at example documents listed above
4. Open a GitHub issue or discussion

---

## Version History

**v1.0** (2025-12-22)
- Initial template suite created
- Four templates: Feature, Migration, Optimization, How-to
- Based on existing awesome_lints documentation patterns
- Includes README, QUICK_START, and INDEX guides

---

**Template Suite Version:** 1.0
**Last Updated:** 2025-12-22
**Templates:** 4 main + 3 guides
