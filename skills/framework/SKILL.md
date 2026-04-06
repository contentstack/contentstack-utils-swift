---
name: framework
description: SPM targets, libxml2 Modules, vendored Kanna, deployment targets, CocoaPods podspec, CI xcodebuild.
---

# Framework / build – Contentstack Utils Swift

## When to use

- Editing `Package.swift`, `Modules/`, or `Sources/Kanna/`.
- Changing deployment targets or conditional libxml linking.
- Updating `ContentstackUtils.podspec` or CI assumptions (scheme, destination).

## Swift Package Manager

- **Product:** `ContentstackUtils`.
- **Targets:** `ContentstackUtils` (sources under `Sources/`), `ContentstackUtilsTests`, system library **`libxml2`** → **`Modules/`**.
- **Apple vs Linux:** Conditional `libxml2` dependency and `pkg-config` as in `Package.swift`—preserve behavior when refactoring.

## Vendored Kanna

- **`Sources/Kanna/`** is excluded from SwiftLint. Updates = intentional vendoring (license, diff, cross-platform build).

## CocoaPods

- **`ContentstackUtils.podspec`:** e.g. `source_files` `Sources/**/*.{swift}`, `HEADER_SEARCH_PATHS` / `-lxml2` for libxml. Keep aligned with SPM layout and tagged releases.

## Platforms

- Declared in `Package.swift` / podspec (e.g. macOS 10.13+, iOS/tvOS 11+, watchOS 4+). See also **`skills/swift-style/SKILL.md`** for API availability and naming.

## CI

- **GitHub Actions** uses **xcodebuild** with scheme **`ContentstackUtils-Package`**. After changing parsing or linking, validate with both **`swift test`** and Xcode builds.

## References

- `skills/swift-style/SKILL.md`
- `skills/dev-workflow/SKILL.md`
