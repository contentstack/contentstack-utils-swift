---
name: contentstack-utils
description: Public API—ContentstackUtils, Option/Renderable, RTE/JSON, GQL, variants, errors; no bundled HTTP client.
---

# Contentstack Utils – SDK skill

## When to use

- Implementing or changing RTE/HTML rendering, JSON RTE parsing, or variant helpers.
- Updating `README.md` / `CHANGELOG.md` / podspec for user-visible behavior.
- Assessing semver impact of `public` / `open` changes.

## Main entry (consumer API)

- Consumers `import ContentstackUtils` and use **`ContentstackUtils`**: e.g. `render(content:_:)`, `render(contents:_:)`, `jsonToHtml(node:_:)`, `getVariantAliases`, nested **`GQL.jsonToHtml(rte:_:)`**.
- Keep the static surface small and documented; breaking changes need semver and changelog notes.

## Customization

- Subclass or extend via **`Option`** (open class) conforming to **`Renderable`**: `renderItem(embeddedObject:metadata:)`, `renderMark(markType:text:)`, `renderNode(nodeType:node:next:)`.
- Do not remove or rename open hooks without a **major** version.

## Data model

- RTE JSON uses **`Node`**, **`JSONNode`** / **`JSONNodes`**, **`MarkType`**, **`StyleType`**, **`Metadata`**, embedded entry/asset types (`EmbeddedObject`, `EmbeddedEntry`, etc.).
- Preserve **`Codable`** / decoding compatibility with Contentstack Delivery and GraphQL payloads.

## Errors

- Expose domain failures with nested types where appropriate (e.g. **`ContentstackUtils.VariantUtilityError.invalidArgument`**).
- Use **`throws`** for recoverable failures; avoid force-unwraps on public paths.

## HTML and documentation

- Rendering uses Kanna/HTML internally; keep output predictable for documented inputs.
- Document new node types or GQL JSON shapes in **`README.md`** / **`CHANGELOG.md`**.

## No network layer

- This package does **not** ship HTTP clients or tokens.
- README examples showing **`Stack`**, **`fetch`**, or **Apollo** are integration sketches only—do **not** add hard dependencies on the main Contentstack iOS SDK or Apollo in **`Package.swift`** unless product explicitly requires it.

## Legacy naming

- Some names (e.g. **`embdeddedItems`**) are entrenched; changing them is a **breaking** API change—coordinate with maintainers.

## Docs and versioning

- Align **`ContentstackUtils.podspec`** and git tags with releases. Follow **semver** for `public` / `open` changes.

## References

- [Contentstack](https://www.contentstack.com/)
- `skills/swift-style/SKILL.md`, `skills/framework/SKILL.md`
