# Dummy Developer App Repository

A sample Python application demonstrating CI/CD integration with automated quality assurance testing.

---

## Quick Start

```bash
# Clone and setup
git clone <your-repo-url>
cd dummy-app-repo

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run tests locally
python -m pytest tests/ -v --cov=src
```

---

## Tech Stack

- **Language:** Python 3.11+
- **Testing:** pytest with coverage
- **CI/CD:** GitHub Actions + Jenkins (dual support)
- **Coverage:** 93% (16 test cases)
- **Architecture:** Simple, clean, and maintainable

---

## Features

- Sample Python application with Calculator and User Service modules
- 16 unit tests with 93% code coverage
- Dual CI/CD platform support (GitHub Actions + Jenkins)
- 3 trigger types: push, schedule, manual
- 4-stage pipeline: Unit Tests → API Tests → Load Tests → Summary
- Integration with QA automation repository
- Comprehensive test reports (coverage, Allure, K6)

---

## Prerequisites

- Python 3.11+
- pip
- Git

---

## Installation

```bash
# 1. Clone repository
git clone <your-repo-url>
cd dummy-app-repo

# 2. Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Verify installation
python -m pytest tests/ -v
```

---

## Project Structure

```
dummy-app-repo/
├── .github/
│   └── workflows/
│       └── ci-cd-pipeline.yml      # GitHub Actions workflow
├── src/                            # Application source code
│   ├── __init__.py
│   ├── calculator.py               # Calculator module
│   └── user_service.py             # User service module
├── tests/                          # Unit tests (16 tests, 93% coverage)
│   ├── __init__.py
│   ├── test_calculator.py          # Calculator tests (7 tests)
│   └── test_user_service.py        # User service tests (9 tests)
├── Jenkinsfile                     # Jenkins pipeline configuration
├── run_tests.sh                    # Local test runner script
├── requirements.txt                # Python dependencies
└── README.md                       # This file
```

---

## Running Tests

### Local Testing

```bash
# Run all tests
python -m pytest tests/ -v

# Run with coverage
python -m pytest tests/ -v --cov=src --cov-report=html

# Run specific test file
python -m pytest tests/test_calculator.py -v

# Run specific test
python -m pytest tests/test_calculator.py::TestCalculator::test_add_positive_numbers -v

# View HTML coverage report
open htmlcov/index.html  # macOS
# or
xdg-open htmlcov/index.html  # Linux
```

### Using Test Script

```bash
# Run all tests with coverage
./run_tests.sh
```

---

## CI/CD Integration

### GitHub Actions (Cloud-based)

**Configuration:** `.github/workflows/ci-cd-pipeline.yml`

**3 Trigger Types:**

1. **Push Trigger** (Automatic)
```bash
git add .
git commit -m "Update feature"
git push origin main
```

2. **Schedule Trigger** (Automatic)
- Runs daily at 2 AM UTC
- Configured via cron: `0 2 * * *`

3. **Manual Trigger** (On-demand)
- Navigate to GitHub Actions tab
- Select workflow "CI/CD Pipeline - QA Automation Trigger"
- Click "Run workflow"
- Configure options and run

**Pipeline Stages:**

1. Unit Tests & Build
   - Validate application code quality
   - Run pytest with coverage
   - Upload coverage reports

2. API Automation Tests
   - Checkout QA automation repository
   - Run API tests (Cucumber + REST Assured)
   - Generate Allure report

3. Load Testing
   - Checkout QA automation repository
   - Run K6 load tests
   - Generate performance report

4. Pipeline Summary
   - Aggregate all results
   - Generate markdown summary
   - Display in GitHub Actions UI

### Jenkins (Self-hosted)

**Configuration:** `Jenkinsfile`

Same 4-stage pipeline with:
- Allure report integration
- HTML coverage reports
- K6 performance reports
- Console output logs

---

## Test Coverage

```
Current Coverage: 93%

Module                Lines    Miss    Cover
-------------------------------------------
src/calculator.py        15       1     93%
src/user_service.py      12       1     92%
-------------------------------------------
TOTAL                    27       2     93%
```

**Test Breakdown:**
- Calculator Tests: 7 scenarios
- User Service Tests: 9 scenarios
- Total: 16 test cases

---

## Architecture

```
Developer Repository (This Repo)
         │
         │ Triggers: Push/Schedule/Manual
         │
         ▼
   CI/CD Pipeline
   ├─ Job 1: Unit Tests & Build
   ├─ Job 2: API Automation Tests (from QA repo)
   ├─ Job 3: Load Testing (from QA repo)
   └─ Job 4: Summary Report
```

---

## CI/CD Platform Comparison

| Feature | GitHub Actions | Jenkins |
|---------|----------------|---------|
| **Hosting** | Cloud-based | Self-hosted |
| **Setup** | Quick (pre-configured) | Manual (plugins required) |
| **Cost** | 2,000 min/month free | Free (own infrastructure) |
| **Reports** | Artifacts, job summaries | Allure, HTML, rich UI |
| **Customization** | Limited to GitHub | Highly customizable |
| **Speed** | Fast (parallel runners) | Depends on resources |

**This project supports both platforms for maximum flexibility!**

---

## How It Works

### Scenario 1: Developer Push Code

```bash
# Developer makes changes
vim src/calculator.py

# Commit and push
git add src/calculator.py
git commit -m "Add new calculation method"
git push origin main

# CI/CD automatically:
# ✓ Runs unit tests
# ✓ Runs API automation tests
# ✓ Runs load tests
# ✓ Generates reports
```

### Scenario 2: Scheduled Daily Testing

```
Every day at 2 AM UTC:
  ├─ Pipeline automatically runs
  ├─ Tests all functionality
  ├─ Generates reports
  └─ Sends notification if failures occur
```

### Scenario 3: Manual Testing Before Release

```
QA Engineer or Developer:
  1. Open GitHub Actions/Jenkins
  2. Trigger workflow manually
  3. Select environment (production/staging)
  4. Choose tests to run
  5. Review results and reports
```

---

## View Test Reports

### GitHub Actions Reports

**Unit Test Reports**
- Location: Actions → Workflow Run → Unit Tests job
- Artifacts: `coverage.xml`, `htmlcov/`

**API Test Reports (Allure)**
- Location: Actions → Workflow Run → API Automation job
- Artifacts: `api-test-results/`

**Load Test Reports (K6)**
- Location: Actions → Workflow Run → Load Testing job
- Artifacts: `load-test-results/`

### Jenkins Reports

**Unit Test Coverage**
- Location: Build → Sidebar → Unit Test Coverage Report
- Shows: Line/branch/function coverage

**Allure Report (API Tests)**
- Location: Build → Sidebar → Allure Report
- Shows: Test scenarios, pass/fail, timeline

**K6 Load Test Report**
- Location: Build → Sidebar → K6 Load Test Report
- Shows: Request metrics, response times, charts

---

## Benefits

### Continuous Quality Assurance
- Automatic testing on every code change
- Early bug detection
- Prevent broken code in production

### Time & Cost Efficiency
- Automated testing saves manual testing time
- Parallel execution provides faster feedback
- Scheduled testing during idle resources

### Visibility & Transparency
- Detailed test reports
- Coverage metrics
- Performance metrics
- Easy quality tracking over time

### Developer Experience
- Fast feedback loop
- Clear error messages
- Easy to debug failures

---

## Related Repositories

**QA Automation Repository:** `indodax-qa-automation-test`
- API Automation (Cucumber + Java + Maven)
- Load Testing (K6)
- Web Automation (Playwright + TypeScript)
- Mobile Automation (Appium + Java)

---

## Documentation

For complete architecture and design decisions, see root documentation folder.

---

## Created by

Samuel
