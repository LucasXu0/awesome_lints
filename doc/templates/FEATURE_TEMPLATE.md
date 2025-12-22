# [Feature Name]

**Project:** Awesome Lints
**Target Version:** [e.g., 2.2.0]
**Document Date:** [YYYY-MM-DD]
**Status:** [Proposed | In Progress | Implemented | Rejected]
**Breaking Change:** [Yes | No]

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Motivation](#motivation)
3. [Current vs Proposed Behavior](#current-vs-proposed-behavior)
4. [Implementation Strategy](#implementation-strategy)
5. [Technical Design](#technical-design)
6. [Breaking Changes](#breaking-changes) (if applicable)
7. [Migration Guide](#migration-guide) (if applicable)
8. [Documentation Updates](#documentation-updates)
9. [Implementation Checklist](#implementation-checklist)
10. [Testing Strategy](#testing-strategy)
11. [Resources](#resources)

---

## Executive Summary

[Brief overview of the feature - 2-3 paragraphs maximum]

### Key Changes

- [Bullet point 1]
- [Bullet point 2]
- [Bullet point 3]

### Impact

| Aspect | Current | Proposed |
|--------|---------|----------|
| [Aspect 1] | [Current behavior] | [Proposed behavior] |
| [Aspect 2] | [Current behavior] | [Proposed behavior] |
| [Aspect 3] | [Current behavior] | [Proposed behavior] |

---

## Motivation

### Problem Statement

[Describe the problem this feature solves. Include specific pain points.]

1. **[Problem Category 1]**
   - [Specific issue]
   - [Impact on users]
   - [Example scenario]

2. **[Problem Category 2]**
   - [Specific issue]
   - [Impact on users]
   - [Example scenario]

### Benefits of Proposed Solution

1. **[Benefit Category 1]**
   - [Specific improvement]
   - [User impact]
   - [Example outcome]

2. **[Benefit Category 2]**
   - [Specific improvement]
   - [User impact]
   - [Example outcome]

---

## Current vs Proposed Behavior

### Current Behavior

```yaml
# Example configuration or code showing current behavior
```

**Result:** [Describe what happens currently]

**Issues:**
- [Issue 1]
- [Issue 2]

### Proposed Behavior

```yaml
# Example configuration or code showing proposed behavior
```

**Result:** [Describe what will happen with the proposed change]

**Improvements:**
- [Improvement 1]
- [Improvement 2]

---

## Implementation Strategy

### Approach

[Describe the overall implementation approach and why this approach was chosen]

### Technical Implementation

[Detailed technical explanation of how the feature will be implemented]

**Key Components:**

1. **[Component 1]**
   - Purpose: [Why this component is needed]
   - Implementation: [How it will be built]
   - Dependencies: [What it depends on]

2. **[Component 2]**
   - Purpose: [Why this component is needed]
   - Implementation: [How it will be built]
   - Dependencies: [What it depends on]

### Alternative Approaches Considered

#### Approach 1: [Name]

**Description:** [Brief description]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Rejected because:** [Reason for rejection]

#### Approach 2: [Name]

**Description:** [Brief description]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Rejected because:** [Reason for rejection]

---

## Technical Design

### Architecture

[Describe the overall architecture of the feature]

```
[Optional: Add ASCII diagram or mermaid diagram]
```

### API Design

[If applicable, show the public API]

```dart
// Example API usage
```

### Data Structures

[If applicable, describe key data structures]

```dart
// Example data structures
```

### File Organization

```
[Show directory/file structure]
lib/
  ├── src/
  │   ├── [feature_directory]/
  │   │   ├── [file1.dart]
  │   │   └── [file2.dart]
```

---

## Breaking Changes

[If applicable - remove section if no breaking changes]

### Version [X.Y.Z] - Breaking Change Summary

**What's changing:**
- [Change 1]
- [Change 2]

**Who's affected:**
- [User group 1]
- [User group 2]

**Migration required:**
- [Yes/No] - [Brief explanation]

### CHANGELOG Entry

```markdown
## [X.Y.Z] - YYYY-MM-DD

### BREAKING CHANGES

**[Brief title of breaking change]**

[Description of the breaking change and its impact]

**Migration Required:**

[Steps users need to take to migrate]

```yaml
# Example migration code
```

See [Migration Guide](#migration-guide) for detailed instructions.

### Features

**[Feature name]:**

- [Feature bullet 1]
- [Feature bullet 2]

### Documentation

- [Doc update 1]
- [Doc update 2]
```

---

## Migration Guide

[If applicable - remove section if not needed]

### For New Users ([Version]+)

**Recommended Setup:**

```yaml
# Example configuration for new users
```

### For Existing Users (Upgrading from [Previous Version])

#### Option 1: [Migration Path Name]

[Description of this migration path]

```yaml
# Example configuration
```

**Effort:** [Time estimate]
**Impact:** [Description of impact]

#### Option 2: [Migration Path Name]

[Description of this migration path]

```yaml
# Example configuration
```

**Effort:** [Time estimate]
**Impact:** [Description of impact]

### Migration Timeline Recommendation

**Week 1:** [First step]
```yaml
# Example
```

**Week 2-4:** [Second step]
- [Sub-step 1]
- [Sub-step 2]

**Week 5+:** [Final step]
```yaml
# Example
```

---

## Documentation Updates

### 1. README.md Updates

#### [Section Name]

**Replace:**
```markdown
[Old content]
```

**With:**
```markdown
[New content]
```

### 2. CLAUDE.md Updates

[Describe updates needed to CLAUDE.md]

### 3. Create/Update [Document Name]

[Describe new documentation that needs to be created]

---

## Implementation Checklist

### Phase 1: [Phase Name]

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Phase 2: [Phase Name]

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Phase 3: [Phase Name]

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Phase 4: [Phase Name]

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

---

## Testing Strategy

### 1. Unit Tests

[Describe unit testing approach]

```dart
// Example unit test structure
import 'package:test/test.dart';

void main() {
  group('[Feature Name]', () {
    test('[test description]', () {
      // Test implementation
    });
  });
}
```

### 2. Integration Tests

[Describe integration testing approach]

```
[Directory structure for integration tests]
test/integration/
├── [feature_test]/
│   ├── analysis_options.yaml
│   ├── pubspec.yaml
│   └── lib/
│       └── main.dart
```

### 3. Manual Testing Checklist

- [ ] [Test case 1]
- [ ] [Test case 2]
- [ ] [Test case 3]
- [ ] Verify IDE integration works
- [ ] Test with different Flutter/Dart versions
- [ ] Validate error messages are clear

### 4. Performance Testing

[If applicable]

- [ ] Measure baseline performance
- [ ] Test with large codebases (1000+ files)
- [ ] Verify no regression in analysis time
- [ ] Monitor memory usage

---

## Resources

### Related Documentation

- [Link to related doc 1]
- [Link to related doc 2]

### External References

- [External reference 1]
- [External reference 2]

### Similar Implementations

- [Example from other project 1]
- [Example from other project 2]

---

## Implementation Status

[Update this section as work progresses]

### ✅ Completed Tasks

**Phase 1: [Phase Name]**
- ✅ [Task 1]
- ✅ [Task 2]

**Phase 2: [Phase Name]**
- ✅ [Task 1]
- ✅ [Task 2]

### ⚠️ In Progress

**Phase 3: [Phase Name]**
- 🚧 [Task in progress]

### 📋 Pending Tasks

**Phase 4: [Phase Name]**
- ⏸️ [Pending task 1]
- ⏸️ [Pending task 2]

### Summary

[Brief summary of current status and next steps]

---

**Document Version:** [e.g., 1.0]
**Last Updated:** [YYYY-MM-DD]
**Status:** [Proposed | In Progress | Implemented | Rejected]
**Author(s):** [Name(s)]
