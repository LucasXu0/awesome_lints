# Documentation Templates

This directory contains markdown templates for creating consistent documentation across the Awesome Lints project.

## Available Templates

### 1. FEATURE_TEMPLATE.md

**Purpose:** Document new features, major changes, or architectural decisions

**When to use:**
- Planning a new feature or major enhancement
- Documenting breaking changes
- Designing system architecture changes
- Proposing significant refactoring

**Key sections:**
- Executive Summary with impact table
- Detailed motivation and problem statement
- Current vs. proposed behavior comparison
- Implementation strategy with alternatives
- Technical design and architecture
- Breaking changes and migration guide (if applicable)
- Implementation checklist with phases
- Testing strategy
- Implementation status tracking

**Example:** `doc/feature/2025-12-22-opt-in-rules-by-default.md`

**How to use:**
1. Copy template: `cp doc/templates/FEATURE_TEMPLATE.md doc/feature/YYYY-MM-DD-feature-name.md`
2. Fill in all bracketed placeholders `[like this]`
3. Remove sections that don't apply (e.g., Breaking Changes if not applicable)
4. Update Implementation Status as work progresses
5. Keep document version and status updated

---

### 2. MIGRATION_TEMPLATE.md

**Purpose:** Guide users through version upgrades and breaking changes

**When to use:**
- Creating migration guides for version upgrades
- Documenting breaking changes that require user action
- Providing upgrade paths for major releases

**Key sections:**
- Breaking change overview and impact assessment
- Multiple migration paths with different strategies
- Detailed before/after examples
- Verification steps
- Comprehensive troubleshooting guide
- Rollback plan
- Timeline recommendations by project size
- CI/CD integration updates
- FAQ section

**Example:** `doc/migration/v2.0-to-v2.1.md`

**How to use:**
1. Copy template: `cp doc/templates/MIGRATION_TEMPLATE.md doc/migration/vX.Y-to-vA.B.md`
2. Document all breaking changes clearly
3. Provide at least 2-3 migration paths for different use cases
4. Include real examples from the actual codebase
5. Test all migration paths before publishing

---

### 3. OPTIMIZATION_TEMPLATE.md

**Purpose:** Document code optimization opportunities and performance improvements

**When to use:**
- Analyzing codebase for optimization opportunities
- Planning refactoring to reduce duplication
- Documenting performance improvements
- Tracking technical debt reduction

**Key sections:**
- Executive summary with quick stats table
- Categorized optimizations (High/Medium/Low priority)
- Detailed problem descriptions with metrics
- Proposed solutions with code examples
- Implementation roadmap by phase
- Metrics and impact tracking (projected vs actual)
- Risk assessment
- Implementation status with commits
- Lessons learned

**Example:** `doc/optimization/2025-12-22-1413-code-optimization-opportunities.md`

**How to use:**
1. Copy template: `cp doc/templates/OPTIMIZATION_TEMPLATE.md doc/optimization/YYYY-MM-DD-HHMM-optimization-name.md`
2. Start with analysis and populate Quick Stats table
3. Prioritize optimizations by impact and effort
4. Update status and metrics as implementation progresses
5. Document lessons learned after completion

---

### 4. HOW_TO_TEMPLATE.md

**Purpose:** Create step-by-step tutorial guides for common tasks

**When to use:**
- Writing tutorials for developers
- Documenting development workflows
- Creating onboarding guides
- Explaining how to use features or tools

**Key sections:**
- Clear prerequisites and dependencies
- Overview with learning objectives
- Numbered step-by-step instructions
- Code examples for each step
- Expected results and verification
- Complete working example
- Best practices
- Common issues and solutions
- Testing checklist
- FAQ

**Example:** `doc/how-to-create-custom-lint.md`

**How to use:**
1. Copy template: `cp doc/templates/HOW_TO_TEMPLATE.md doc/how-to-[task-name].md`
2. Write for the target audience (beginner/intermediate/advanced)
3. Test every code example to ensure they work
4. Include screenshots or diagrams if helpful
5. Keep examples simple and focused

---

## Template Usage Guidelines

### Naming Conventions

**Feature documents:**
- Format: `YYYY-MM-DD-feature-name.md`
- Example: `2025-12-22-opt-in-rules-by-default.md`
- Location: `doc/feature/`

**Migration guides:**
- Format: `vX.Y-to-vA.B.md`
- Example: `v2.0-to-v2.1.md`
- Location: `doc/migration/`

**Optimization documents:**
- Format: `YYYY-MM-DD-HHMM-optimization-name.md`
- Example: `2025-12-22-1413-code-optimization-opportunities.md`
- Location: `doc/optimization/`

**How-to guides:**
- Format: `how-to-[task-name].md`
- Example: `how-to-create-custom-lint.md`
- Location: `doc/`

### Common Elements

All templates include:
- Clear metadata at the top (Project, Version, Date, Status)
- Table of contents for easy navigation
- Consistent heading hierarchy
- Code examples with syntax highlighting
- Status tracking sections
- Document version and last updated date

### Best Practices

1. **Fill in all placeholders**
   - Replace all `[bracketed]` text with actual content
   - Remove brackets after filling in values
   - Delete sections that don't apply (with clear rationale)

2. **Keep documents updated**
   - Update status as work progresses
   - Track completion with ✅, 🚧, ⏸️ emoji indicators
   - Maintain version number and last updated date
   - Document actual results vs. projections

3. **Use consistent formatting**
   - Follow the template structure
   - Use proper markdown syntax
   - Include code blocks with language identifiers
   - Add line numbers to code examples when helpful

4. **Provide concrete examples**
   - Show real code from the project
   - Include before/after comparisons
   - Provide complete working examples
   - Test all code snippets

5. **Think about the reader**
   - Write for your target audience
   - Explain technical concepts clearly
   - Provide context and motivation
   - Include troubleshooting and FAQs

6. **Link related documents**
   - Reference related docs in Resources section
   - Create bidirectional links when appropriate
   - Update main README if needed

### Customization

Templates are starting points - feel free to:
- Add sections specific to your use case
- Reorder sections if it improves clarity
- Combine sections if they're closely related
- Split sections if they're too long

Don't remove essential sections like:
- Executive Summary / Overview
- Problem description
- Solution description
- Examples
- Status tracking

### Review Checklist

Before finalizing a document:

- [ ] All placeholders filled in or removed
- [ ] Code examples tested and working
- [ ] Links verified and working
- [ ] Spelling and grammar checked
- [ ] Consistent formatting throughout
- [ ] Table of contents matches headings
- [ ] Status and version info updated
- [ ] Related documents linked

---

## Template Maintenance

### Updating Templates

When updating templates:
1. Document the change in this README
2. Update the template version number
3. Consider impact on existing documents
4. Update examples if needed

### Template Version History

**v1.0** (2025-12-22)
- Initial template creation
- Four templates: Feature, Migration, Optimization, How-to
- Based on existing documentation patterns in the project

---

## Examples of Good Documentation

See these files for examples of each template in use:

**Feature Documentation:**
- `doc/feature/2025-12-22-opt-in-rules-by-default.md` - Comprehensive feature document with all sections

**Migration Guides:**
- `doc/migration/v2.0-to-v2.1.md` - Version migration guide

**Optimization Documents:**
- `doc/optimization/2025-12-22-1413-code-optimization-opportunities.md` - Detailed optimization analysis

**How-to Guides:**
- `doc/how-to-create-custom-lint.md` - Step-by-step tutorial with examples

---

## Questions or Suggestions?

If you have questions about using these templates or suggestions for improvements:

1. Review the example documents listed above
2. Check if your question is answered in this README
3. Open an issue or discussion on GitHub
4. Submit a PR with template improvements

---

**Last Updated:** 2025-12-22
**Template Version:** 1.0
