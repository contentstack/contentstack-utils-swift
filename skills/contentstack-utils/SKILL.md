---
name: contentstack-utils
description: Use when changing ContentstackUtils Swift public API—rendering, Option/Renderable, GQL JSON, variants, errors; no bundled HTTP client.
---

# Contentstack Utils – SDK skill

## When to use

- Implementing or changing RTE/HTML rendering, JSON RTE parsing, or variant helpers.
- Updating `README.md` / `CHANGELOG.md` / podspec for user-visible behavior.
- Assessing semver impact of `public` / `open` changes.

## Instructions

This package exposes **HTML/RTE rendering** and **variant alias** helpers. It does **not** ship Stack configuration, API keys, or network clients.

### Core types

- **`ContentstackUtils`** (`Sources/ContentstackUtils/ContentstackUtils.swift`): `render(content:_:)`, `render(contents:_:)`, `jsonToHtml` overloads, `getVariantAliases`, nested **`GQL`** with `jsonToHtml(rte:_:)` for GraphQL-shaped dictionaries.
- **`Option`** (`Option.swift`): open class; override `renderItem`, `renderMark`, `renderNode`. Implements **`Renderable`**.
- **RTE JSON:** `Node`, `JSONNode`, `JSONNodes`, `MarkType`, `StyleType`, `Metadata`, embedded models—keep decoding aligned with stack payloads.

### Errors

- Use **`ContentstackUtils.VariantUtilityError`** (and similar nested types) for domain failures; prefer `throws` over opaque optionals for invalid variant input.

### Integration boundary

- README examples using **`Contentstack.stack`**, **`fetch`**, or **Apollo** are illustrative only—do not add those as package dependencies without an explicit product decision.

### Docs and versioning

- Align **`ContentstackUtils.podspec`** and tags with releases. Follow semver for `public` / `open` changes.

## References

- Project rule: `.cursor/rules/contentstack-utils-sdk.mdc`
- Product: [Contentstack](https://www.contentstack.com/)
