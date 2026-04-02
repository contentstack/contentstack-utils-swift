---
name: contentstack-utils-testing
description: XCTest setup for ContentstackUtilsTests—swift test, Xcode scheme, mocks, fixtures, Slather/SwiftLint notes.
---

# Contentstack Utils — testing skill

## Runner

- **SPM:** `swift test` from repository root (target `ContentstackUtilsTests`).
- **Xcode:** Scheme **`ContentstackUtils-Package`**, project **`ContentstackUtils.xcodeproj`** — matches `.github/workflows/ci.yml` (`xcodebuild` + iOS Simulator destination).

## Layout

- Tests live under **`Tests/ContentstackUtilsTests/`** with names like `*Tests.swift`, `*Test.swift`, or feature files (`GQLJsonToHtml.swift`, `DefaultRenderTests.swift`).
- Reuse mocks: `CustomRenderOptionMock.swift`, `EmbededModelMock.swift`, `TestClient.swift`, JSON helpers in `JsonNodes.swift` / `JsonNodesHtmlResults.swift`.

## Lint and coverage

- **SwiftLint:** `.swiftlint.yml` excludes `Tests/ContentstackUtilsTests/Constants.swift` only; other test files are linted.
- **Slather:** `.slather.yml` ignores all of `Tests/*` from coverage reporting; source ignores include Kanna and specific files—see config when interpreting coverage.

## Credentials

- Tests are **offline** (no live API keys). Do not commit secrets; keep fixtures static JSON/Swift literals.

## Linux

- If extending Linux CI, maintain **`XCTestManifests.swift`** as needed for test discovery on Linux.
