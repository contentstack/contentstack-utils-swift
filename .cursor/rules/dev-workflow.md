# Development workflow (ContentstackUtils Swift)

## Branches and pull requests

- **CI** runs on push to `master` and on pull requests targeting `master` or `next` (see `.github/workflows/ci.yml`).
- **Merges into `master`** from the wider org are gated: pull requests whose base is `master` are expected to come from the `staging` branch; other head branches may be blocked by the check-branch workflow (`.github/workflows/check-branch.yml`). Confirm with your team’s release process before opening PRs to `master`.

## Build and test

**Swift Package Manager (library development):**

```bash
swift build
swift test
```

**Xcode (matches CI):** CI uses the Xcode project and iOS Simulator:

```bash
xcodebuild -project "ContentstackUtils.xcodeproj" -scheme "ContentstackUtils-Package" -destination "OS=13.4.1,name=iPhone 11 Pro" test
```

Adjust `-destination` for your local Xcode/Simulator names. CI pins `DEVELOPER_DIR` to a specific Xcode; local runs use your default toolchain.

## Lint and format

- **SwiftLint:** configuration is `.swiftlint.yml` (excludes `Carthage`, `Pods`, `Sources/Kanna`, and some test constants). Run from repo root:

```bash
swiftlint
```

- **Formatting:** there is no separate formatter config in-repo; match existing file style and SwiftLint output.

## Coverage

- **Slather** is configured in `.slather.yml` (Cobertura, scheme `ContentstackUtils-Package`, ignores tests, Kanna, and `Decodable.*` under ContentstackUtils). Use Slather/Xcode coverage as your team prefers after a test run.

## Pull request expectations

- Describe behavior changes and any public API or semver impact.
- Update `CHANGELOG.md` and version metadata (`ContentstackUtils.podspec`, tags) when releasing—per team process.
- Ensure tests pass locally (`swift test` and/or `xcodebuild` as above).
- Security/policy scans may run in CI (`.github/workflows/sca-scan.yml`, `policy-scan.yml`); fix findings per org policy.

## Test-driven development

TDD is optional; there is no enforced workflow. New behavior should include or update tests under `Tests/ContentstackUtilsTests/` when feasible.
