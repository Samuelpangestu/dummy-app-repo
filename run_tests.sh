#!/bin/bash

# ===========================
# Run Tests Script
# ===========================
# Simple script untuk run unit tests locally

set -e

echo "🧪 Running Unit Tests..."
echo "========================"
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📥 Installing dependencies..."
pip install -q -r requirements.txt

# Run tests
echo ""
echo "🚀 Running pytest with coverage..."
echo ""
python -m pytest tests/ -v --cov=src --cov-report=term --cov-report=html

# Check exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All tests passed!"
    echo ""
    echo "📊 Coverage report generated: htmlcov/index.html"
    echo "   Open with: open htmlcov/index.html (macOS) or xdg-open htmlcov/index.html (Linux)"
else
    echo ""
    echo "❌ Tests failed!"
    exit 1
fi
