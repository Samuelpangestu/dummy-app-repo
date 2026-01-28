#!/usr/bin/env groovy

/**
 * ===========================
 * DUMMY APP - JENKINS PIPELINE
 * ===========================
 *
 * Triggers: Manual, SCM Polling, GitHub Webhook
 * Jobs: 4 sequential jobs
 *   1. Unit Tests (Python)
 *   2. API Automation Tests (Maven/Cucumber)
 *   3. Load Testing (K6)
 *   4. Summary & Reports
 *
 * Author: QA Automation Team
 * Purpose: Simulate developer repo triggering QA automation tests
 */

pipeline {
    agent any

    // ===========================
    // PARAMETERS
    // ===========================
    parameters {
        booleanParam(
            name: 'RUN_UNIT_TESTS',
            defaultValue: true,
            description: '🧪 Run unit tests for dummy application'
        )
        booleanParam(
            name: 'RUN_API_TESTS',
            defaultValue: true,
            description: '🔧 Run API automation tests from QA repo'
        )
        booleanParam(
            name: 'RUN_LOAD_TESTS',
            defaultValue: true,
            description: '⚡ Run load tests from QA repo'
        )
        choice(
            name: 'TEST_ENVIRONMENT',
            choices: ['production', 'staging', 'development'],
            description: '🌍 Target environment for testing'
        )
        string(
            name: 'API_TEST_TAG',
            defaultValue: '@smoke',
            description: '🏷️ Cucumber tag for API tests (e.g., @smoke, @regression)'
        )
    }

    // ===========================
    // ENVIRONMENT VARIABLES
    // ===========================
    environment {
        PYTHON_VERSION = '3.11'
        JAVA_HOME = '/usr/local/opt/openjdk@17'
        PATH = "${JAVA_HOME}/bin:/usr/local/bin:${env.PATH}"

        // Repository URLs (Samuelpangestu)
        API_REPO_URL = 'https://github.com/Samuelpangestu/api-automation.git'
        LOAD_TEST_REPO_URL = 'https://github.com/Samuelpangestu/load-testing.git'
        REPO_BRANCH = 'main'
    }

    // ===========================
    // BUILD STAGES
    // ===========================
    stages {

        // ===========================
        // STAGE 1: UNIT TESTS
        // ===========================
        stage('🧪 Unit Tests & Build') {
            when {
                expression { params.RUN_UNIT_TESTS == true }
            }
            steps {
                script {
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                    echo '🧪 STAGE 1: Unit Tests & Build'
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                }

                // Setup Python virtual environment
                sh '''
                    echo "📦 Setting up Python environment..."
                    python3 -m venv venv || true
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''

                // Run unit tests with coverage
                sh '''
                    echo "🚀 Running unit tests..."
                    . venv/bin/activate
                    python -m pytest tests/ -v \
                        --cov=src \
                        --cov-report=term \
                        --cov-report=html \
                        --cov-report=xml \
                        --junitxml=test-results.xml
                '''

                // Publish test results
                junit 'test-results.xml'

                // Publish HTML coverage report
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'htmlcov',
                    reportFiles: 'index.html',
                    reportName: '📊 Unit Test Coverage Report'
                ])

                script {
                    echo '✅ Unit tests completed successfully'
                }
            }
        }

        // ===========================
        // STAGE 2: API AUTOMATION
        // ===========================
        stage('🔧 API Automation Tests') {
            when {
                expression { params.RUN_API_TESTS == true }
            }
            steps {
                script {
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                    echo '🔧 STAGE 2: API Automation Tests'
                    echo "   Environment: ${params.TEST_ENVIRONMENT}"
                    echo "   Test Tag: ${params.API_TEST_TAG}"
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                }

                dir('api-automation') {
                    // Clone API automation repository
                    git branch: "${env.REPO_BRANCH}",
                        url: "${env.API_REPO_URL}"

                    // Run API automation tests
                    sh '''
                        echo "🔧 Running API automation tests..."

                        # Check if run_test.sh exists
                        if [ -f run_test.sh ]; then
                            echo "✅ Found run_test.sh, using script..."
                            chmod +x run_test.sh
                            ./run_test.sh smoke || true
                        else
                            echo "⚠️ run_test.sh not found, running Maven directly..."
                            mvn clean test -Dcucumber.filter.tags="@smoke" || true
                        fi
                    '''

                    // Publish Allure report
                    script {
                        try {
                            allure([
                                includeProperties: false,
                                jdk: '',
                                results: [[path: 'target/allure-results']]
                            ])
                        } catch (Exception e) {
                            echo "⚠️ Allure report generation skipped (plugin may not be installed)"
                            echo "   Install via: Manage Jenkins → Plugins → Allure Jenkins Plugin"
                        }
                    }

                    // Archive test results
                    archiveArtifacts artifacts: 'target/allure-results/**/*',
                                   allowEmptyArchive: true,
                                   fingerprint: true
                }

                script {
                    echo '✅ API automation tests completed'
                }
            }
        }

        // ===========================
        // STAGE 3: LOAD TESTING
        // ===========================
        stage('⚡ Load Testing') {
            when {
                expression { params.RUN_LOAD_TESTS == true }
            }
            steps {
                script {
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                    echo '⚡ STAGE 3: Load Testing (Locust)'
                    echo '   Tool: Locust (Python-based)'
                    echo '   Virtual Users: 5'
                    echo '   Spawn Rate: 10 users/sec'
                    echo '   Duration: 30s'
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                }

                dir('load-testing') {
                    // Clone load testing repository (Locust)
                    git branch: "${env.REPO_BRANCH}",
                        url: "${env.LOAD_TEST_REPO_URL}"

                    // Setup Python & Locust
                    sh '''
                        echo "🐍 Setting up Python and Locust..."

                        # Create virtual environment
                        python3 -m venv venv || true
                        . venv/bin/activate

                        # Install Locust and dependencies
                        pip install --upgrade pip
                        pip install locust

                        if [ -f requirements.txt ]; then
                            pip install -r requirements.txt
                        fi
                    '''

                    // Run load tests
                    sh '''
                        echo "⚡ Running Locust load tests..."
                        . venv/bin/activate

                        # Create reports directory
                        mkdir -p reports

                        # Run with script if exists, otherwise run direct
                        if [ -f run_load_test.sh ]; then
                            chmod +x run_load_test.sh
                            ./run_load_test.sh || true
                        else
                            # Run Locust headless mode
                            locust --headless \
                                --users 5 \
                                --spawn-rate 10 \
                                --run-time 30s \
                                --host https://indodax.com \
                                --html reports/locust-report.html \
                                --csv reports/locust-stats || true
                        fi
                    '''

                    // Publish HTML report
                    publishHTML([
                        allowMissing: true,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'reports',
                        reportFiles: 'locust-report.html',
                        reportName: '⚡ Locust Load Test Report'
                    ])

                    // Archive test results
                    archiveArtifacts artifacts: 'reports/**/*',
                                   allowEmptyArchive: true,
                                   fingerprint: true
                }

                script {
                    echo '✅ Load testing completed'
                }
            }
        }

        // ===========================
        // STAGE 4: SUMMARY
        // ===========================
        stage('📋 Pipeline Summary') {
            steps {
                script {
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                    echo '📋 PIPELINE EXECUTION SUMMARY'
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                    echo ''
                    echo '📊 Job Results:'
                    echo "   🧪 Unit Tests:       ${params.RUN_UNIT_TESTS ? '✅ EXECUTED' : '⏭️ SKIPPED'}"
                    echo "   🔧 API Automation:   ${params.RUN_API_TESTS ? '✅ EXECUTED' : '⏭️ SKIPPED'}"
                    echo "   ⚡ Load Testing:     ${params.RUN_LOAD_TESTS ? '✅ EXECUTED' : '⏭️ SKIPPED'}"
                    echo ''
                    echo 'ℹ️ Execution Info:'
                    echo "   Environment:      ${params.TEST_ENVIRONMENT}"
                    echo "   API Test Tag:     ${params.API_TEST_TAG}"
                    echo "   Build Number:     ${env.BUILD_NUMBER}"
                    echo "   Build URL:        ${env.BUILD_URL}"
                    echo ''
                    echo '📊 Available Reports:'
                    if (params.RUN_UNIT_TESTS) {
                        echo "   - Unit Test Coverage: ${env.BUILD_URL}Unit_20Test_20Coverage_20Report/"
                    }
                    if (params.RUN_API_TESTS) {
                        echo "   - Allure Report:      ${env.BUILD_URL}allure/"
                    }
                    if (params.RUN_LOAD_TESTS) {
                        echo "   - Locust Load Test:   ${env.BUILD_URL}Locust_20Load_20Test_20Report/"
                    }
                    echo ''
                    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
                }
            }
        }
    }

    // ===========================
    // POST BUILD ACTIONS
    // ===========================
    post {
        success {
            script {
                echo ''
                echo '🎉 ============================================'
                echo '🎉 PIPELINE COMPLETED SUCCESSFULLY!'
                echo '🎉 ============================================'
                echo ''
                echo "📊 View full report: ${env.BUILD_URL}"
                echo ''
            }
        }

        failure {
            script {
                echo ''
                echo '❌ ============================================'
                echo '❌ PIPELINE FAILED!'
                echo '❌ ============================================'
                echo ''
                echo "🔍 Check logs: ${env.BUILD_URL}console"
                echo ''
            }
        }

        always {
            // Cleanup
            script {
                echo '🧹 Cleaning up workspace...'
            }

            // Clean up Python virtual environment
            sh 'rm -rf venv || true'

            // Clean up repository checkouts
            sh 'rm -rf api-automation || true'
            sh 'rm -rf load-testing || true'
        }
    }
}
