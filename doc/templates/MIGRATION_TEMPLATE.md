# Migration Guide: v[X.Y.Z] to v[A.B.C]

## Breaking Change Overview

[Brief description of the breaking change and why it was necessary]

## Impact Assessment

### Who is affected?

- [User group 1]
- [User group 2]
- [User group 3]

### What breaks?

- [Breaking change 1]
- [Breaking change 2]
- [Breaking change 3]

### What stays the same?

- [Non-breaking aspect 1]
- [Non-breaking aspect 2]

---

## Migration Paths

### Path 1: [Migration Strategy Name]

**Use case:** [When to use this migration path]

**Steps:**
1. [Step 1]
   ```yaml
   # Example code
   ```
2. [Step 2]
   ```yaml
   # Example code
   ```
3. [Step 3]
   ```bash
   # Example commands
   ```

**Effort:** [Time estimate]
**Risk:** [Low | Medium | High]

---

### Path 2: [Migration Strategy Name]

**Use case:** [When to use this migration path]

**Steps:**
1. [Step 1]
   ```yaml
   # Example code
   ```
2. [Step 2]
   ```yaml
   # Example code
   ```
3. [Step 3]
   ```bash
   # Example commands
   ```

**Effort:** [Time estimate]
**Risk:** [Low | Medium | High]

---

### Path 3: [Migration Strategy Name]

**Use case:** [When to use this migration path]

**Steps:**
1. [Step 1]
   ```yaml
   # Example code
   ```
2. [Step 2]
   ```yaml
   # Example code
   ```
3. [Step 3]
   ```bash
   # Example commands
   ```

**Effort:** [Time estimate]
**Risk:** [Low | Medium | High]

---

## Detailed Migration Examples

### Example 1: [Scenario Name]

**Before (v[X.Y.Z]):**
```yaml
# Old configuration
```

**After (v[A.B.C]):**
```yaml
# New configuration
```

**Explanation:**
[Explain what changed and why]

---

### Example 2: [Scenario Name]

**Before (v[X.Y.Z]):**
```dart
// Old code
```

**After (v[A.B.C]):**
```dart
// New code
```

**Explanation:**
[Explain what changed and why]

---

## Verification

After migration, verify your configuration works correctly:

```bash
# Step 1: [Verification command]
[command]

# Step 2: [Verification command]
[command]

# Step 3: [Verification command]
[command]
```

### Expected Results

**Success indicators:**
- [Success indicator 1]
- [Success indicator 2]
- [Success indicator 3]

**Warning signs:**
- [Warning sign 1]
- [Warning sign 2]
- [Warning sign 3]

---

## Troubleshooting

### Issue: [Common Issue 1]

**Symptom:** [What the user sees]

**Cause:** [Why this happens]

**Solution:**
```yaml
# Solution code or configuration
```

---

### Issue: [Common Issue 2]

**Symptom:** [What the user sees]

**Cause:** [Why this happens]

**Solution:**
```bash
# Solution commands
```

---

### Issue: [Common Issue 3]

**Symptom:** [What the user sees]

**Cause:** [Why this happens]

**Solution:**
[Step-by-step solution]

1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## Rollback Plan

If you encounter critical issues and need to rollback to v[X.Y.Z]:

### Step 1: Downgrade Package Version

```yaml
# pubspec.yaml
dev_dependencies:
  awesome_lints: ^[X.Y.Z]
```

### Step 2: Restore Configuration

```yaml
# analysis_options.yaml
[Old configuration]
```

### Step 3: Clean and Rebuild

```bash
# Clean Flutter/Dart cache
flutter clean
flutter pub get

# Or for Dart-only projects
dart pub get
```

### Step 4: Verify Rollback

```bash
# Verify the old version is active
dart run custom_lint --version

# Run analysis to confirm
dart run custom_lint
```

---

## Migration Timeline Recommendation

### For Small Projects (< 10,000 lines)

**Day 1:**
- [Task 1]
- [Task 2]

**Day 2-3:**
- [Task 3]
- [Task 4]

**Total Time:** [Estimate]

---

### For Medium Projects (10,000 - 100,000 lines)

**Week 1:**
- [Task 1]
- [Task 2]

**Week 2:**
- [Task 3]
- [Task 4]

**Week 3+:**
- [Task 5]
- [Task 6]

**Total Time:** [Estimate]

---

### For Large Projects (> 100,000 lines)

**Week 1-2:**
- [Phase 1 tasks]

**Week 3-4:**
- [Phase 2 tasks]

**Week 5+:**
- [Phase 3 tasks]

**Total Time:** [Estimate]

---

## CI/CD Integration

### GitHub Actions

Update your workflow file:

```yaml
# .github/workflows/lint.yml
name: Lint

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '[version]'
      - run: flutter pub get
      - run: dart run custom_lint
```

### GitLab CI

Update your `.gitlab-ci.yml`:

```yaml
lint:
  image: cirrusci/flutter:[version]
  script:
    - flutter pub get
    - dart run custom_lint
```

### Other CI Systems

[Provide guidance for other CI systems]

---

## Frequently Asked Questions

### Q: [Question 1]?

**A:** [Answer]

### Q: [Question 2]?

**A:** [Answer]

### Q: [Question 3]?

**A:** [Answer]

### Q: Can I migrate gradually?

**A:** [Answer specific to gradual migration]

### Q: Will this affect my existing codebase?

**A:** [Answer about impact on existing code]

---

## Getting Help

If you encounter issues not covered in this guide:

1. **Check the documentation:**
   - [Link to main documentation]
   - [Link to feature document]

2. **Search existing issues:**
   - [Link to GitHub issues]

3. **Create a new issue:**
   - [Link to issue template]
   - Include: version info, configuration, error messages

4. **Community support:**
   - [Link to discussions/community]

---

## Additional Resources

- [Full feature document](../feature/[feature-name].md)
- [CHANGELOG](../../CHANGELOG.md)
- [README](../../README.md)
- [UPGRADE Guide](../../UPGRADE_[version].md)

---

**Document Version:** [e.g., 1.0]
**Last Updated:** [YYYY-MM-DD]
**Applies to:** v[X.Y.Z] → v[A.B.C]
**Author(s):** [Name(s)]
