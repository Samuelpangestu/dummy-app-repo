#!/bin/bash

# ============================================
# Setup .gitignore for All Repositories
# ============================================

echo "🔧 Setting up .gitignore for all repositories..."
echo ""

# Get the project root
PROJECT_ROOT="/Users/qainadigital/IdeaProjects/indodax-qa-automation-test"

# ============================================
# 1. dummy-app-repo (Already has .gitignore)
# ============================================
echo "✅ dummy-app-repo: .gitignore already exists"

# ============================================
# 2. api-automation
# ============================================
echo "📝 Creating .gitignore for api-automation..."
cat > "$PROJECT_ROOT/api-automation/.gitignore" << 'GITIGNORE'
# Java / Maven
target/
*.class
*.jar
*.war
*.ear
*.log

# Maven
.mvn/
mvnw
mvnw.cmd
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties

# IDE
.idea/
*.iml
*.iws
*.ipr
.vscode/
*.swp
*.swo
*~
.settings/
.classpath
.project

# Test Reports
allure-results/
allure-report/
test-output/
screenshots/
reports/

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/
GITIGNORE
echo "✅ api-automation/.gitignore created"

# ============================================
# 3. load-testing
# ============================================
echo "📝 Creating .gitignore for load-testing..."
cat > "$PROJECT_ROOT/load-testing/.gitignore" << 'GITIGNORE'
# Python / Locust
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
*.egg-info/
.installed.cfg
*.egg

# Locust Reports
reports/
*.html
*.csv
locust-*.log

# Test Results
test-results/
results/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Testing
.pytest_cache/
.coverage
htmlcov/
.tox/

# Environment
.env
.env.local
GITIGNORE
echo "✅ load-testing/.gitignore created"

# ============================================
# 4. web-automation
# ============================================
echo "📝 Creating .gitignore for web-automation..."
cat > "$PROJECT_ROOT/web-automation/.gitignore" << 'GITIGNORE'
# Node / npm
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
package-lock.json
yarn.lock
.pnpm-debug.log*

# TypeScript
*.tsbuildinfo
dist/
build/

# Playwright
test-results/
playwright-report/
playwright/.cache/
screenshots/
videos/
traces/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Environment
.env
.env.local
.env.test

# Test Reports
allure-results/
allure-report/
reports/
GITIGNORE
echo "✅ web-automation/.gitignore created"

# ============================================
# 5. mobile-automation
# ============================================
echo "📝 Creating .gitignore for mobile-automation..."
cat > "$PROJECT_ROOT/mobile-automation/.gitignore" << 'GITIGNORE'
# Java / Maven
target/
*.class
*.jar
*.war
*.ear
*.log

# Maven
.mvn/
mvnw
mvnw.cmd
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties

# Appium / Mobile
.allure/
apps/*.apk
apps/*.ipa
apps/*.app
!apps/.gitkeep

# IDE
.idea/
*.iml
*.iws
*.ipr
.vscode/
*.swp
*.swo
*~
.settings/
.classpath
.project

# Test Reports
allure-results/
allure-report/
test-output/
screenshots/
reports/
videos/

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/
appium.log

# Android
local.properties
*.apk
*.ap_
*.aab

# iOS
*.ipa
*.dSYM.zip
*.dSYM
GITIGNORE
echo "✅ mobile-automation/.gitignore created"

# ============================================
# 6. load-testing-k6 (if exists)
# ============================================
if [ -d "$PROJECT_ROOT/load-testing-k6" ]; then
    echo "📝 Creating .gitignore for load-testing-k6..."
    cat > "$PROJECT_ROOT/load-testing-k6/.gitignore" << 'GITIGNORE'
# K6 Reports
reports/
*.html
*.json
*.csv
k6-*.log

# Test Results
test-results/
results/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Node (if using k6 extensions)
node_modules/
package-lock.json
GITIGNORE
    echo "✅ load-testing-k6/.gitignore created"
fi

echo ""
echo "✅ All .gitignore files created successfully!"
echo ""
echo "Next steps:"
echo "1. Review generated .gitignore files"
echo "2. Clean any unwanted files (target/, node_modules/, etc.)"
echo "3. Commit and push each repository"
