# How to [Task Name]

[Brief introduction explaining what this guide covers and who it's for]

## Prerequisites

[List what the user needs before starting]

- [Prerequisite 1]
- [Prerequisite 2]
- [Prerequisite 3]

**Required dependencies:**
```yaml
dependencies:
  [dependency_1]: [version]
  [dependency_2]: [version]

dev_dependencies:
  [dev_dependency_1]: [version]
```

---

## Overview

[2-3 paragraph overview of the task, explaining the goal and approach]

**What you'll learn:**
- [Learning objective 1]
- [Learning objective 2]
- [Learning objective 3]

**Time estimate:** [Approximate time to complete]

---

## Step 1: [First Major Step]

[Explanation of what this step accomplishes and why it's important]

### Instructions

1. [Detailed instruction 1]
   ```bash
   # Example command
   [command]
   ```

2. [Detailed instruction 2]
   ```dart
   // Example code
   [code]
   ```

3. [Detailed instruction 3]

### Expected Result

[What the user should see after completing this step]

```
[Example output]
```

### Troubleshooting

**Issue:** [Common problem]
**Solution:** [How to fix it]

---

## Step 2: [Second Major Step]

[Explanation of this step]

### Instructions

1. [Instruction 1]

   **Example:**
   ```dart
   // Code example with explanation
   [code]
   ```

2. [Instruction 2]

   **File:** `[path/to/file.dart]`
   ```dart
   [code example]
   ```

### Key Components

[Explain important concepts or components introduced in this step]

1. **[Component 1]:**
   - Purpose: [What it does]
   - Usage: [How to use it]
   - Example: [Code example]

2. **[Component 2]:**
   - Purpose: [What it does]
   - Usage: [How to use it]
   - Example: [Code example]

### Expected Result

[What should happen]

---

## Step 3: [Third Major Step]

[Explanation]

### Instructions

[Detailed step-by-step instructions with code examples]

### Common Patterns

[If applicable, show common patterns or best practices]

#### Pattern 1: [Pattern Name]

```dart
// Good example
[good_code]
```

#### Pattern 2: [Pattern Name]

```dart
// Another good example
[good_code]
```

### Anti-Patterns to Avoid

```dart
// Bad example - avoid this
[bad_code]

// Why it's bad: [Explanation]
```

---

## Step 4: [Testing/Verification Step]

[Explanation of how to test and verify the implementation]

### Unit Tests

[How to write unit tests]

**Example test:**
```dart
import 'package:test/test.dart';

void main() {
  group('[Feature Name]', () {
    test('[test description]', () {
      // Arrange
      [setup_code]

      // Act
      [action_code]

      // Assert
      expect([actual], [expected]);
    });
  });
}
```

### Integration Tests

[How to create integration tests]

**Directory structure:**
```
test/
├── fixtures/
│   └── test_project/
│       └── lib/
│           └── [test_file.dart]
```

**Example fixture:**
```dart
[fixture_code]
```

### Running Tests

```bash
# Run unit tests
dart test

# Run integration tests
cd test/fixtures/test_project
dart run custom_lint
```

### Expected Output

```
[expected_test_output]
```

---

## Step 5: [Final Step/Polish]

[Final touches, documentation, etc.]

### Documentation

[How to document the feature]

### Code Quality Checks

```bash
# Format code
dart format .

# Analyze code
dart analyze

# Run all checks
./verify.sh
```

---

## Complete Example

[Full, working example showing all steps together]

### File Structure

```
[project_structure]
```

### Full Implementation

**File:** `[main_file.dart]`
```dart
[complete_code_example]
```

**File:** `[test_file.dart]`
```dart
[complete_test_example]
```

---

## Best Practices

1. **[Practice 1]**
   - [Why it's important]
   - [How to apply it]
   - Example: [code example]

2. **[Practice 2]**
   - [Why it's important]
   - [How to apply it]
   - Example: [code example]

3. **[Practice 3]**
   - [Why it's important]
   - [How to apply it]
   - Example: [code example]

---

## Common Issues and Solutions

### Issue 1: [Problem Description]

**Error:**
```
[error_message]
```

**Cause:** [Why this happens]

**Solution:**
```dart
// Fix
[solution_code]
```

---

### Issue 2: [Problem Description]

**Error:**
```
[error_message]
```

**Cause:** [Why this happens]

**Solution:**
[Step-by-step solution]
1. [Step 1]
2. [Step 2]
3. [Step 3]

---

### Issue 3: [Problem Description]

**Symptoms:**
- [Symptom 1]
- [Symptom 2]

**Cause:** [Why this happens]

**Solution:**
```bash
# Commands to fix
[commands]
```

---

## Advanced Topics

[Optional section for advanced usage]

### Advanced Technique 1: [Name]

[Explanation and example]

```dart
[advanced_code_example]
```

### Advanced Technique 2: [Name]

[Explanation and example]

```dart
[advanced_code_example]
```

---

## Testing Checklist

Before considering your work complete, verify:

- [ ] [Checkpoint 1]
- [ ] [Checkpoint 2]
- [ ] [Checkpoint 3]
- [ ] Code is formatted (`dart format .`)
- [ ] No analysis issues (`dart analyze`)
- [ ] All tests pass (`dart test`)
- [ ] Integration tests work
- [ ] Documentation is complete
- [ ] Examples are clear and working

---

## Next Steps

[What to do after completing this guide]

- [Next step 1]
- [Next step 2]
- [Related guide to read]

---

## Additional Resources

### Related Documentation

- [Link to related doc 1]
- [Link to related doc 2]

### External References

- [External link 1]
- [External link 2]

### Example Projects

- [Example project 1]
- [Example project 2]

---

## FAQ

### Q: [Common question 1]?

**A:** [Answer]

### Q: [Common question 2]?

**A:** [Answer]

### Q: [Common question 3]?

**A:** [Answer]

---

## Appendix

### Glossary

- **[Term 1]:** [Definition]
- **[Term 2]:** [Definition]
- **[Term 3]:** [Definition]

### Command Reference

```bash
# [Description of command]
[command]

# [Description of command]
[command]
```

---

**Document Version:** [e.g., 1.0]
**Last Updated:** [YYYY-MM-DD]
**Author(s):** [Name(s)]
