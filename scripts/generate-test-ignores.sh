#!/bin/bash

# Script to auto-generate ignore_for_file headers for lint test fixtures
#
# Purpose:
# - Each lint test should only trigger the specific lint being tested
# - All other lints should be ignored via ignore_for_file header
#
# Usage:
#   ./scripts/generate-test-ignores.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Generating ignore_for_file headers for test fixtures${NC}"
echo ""

# Base directory for test fixtures
TEST_BASE="test/fixtures/test_project/lib"

# Step 1: Collect all lint names from test directories
echo -e "${BLUE}Step 1: Collecting all lint names...${NC}"

declare -a ALL_LINTS=()

# Find all lint test directories (2 levels deep: category/lint_name)
while IFS= read -r dir; do
    # Extract the lint name (last part of path)
    LINT_NAME=$(basename "$dir")
    ALL_LINTS+=("$LINT_NAME")
done < <(find "$TEST_BASE" -type d -mindepth 2 -maxdepth 2 | sort)

# Remove duplicates and sort
ALL_LINTS=($(echo "${ALL_LINTS[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo -e "${GREEN}Found ${#ALL_LINTS[@]} lints${NC}"
echo ""

# Step 2: Add standard Dart analyzer warnings
STANDARD_WARNINGS=(
    "constant_pattern_never_matches_value_type"
    "dead_code"
    "deprecated_member_use"
    "duplicate_ignore"
    "equal_elements_in_set"
    "must_call_super"
    "non_exhaustive_switch_expression"
    "not_assigned_potentially_non_nullable_local_variable"
    "unchecked_use_of_nullable_value"
    "unnecessary_null_comparison"
    "unused_element"
    "unused_field"
    "unused_import"
    "unused_local_variable"
)

# Step 3: Process each lint test directory
echo -e "${BLUE}Step 2: Updating test fixture files...${NC}"
echo ""

UPDATED_COUNT=0

while IFS= read -r dir; do
    LINT_NAME=$(basename "$dir")
    CATEGORY=$(basename "$(dirname "$dir")")

    # Build ignore list (all lints except the current one + standard warnings)
    IGNORE_LIST=()

    for lint in "${ALL_LINTS[@]}"; do
        if [ "$lint" != "$LINT_NAME" ]; then
            IGNORE_LIST+=("$lint")
        fi
    done

    # Add standard warnings
    IGNORE_LIST+=("${STANDARD_WARNINGS[@]}")

    # Sort ignore list
    IFS=$'\n' SORTED_IGNORES=($(sort -u <<<"${IGNORE_LIST[*]}"))
    unset IFS

    # Create comma-separated ignore string
    IGNORE_STRING=$(IFS=', '; echo "${SORTED_IGNORES[*]}")

    # Update both test files in this directory
    for file in "$dir/should_trigger_lint.dart" "$dir/should_not_trigger_lint.dart"; do
        if [ -f "$file" ]; then
            # Read the file content
            CONTENT=$(cat "$file")

            # Remove existing ignore_for_file line(s)
            CONTENT_NO_IGNORE=$(echo "$CONTENT" | grep -v "^// ignore_for_file:" || true)

            # Create new ignore_for_file header
            NEW_HEADER="// ignore_for_file: $IGNORE_STRING"

            # Write new content
            {
                echo "$NEW_HEADER"
                echo ""
                echo "$CONTENT_NO_IGNORE"
            } > "$file"

            echo -e "${GREEN}✓${NC} Updated: $CATEGORY/$LINT_NAME/$(basename "$file")"
            ((UPDATED_COUNT++))
        fi
    done

done < <(find "$TEST_BASE" -type d -mindepth 2 -maxdepth 2 | sort)

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✨ Updated $UPDATED_COUNT test files${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the changes: git diff"
echo "2. Run verification: ./verify.sh"
echo "3. Commit if everything looks good"
echo ""
