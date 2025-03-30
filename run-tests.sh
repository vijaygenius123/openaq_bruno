#!/bin/bash

cd OpenAQ

# Run Bruno tests with JUnit reporter
echo "Running Bruno tests..."
bru run --env Live --reporter-junit junit.xml

# Prepare Allure results
echo "Preparing Allure results..."
mkdir -p allure-results
cp junit.xml allure-results/

# Copy history from previous run if it exists
if [ -d "allure-report/history" ]; then
  echo "Copying history from previous runs..."
  mkdir -p allure-results/history
  cp -r allure-report/history/* allure-results/history/
fi

# Generate Allure report
echo "Generating Allure report..."
allure generate allure-results --clean -o allure-report --report-format junit

# Serve the generated report
echo "Opening Allure report..."
allure open allure-report 