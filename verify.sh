#!/bin/bash

# Verification script that replicates GitHub Actions workflow checks
# This script runs the same linting and analysis steps as the CI pipeline

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if FVM is being used
if [ -f ".fvmrc" ]; then
    DART_CMD="fvm dart"
    FLUTTER_CMD="fvm flutter"
    print_warning "Using FVM for Dart/Flutter"
else
    DART_CMD="dart"
    FLUTTER_CMD="flutter"
    print_warning "FVM not detected, using system Dart/Flutter"
fi

echo ""
print_step "Starting verification process..."
echo ""

# Step 1: Install dependencies
print_step "Installing dependencies..."
$FLUTTER_CMD pub get
print_success "Dependencies installed"
echo ""

# Step 2: Check dart format in lib
print_step "Checking Dart format in lib folder..."
if $DART_CMD format --set-exit-if-changed lib; then
    print_success "lib folder formatting is correct"
else
    print_error "lib folder has formatting issues"
    echo "Run: $DART_CMD format lib"
    exit 1
fi
echo ""

# Step 3: Run dart analyze in lib
print_step "Running dart analyze in lib folder..."
if $DART_CMD analyze lib; then
    print_success "lib folder analysis passed"
else
    print_error "lib folder analysis failed"
    exit 1
fi
echo ""

# Step 4: Check dart format in test
print_step "Checking Dart format in test folder..."
if $DART_CMD format --set-exit-if-changed test; then
    print_success "test folder formatting is correct"
else
    print_error "test folder has formatting issues"
    echo "Run: $DART_CMD format test"
    exit 1
fi
echo ""

# Step 5: Install dependencies in fixture project
print_step "Installing dependencies in fixture project..."
cd test/fixtures/test_project
$FLUTTER_CMD pub get
cd ../../..
print_success "Fixture project dependencies installed"
echo ""

# Step 6: Run dart analyze in test
print_step "Running dart analyze in test folder..."
if $DART_CMD analyze test; then
    print_success "test folder analysis passed"
else
    print_error "test folder analysis failed"
    exit 1
fi
echo ""

# Step 7: Run custom_lint in test
print_step "Running custom_lint in test folder..."
# Fail on any diagnostic issues (errors, warnings, and infos)
if $DART_CMD run custom_lint test; then
    print_success "custom_lint passed"
else
    print_error "custom_lint failed"
    exit 1
fi
echo ""

# All checks passed
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}All verification checks passed! ✓${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
