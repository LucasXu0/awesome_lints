# Optimization TODOs (Codebase Review)

**Project:** Awesome Lints  
**Version:** 2.1.0  
**Review Date:** 2025-12-22  
**Scope:** Docs, repo structure, CI/tooling, test fixtures, code quality/style, performance

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [High Priority TODOs](#high-priority-todos)
3. [Medium Priority TODOs](#medium-priority-todos)
4. [Low Priority TODOs](#low-priority-todos)
5. [Quick Wins Checklist](#quick-wins-checklist)

---

## Executive Summary

The core lint implementations are in good shape and have already undergone a meaningful refactor/optimization pass (shared AST helpers, base classes, extracted utilities). The highest remaining “optimization” opportunities are now **repo hygiene and developer-experience** focused:

- **CI correctness:** PR validation currently fails to detect new lints, so key checks don’t run.
- **Docs consistency:** multiple docs are out of sync with the actual repo structure/version behavior.
- **Fixture scalability:** the current “enable everything + ignore everything” fixture strategy scales poorly and increases maintenance effort.
- **Small performance wins remain:** Type display-string caching exists but is not consistently used.

**Update (2025-12-22):** ✅ Completed the most urgent CI + docs fixes (PR validation, CI format behavior, core docs/link cleanup, fixture doc structure).

---

## High Priority TODOs

### 1) Fix PR validation: new lint detection is broken

**Status:** ✅ Completed  
**Impact:** High (CI guardrails don’t run)  
**Effort:** Low  
**Why it matters:** New lints can slip in without fixtures and without doc updates.

**What’s wrong:**
- `NEW_LINTS` assignment in `/.github/workflows/pr-validation.yml` filters out everything due to an incorrect `grep -v '\.dart$'`.

**Where:**
- `.github/workflows/pr-validation.yml`

**Suggested fix:**
- Detect “new lint rule file” additions by diffing for `lib/src/lints/<category>/<rule>.dart`
- Exclude category barrel files (`common.dart`, `flutter.dart`, etc.) and any non-rule Dart files if present.
- Ensure the “new_lints=true” path triggers tests/docs validation steps.

---

### 2) Make docs consistent with reality (counts, links, structure)

**Status:** 🟡 Partially completed  
**Impact:** High (user confusion + contributor friction)  
**Effort:** Low–Medium

**Issues found:**
- `lib/awesome_lints.dart` has outdated lint counts and placeholder GitHub links.
- `test/fixtures/README.md` documents a fixture layout that doesn’t match the actual `category/lint_name` folder structure.
- `scripts/README.md` mentions a `test.yml` workflow that is not present under `.github/workflows/`.

**Where:**
- `lib/awesome_lints.dart`
- `test/fixtures/README.md`
- `scripts/README.md`

**Suggested fixes:**
- Update lint counts to match current reality (README currently documents 128 total by category).
- Replace placeholder links with `https://github.com/LucasXu0/awesome_lints/...`.
- Update the fixture README tree to:
  - `test/fixtures/test_project/lib/<category>/<lint_name>/...`
- Either add the missing workflow or remove/adjust the doc references.

**What was completed:**
- Updated lint counts and replaced placeholder links in `lib/awesome_lints.dart`.
- Fixed `test/fixtures/README.md` to match `lib/<category>/<lint_name>/...`.
- Removed the nonexistent `test.yml` reference from `scripts/README.md`.

**What remains:**
- Audit remaining docs for “enabled by default” wording (see TODO #3).

---

### 3) Resolve “enabled by default” vs “opt-in by default” messaging drift

**Status:** 🟡 Pending  
**Impact:** High (product behavior misunderstanding)  
**Effort:** Medium  
**Why it matters:** Version `2.1.0` ships an “opt-in rules by default” change proposal, while multiple docs still state “All rules are enabled by default.”

**Where (examples):**
- `lib/src/lints/bloc/BLOC_LINTS.md`
- `lib/src/lints/provider/PROVIDER_LINTS.md`
- `README.md`
- `doc/feature/2025-12-22-opt-in-rules-by-default.md`

**Suggested approach:**
- Decide the canonical behavior for `2.1.0` and update:
  - README (quick start + “default behavior” wording)
  - category `*_LINTS.md` footers (“enabled by default” paragraph)
  - preset docs (recommended/core/strict) to make the mental model explicit

---

## Medium Priority TODOs

### 4) Rework fixture strategy to reduce maintenance and speed up validation

**Status:** ✅ Completed  
**Impact:** Medium–High (developer time + CI time)  
**Effort:** Medium–High

**Current state:**
- Fixture project includes `strict.yaml` (enables all rules).
- Each fixture file adds a large `// ignore_for_file:` header to suppress everything except the target lint.
- There’s a generator script that rewrites these headers for all files.

**Where:**
- `test/fixtures/test_project/analysis_options.yaml`
- `scripts/generate-test-ignores.sh`

**Optimization options:**
1. **Run fixtures per rule (allowlist):**
   - Drive `custom_lint` with a config that enables only the rule under test.
   - Remove the massive ignore lists and the generator script dependency.
2. **Per-directory configs:**
   - Put an `analysis_options.yaml` per lint directory that enables only that lint.
3. **Hybrid:**
   - Keep `strict.yaml` for a smaller “smoke test” subset and run per-rule validation for the full suite.

**Success criteria:**
- No per-file mega-ignore headers.
- Adding a new rule requires only a fixture folder and docs, not regenerating hundreds of ignore strings.

**What was completed:**
- Removed `// ignore_for_file:` mega-headers from fixture Dart files.
- Added `FixtureFilteredLintRule` wrapper so fixture files only run the lint matching `lib/<category>/<lint_name>/...`.
- Deprecated `scripts/generate-test-ignores.sh` since it’s no longer needed.

**Simple explanation:**
- Before: fixtures enabled many rules, so each fixture file had to ignore every other lint via a huge `// ignore_for_file:` header.
- Now: when analyzing fixture files, the plugin only *runs* the lint whose name matches the fixture directory (`.../lib/<category>/<lint_name>/...`), so other lints never execute and there’s nothing to ignore.

---

### 5) Make CI formatting checks consistent and non-mutating

**Impact:** Medium (avoid accidental formatting diffs)  
**Effort:** Low

**Issue:**
- `/.github/workflows/lint.yml` formats `test` without `--set-exit-if-changed`, while `verify.sh` uses it.

**Where:**
- `.github/workflows/lint.yml`
- `verify.sh`

**Suggested change:**
- Use `fvm dart format --set-exit-if-changed test` in CI to ensure checks fail instead of silently rewriting.

---

## Low Priority TODOs

### 6) Integrate `TypeCache` where `getDisplayString()` is used in hot paths

**Impact:** Low–Medium (depends on project sizes)  
**Effort:** Low–Medium

**Where (examples):**
- `lib/src/lints/flutter/prefer_spacing.dart`
- `lib/src/lints/flutter/pass_existing_future_to_future_builder.dart`
- `lib/src/lints/flutter/pass_existing_stream_to_stream_builder.dart`
- `lib/src/utils/string_exclusion_rules.dart`

**Note:** `lib/src/utils/type_cache.dart` already exists; adoption can be incremental.

---

### 7) Avoid exception-driven control flow in AST helpers

**Impact:** Low (micro-optimization + cleaner style)  
**Effort:** Low

**Where:**
- `lib/src/utils/ast_extensions.dart` (`ArgumentListExtensions.getNamedArgument`)

**Suggested change:**
- Replace `firstWhere + try/catch` with a simple loop.

---

### 8) Reduce allocations in plugin rule registration

**Impact:** Low (micro, but easy to keep tidy)  
**Effort:** Low

**Where:**
- `lib/src/awesome_lints_plugin.dart`

**Suggested change:**
- Make the rule lists `final`/`static final` where possible (most rule constructors are `const`).
- Keep only config-dependent rules created per `getLintRules()` call.

---

## Quick Wins Checklist

- [x] Fix new lint detection in `.github/workflows/pr-validation.yml`
- [x] Update `lib/awesome_lints.dart` lint counts + repository links
- [x] Update `test/fixtures/README.md` fixture tree to match `category/lint_name`
- [ ] Align “enabled by default” messaging across README and `*_LINTS.md`
- [x] Make CI format check for `test` use `--set-exit-if-changed`
- [ ] Decide whether to keep or replace `scripts/generate-test-ignores.sh`
