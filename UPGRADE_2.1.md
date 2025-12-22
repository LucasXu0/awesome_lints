# Upgrading to v2.1.0

## Breaking Change: Opt-in Rules

Version 2.1.0 changes the default behavior from **all rules enabled** to **all rules disabled**.

### Quick Migration

Add ONE line to your `analysis_options.yaml`:

**To keep current behavior (all rules):**
```yaml
include: package:awesome_lints/presets/strict.yaml
```

**To use recommended preset (suggested):**
```yaml
include: package:awesome_lints/presets/recommended.yaml
```

**To start minimal and grow:**
```yaml
include: package:awesome_lints/presets/core.yaml
```

### What Changed?

| Version | Default Behavior | Configuration Required |
|---------|------------------|------------------------|
| v2.0.0 | All 128 rules ON | Disable unwanted rules |
| v2.1.0 | All rules OFF | Enable desired rules or use preset |

### Why This Change?

This change provides:
- Better onboarding for new users
- Gradual adoption path for teams
- Cleaner configuration files
- More flexible rule selection

See the full [Migration Guide](doc/migration/v2.0-to-v2.1.md) for details.
