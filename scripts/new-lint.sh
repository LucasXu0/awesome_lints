#!/bin/bash
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎯 Awesome Lints - New Lint Generator${NC}"
echo ""

# Function to convert snake_case to PascalCase
to_pascal_case() {
    echo "$1" | sed -r 's/(^|_)([a-z])/\U\2/g'
}

# Function to show usage
show_usage() {
    echo "Usage: $0 <lint_name> <category>"
    echo ""
    echo "Arguments:"
    echo "  lint_name   Name in snake_case (e.g., avoid_empty_setstate)"
    echo "  category    One of: common, flutter, provider, bloc, fake_async"
    echo ""
    echo "Example:"
    echo "  $0 avoid_empty_setstate flutter"
    exit 1
}

# Check arguments
if [ $# -ne 2 ]; then
    show_usage
fi

LINT_NAME="$1"
CATEGORY="$2"

# Validate category
if [[ ! "$CATEGORY" =~ ^(common|flutter|provider|bloc|fake_async)$ ]]; then
    echo -e "${RED}❌ Invalid category: $CATEGORY${NC}"
    echo -e "${YELLOW}Valid categories: common, flutter, provider, bloc, fake_async${NC}"
    exit 1
fi

# Validate lint name format
if [[ ! "$LINT_NAME" =~ ^[a-z_]+$ ]]; then
    echo -e "${RED}❌ Invalid lint name format: $LINT_NAME${NC}"
    echo -e "${YELLOW}Lint name should be in snake_case (lowercase with underscores)${NC}"
    exit 1
fi

CLASS_NAME=$(to_pascal_case "$LINT_NAME")
LINT_DIR="lib/src/lints/$CATEGORY"
LINT_FILE="$LINT_DIR/$LINT_NAME.dart"
FIXTURE_DIR="test/fixtures/test_project/lib/$CATEGORY/$LINT_NAME"

echo -e "${BLUE}Creating new lint:${NC}"
echo -e "  Name:     ${GREEN}$LINT_NAME${NC}"
echo -e "  Class:    ${GREEN}$CLASS_NAME${NC}"
echo -e "  Category: ${GREEN}$CATEGORY${NC}"
echo ""

# Check if lint already exists
if [ -f "$LINT_FILE" ]; then
    echo -e "${RED}❌ Lint already exists: $LINT_FILE${NC}"
    exit 1
fi

# Create lint file
echo -e "${BLUE}📝 Creating lint file...${NC}"
cat > "$LINT_FILE" << EOF
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// **Why?** [Explain why this rule exists and what problem it solves]
///
/// **Example:**
/// \`\`\`dart
/// // Bad
/// // [Example of code that violates this rule]
///
/// // Good
/// // [Example of correct code]
/// \`\`\`
class $CLASS_NAME extends DartLintRule {
  const $CLASS_NAME() : super(code: _code);

  static const _code = LintCode(
    name: '$LINT_NAME',
    problemMessage: 'TODO: Add problem message',
    correctionMessage: 'TODO: Add correction message (optional)',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((node) {
      // TODO: Implement lint logic
      // Example: Check conditions and report violations
      // if (someCondition) {
      //   reporter.atNode(node, _code);
      // }
    });
  }
}
EOF

echo -e "${GREEN}✅ Created: $LINT_FILE${NC}"

# Create fixture directory
echo -e "${BLUE}📁 Creating test fixtures...${NC}"
mkdir -p "$FIXTURE_DIR"

# Create "should trigger" fixture
cat > "$FIXTURE_DIR/should_trigger_lint.dart" << EOF
// expect_lint: $LINT_NAME

/// Test cases that should trigger the lint

void main() {
  // TODO: Add examples that should trigger the lint
}
EOF

echo -e "${GREEN}✅ Created: $FIXTURE_DIR/should_trigger_lint.dart${NC}"

# Create "should not trigger" fixture
cat > "$FIXTURE_DIR/should_not_trigger_lint.dart" << EOF
/// Test cases that should NOT trigger the lint

void main() {
  // TODO: Add examples that should NOT trigger the lint
}
EOF

echo -e "${GREEN}✅ Created: $FIXTURE_DIR/should_not_trigger_lint.dart${NC}"

# Update category export file
CATEGORY_FILE="$LINT_DIR/${CATEGORY}.dart"
if [ -f "$CATEGORY_FILE" ]; then
    echo -e "${BLUE}📦 Updating category export file...${NC}"

    # Add export in alphabetical order
    EXPORT_LINE="export '$LINT_NAME.dart';"

    # Check if export already exists
    if ! grep -q "$EXPORT_LINE" "$CATEGORY_FILE"; then
        # Add the export (just append for now - user can sort manually)
        echo "$EXPORT_LINE" >> "$CATEGORY_FILE"
        echo -e "${GREEN}✅ Added export to $CATEGORY_FILE${NC}"
        echo -e "${YELLOW}⚠️  Please sort exports alphabetically in $CATEGORY_FILE${NC}"
    fi
fi

echo ""
echo -e "${GREEN}✨ Lint created successfully!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Implement the lint logic in: $LINT_FILE"
echo "  2. Add test cases in: $FIXTURE_DIR/"
echo "  3. Update the LINTS.md documentation:"
echo "     - Add entry to: $LINT_DIR/${CATEGORY^^}_LINTS.md"
echo "  4. Run verification: ./verify.sh"
echo "  5. Update README.md if this changes the lint count"
echo ""
echo -e "${YELLOW}💡 Tip: Check existing lints in $LINT_DIR for examples${NC}"
echo ""
