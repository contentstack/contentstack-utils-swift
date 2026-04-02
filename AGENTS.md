# AGENTS.md — Contentstack Utils (Swift)

Single entry point for humans and AI agents working on **contentstack-utils-swift**: a small Swift library for rendering Contentstack RTE (rich text) and related JSON to HTML, plus variant alias helpers.

## Project name and purpose

**ContentstackUtils** helps iOS/macOS/tvOS/watchOS apps turn **stack RTE content** (HTML fragments, JSON RTE / “supercharged” RTE, and GraphQL-shaped JSON) into HTML strings, with hooks for embedded entries and assets. It does **not** implement Contentstack REST/GraphQL networking; apps use the [Contentstack Swift SDK](https://www.contentstack.com/docs/developers/sdks/content-delivery-sdk/swift) or other clients to fetch data, then pass strings or dictionaries into this package.

## Tech stack

| Area | Choice |
|------|--------|
| Language | Swift 5 (`Package.swift` `swiftLanguageVersions: [.v5]`, podspec Swift 5.0) |
| Build | Swift Package Manager; CocoaPods via `ContentstackUtils.podspec`; optional Xcode `ContentstackUtils.xcodeproj` |
| HTML/XML | Vendored **Kanna** under `Sources/Kanna/`, **libxml2** (`Modules/`, system on Apple platforms) |
| Tests | **XCTest**, target `ContentstackUtilsTests`, path `Tests/ContentstackUtilsTests/` |
| Lint | **SwiftLint** (`.swiftlint.yml`) |
| Coverage | **Slather** (`.slather.yml`, Cobertura, scheme `ContentstackUtils-Package`) |

## Main entry points (paths and symbols)

| What | Where |
|------|--------|
| Public API surface | `Sources/ContentstackUtils/ContentstackUtils.swift` — `struct ContentstackUtils` (`render`, `jsonToHtml`, `getVariantAliases`, nested `GQL`, `VariantUtilityError`) |
| Rendering options | `Sources/ContentstackUtils/Option.swift` — `open class Option`, `Renderable` |
| RTE JSON model | `Sources/ContentstackUtils/Node.swift`, `JSONNode.swift`, `JSONNodes.swift`, `MarkType.swift`, `Metadata.swift`, … |
| Tests | `Tests/ContentstackUtilsTests/*.swift` (e.g. `ContentstackUtilsTests.swift`, `VariantUtilityTests.swift`, `GQLJsonToHtml.swift`) |
| Package manifest | `Package.swift` — product `ContentstackUtils`, targets `ContentstackUtils`, `ContentstackUtilsTests`, system `libxml2` |

Consumers typically: `import ContentstackUtils`, create an `Option` (or subclass), call `ContentstackUtils.render(content:_:)` or `ContentstackUtils.jsonToHtml(node:_:)` / `ContentstackUtils.GQL.jsonToHtml(rte:_:)`.

## Commands (build / test / lint)

```bash
swift build
swift test
swiftlint
```

CI-style Xcode test (see `.github/workflows/ci.yml`):

```bash
xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test
```

CocoaPods consumption: `pod 'ContentstackUtils', '~> …'` (see `README.md` and `ContentstackUtils.podspec` for current version).

## Cursor rules (`.cursor/rules/`)

| Resource | Role |
|----------|------|
| `.cursor/rules/README.md` | Index of rule files and globs |
| `.cursor/rules/dev-workflow.md` | Branches (`master` / `next` / `staging` expectations), CI parity, PR notes |
| `swift-style.mdc` | Swift + repo style |
| `contentstack-utils-sdk.mdc` | SDK-specific patterns under `Sources/ContentstackUtils/` |
| `tests.mdc` | Test layout and conventions |
| `code-review.mdc` | Always-on PR checklist |

## Skills (`skills/`)

Reusable guidance for agents lives under `skills/<name>/SKILL.md`. See `skills/README.md` for a table of when to use each skill. Typical uses: public API and integration boundaries (`contentstack-utils-api`), XCTest and fixtures (`contentstack-utils-testing`), review criteria (`contentstack-utils-code-review`), libxml/Kanna/SPM platforms (`contentstack-utils-platform`).

## Official docs (external)

- Product: [Contentstack](https://www.contentstack.com/)
- Swift usage examples in this repo: `README.md`
