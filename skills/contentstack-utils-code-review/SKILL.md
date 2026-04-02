---
name: contentstack-utils-code-review
description: PR review for contentstack-utils-swift—severity-rated checks for API, docs, errors, compatibility, deps, tests.
---

# Contentstack Utils — code review skill

Use this skill to review changes consistently with `.cursor/rules/code-review.mdc`, with explicit **severity**.

## Blocker

- Breaks **`public`/`open`** API without semver/CHANGELOG/podspec alignment.
- Removes or weakens handling of RTE JSON shapes that existing apps rely on (without migration notes).
- New dependencies in **`Package.swift`** / **podspec** without security/license review when org requires it.
- **No tests** for clear behavioral fixes or new features in `Sources/ContentstackUtils/` when tests are practical.

## Major

- **`throws` / error** changes that confuse callers (wrong type, message, or non-throwing to throwing without version bump).
- **Kanna** or **`Modules/libxml2`** edits that diverge from upstream without documentation or break Linux/Apple builds.
- **README** examples that no longer compile against the actual API.

## Minor

- Style-only issues fixable by SwiftLint; internal naming; comment clarity.
- Test naming or fixture organization improvements without functional gaps.

## Always verify

- `swift build` / `swift test` (and Xcode scheme if touching iOS-specific paths).
- SwiftLint clean for edited files (respect exclusions).
- Backward compatibility for default **`Option()`** rendering paths.
