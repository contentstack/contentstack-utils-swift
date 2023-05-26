#!/bin/sh

#  run-test-case.sh
#  ContentstackUtils
#
#  Created by Uttam Ukkoji on 28/09/20.
#  


echo $DATE
echo "Cleaning Build Folder..."
xcodebuild clean -project ContentstackUtils.xcodeproj -scheme "ContentstackUtils-Package"


# Test result output folders
TEST_BUNDLE_PATH="./TestCase/Bundle/"
TEST_RESULT_PATH="./TestCase/Result/"
TEST_COVERAGE_PATH="./TestCase/Coverage/"

# Date
DATE=$(date +'%v')

FILE_NAME="Contentstack-$DATE"

# Rmove all temparary Folder/Files
echo "Removing temparary files..."
rm -r "$TEST_RESULT_PATH"
rm -r "$TEST_BUNDLE_PATH"
rm -r "$TEST_COVERAGE_PATH"
mkdir "./TestCase"


# Run Contentstack-iOS Test case
echo "Running Test cases on iOS..."
xcodebuild \
    -project ContentstackUtils.xcodeproj \
    -scheme "ContentstackUtils-Package" \
    test \
    -destination "OS=16.2,name=iPhone 14" \
    -resultBundlePath "$TEST_BUNDLE_PATH/$FILE_NAME-iOS.xcresult" \
        | xcpretty \
            --color \
            --report html \
            --output "$TEST_RESULT_PATH/$FILE_NAME-test-result-iOS.html"

slather coverage --html --output-directory "$TEST_COVERAGE_PATH/$FILE_NAME-iOS"

# Run Contentstack-tvOS Test case
echo "Running Test cases on tvOS..."

xcodebuild \
    -project ContentstackUtils.xcodeproj \
    -scheme "ContentstackUtils-Package" \
    test \
    -destination "OS=16.1,name=Apple TV 4K (3rd generation)" \
    -resultBundlePath "$TEST_BUNDLE_PATH/$FILE_NAME-tvOS.xcresult" \
        | xcpretty \
            --color \
            --report html \
            --output  "$TEST_RESULT_PATH/$FILE_NAME-test-result-tvOS.html"

slather coverage --html  --output-directory "$TEST_COVERAGE_PATH/$FILE_NAME-tvOS"


# Run Contentstack-macOS Test case
echo "Running Test cases on macOS..."

xcodebuild \
    -project ContentstackUtils.xcodeproj \
    -scheme "ContentstackUtils-Package" \
    test \
    -destination "platform=macOS" \
    -resultBundlePath "$TEST_BUNDLE_PATH/$FILE_NAME-macOS.xcresult" \
        | xcpretty \
            --color \
            --report html \
            --output "$TEST_RESULT_PATH/$FILE_NAME-test-result-macOS.html"

slather coverage --html  --output-directory "$TEST_COVERAGE_PATH/$FILE_NAME-macOS"

