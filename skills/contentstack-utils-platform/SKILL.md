---
name: contentstack-utils-platform
description: Build/runtime stack for ContentstackUtils—SPM targets, libxml2, vendored Kanna, Apple vs Linux, deployment targets.
---

# Contentstack Utils — platform and runtime skill

## Swift Package Manager

- **`Package.swift`:** Product **`ContentstackUtils`**; targets **`ContentstackUtils`** (sources `Sources/`), **`ContentstackUtilsTests`**, system library **`libxml2`** pointing at **`Modules/`**.
- **Conditional dependencies:** On Swift ≥5.3 and non-Linux Apple platforms, `ContentstackUtils` may omit the explicit `libxml2` target dependency; Linux uses `pkg-config` / `libxml-2.0` and apt providers as declared.

## Vendored Kanna

- HTML parsing lives under **`Sources/Kanna/`**. SwiftLint excludes this path globally—changes here are infrequent and should stay aligned with intentional vendoring updates.

## Platforms

- **Declared:** macOS 10.13+, iOS/tvOS 11+, watchOS 4+ (`Package.swift` / podspec). Do not use newer SDK APIs without availability checks or raising deployment targets deliberately.

## CocoaPods

- **`ContentstackUtils.podspec`:** `source_files` `Sources/**/*.{swift}`, `HEADER_SEARCH_PATHS` / `-lxml2` for libxml. Pod releases must match tagged source layout.

## CI note

- GitHub Actions uses **Xcode** and **xcodebuild** for iOS Simulator tests; local SPM `swift test` may differ slightly—run both when changing low-level parsing or linking.
