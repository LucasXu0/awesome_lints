#!/bin/bash
set -e

echo "🚀 Setting up awesome_lints development environment..."
echo ""

# Check if fvm is installed
if ! command -v fvm &> /dev/null; then
    echo "❌ FVM is not installed. Please install it first:"
    echo "   dart pub global activate fvm"
    exit 1
fi

echo "✅ FVM is installed"

# Check if we're using the correct Flutter version
if [ -f ".fvmrc" ]; then
    echo "📦 Installing Flutter version from .fvmrc..."
    fvm install
    echo "✅ Flutter version installed"
else
    echo "⚠️  No .fvmrc found, using system Flutter"
fi

# Install dependencies
echo ""
echo "📥 Installing awesome_lints dependencies..."
fvm dart pub get

# Setup test fixtures
echo ""
echo "📥 Installing test fixture dependencies..."
cd test/fixtures/test_project
fvm flutter pub get
cd ../../..

echo ""
echo "✅ Dependencies installed"

# Run analysis
echo ""
echo "🔍 Running Dart analysis..."
fvm dart analyze

echo ""
echo "🔍 Running custom_lint on test fixtures..."
cd test/fixtures/test_project
fvm dart run custom_lint
cd ../../..

echo ""
echo "✅ Analysis complete"

# Run verify script if it exists
if [ -f "verify.sh" ]; then
    echo ""
    echo "🧪 Running verify script..."
    ./verify.sh
    echo "✅ Verify script passed"
fi

echo ""
echo "✨ Setup complete! You're ready to develop awesome_lints."
echo ""
echo "Quick commands:"
echo "  fvm dart analyze                    - Run analysis"
echo "  fvm dart test                       - Run tests"
echo "  ./verify.sh                         - Run full verification"
echo "  fvm dart run custom_lint --watch    - Watch mode for development"
echo ""
