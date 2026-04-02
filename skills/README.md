# Agent skills (Contentstack Utils Swift)

Skills are reusable instruction sets for AI agents. Each skill is a folder containing `SKILL.md` with YAML frontmatter (`name`, `description`).

| Skill folder | When to use it |
|--------------|----------------|
| `contentstack-utils-api` | Changing or documenting public API, `ContentstackUtils` / `Option` / RTE JSON types, GQL JSON entry points, errors, semver impact. |
| `contentstack-utils-testing` | Adding or fixing XCTest tests, mocks, JSON fixtures, `swift test` / Xcode test workflow. |
| `contentstack-utils-code-review` | Structured PR review with severity (blocker/major/minor) aligned with this SDK. |
| `contentstack-utils-platform` | libxml2, Kanna vendoring, SPM targets, deployment platforms, `Modules/`, Linux vs Apple differences. |
