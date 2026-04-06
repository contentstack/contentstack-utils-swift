# Cursor Rules – Contentstack Utils Swift

This directory contains Cursor AI rules that apply when working in this repository. Rules provide persistent context so the AI follows project conventions and Contentstack Utils (RTE rendering) patterns.

## How rules are applied

- **File-specific rules** use the `globs` frontmatter: they apply when you open or edit files matching that pattern.
- **Always-on rules** use `alwaysApply: true`: they are included in every conversation in this project.

## Rule index

| File | Applies when | Purpose |
|------|----------------|---------|
| **dev-workflow.md** | (Reference only; no glob) | Core development workflow: branches, running tests, lint, PR expectations. Read for process guidance. |
| **swift-style.mdc** | Editing any `**/*.swift` file | Swift standards: SwiftLint, package layout, Kanna/libxml2, platforms, access control. |
| **contentstack-utils-sdk.mdc** | Editing `Sources/ContentstackUtils/**/*.swift` | Utils SDK patterns: `ContentstackUtils`, `Option` / `Renderable`, RTE/JSON models, GQL helpers, variants, errors. |
| **testing.mdc** | Editing `Tests/**/*.swift` | XCTest layout, mocks, fixtures, SwiftLint/Slather, offline tests. |
| **code-review.mdc** | Always | PR/review checklist: API stability, documentation, error handling, backward compatibility, dependencies and security (e.g. SCA), tests. |

## Related

- **AGENTS.md** (repo root) – Main entry point for AI agents: project overview, entry points, and pointers to rules and skills.
- **skills/** – Reusable skill docs (`contentstack-utils`, `testing`, `code-review`, `framework`) for deeper guidance on specific tasks.
