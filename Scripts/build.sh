#! /bin/sh -e

#Output Path
OUTPUT_DIR_PATH="Build"

function archivePath {
    local DIR=${OUTPUT_DIR_PATH}/archives/"${1}"
    echo "${DIR}"
}

function archive {
    xcodebuild archive \
        -project ${1}.xcodeproj \
        -scheme ${1} \
        -destination "generic/platform=${2}" \
        -archivePath ${3} \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES
}

function createxcframework {
    FRAMEWORK_ARCHIVE_PATH_POSTFIX=".xcarchive/Products/Library/Frameworks"
    
    FRAMEWORK_SIMULATOR_DIR="$(archivePath "${1}-iOS-Device")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
    FRAMEWORK_DEVICE_DIR="$(archivePath "${1}-iOS-Simulator")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"

    FRAMEWORK_SIMULATOR_TV_DIR="$(archivePath "${1}-tvOS-Simulator")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
    FRAMEWORK_DEVICE_TV_DIR="$(archivePath "${1}-tvOS-Device")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"

    FRAMEWORK_SIMULATOR_WATCH_DIR="$(archivePath "${1}-iOS-Device")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"
    FRAMEWORK_DEVICE_WATCH_DIR="$(archivePath "${1}-iOS-Simulator")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"

    FRAMEWORK_DEVICE_MAC_DIR="$(archivePath "${1}-macOS-Device")${FRAMEWORK_ARCHIVE_PATH_POSTFIX}"

    xcodebuild -create-xcframework \
           -framework ${FRAMEWORK_SIMULATOR_DIR}/${1}.framework \
           -framework ${FRAMEWORK_DEVICE_DIR}/${1}.framework \
           -framework ${FRAMEWORK_SIMULATOR_TV_DIR}/${1}.framework \
           -framework ${FRAMEWORK_DEVICE_TV_DIR}/${1}.framework \
           -framework ${FRAMEWORK_SIMULATOR_WATCH_DIR}/${1}.framework \
           -framework ${FRAMEWORK_DEVICE_WATCH_DIR}/${1}.framework \
           -framework ${FRAMEWORK_DEVICE_MAC_DIR}/${1}.framework \
        -output ${1}.xcframework

}

function buildArchive {
    archive ${1} "iOS" $(archivePath "${1}-iOS-Device")
    archive ${1} "iOS Simulator" $(archivePath "${1}-iOS-Simulator")

    archive ${1} "tvOS" $(archivePath "${1}-tvOS-Device")
    archive ${1} "tvOS Simulator" $(archivePath "${1}-tvOS-Simulator")

    archive ${1} "watchOS" $(archivePath "${1}-watchOS-Device")
    archive ${1} "watchOS Simulator" $(archivePath "${1}-watchOS-Simulator")

    archive ${OUTPUT_DIR_PATH}/xcframeworks/${1} "macOS" $(archivePath "${1}-macOS-Device")
}

echo "🚀 Process started "
echo "📂 Evaluating Output Dir"
echo "🧼 Cleaning the dir: ${OUTPUT_DIR_PATH}"
rm -rf $OUTPUT_DIR_PATH

UTILS_FRAMWORK=ContentstackUtils

echo "📝 Archive $UTILS_FRAMWORK"

buildArchive ${UTILS_FRAMWORK}

echo "🗜 Create $UTILS_FRAMWORK.xcframework"
createxcframework ${UTILS_FRAMWORK}

mv ${OUTPUT_DIR_PATH}/xcframeworks/${UTILS_FRAMWORK}.xcframework ${OUTPUT_DIR_PATH}/${UTILS_FRAMWORK}.xcframework

echo "🧼 Cleaning contenst"
rm -rf $OUTPUT_DIR_PATH/xcframeworks
rm -rf $OUTPUT_DIR_PATH/archives

echo "$UTILS_FRAMWORK Framework created"