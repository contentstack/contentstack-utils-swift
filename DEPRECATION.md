# CocoaPods distribution for ContentstackUtils

This notice applies to developers who integrate **ContentstackUtils** using **CocoaPods** (`ContentstackUtils` pod).

## What this package is

**ContentstackUtils** is a **companion library** for the [Contentstack Swift SDK](https://github.com/contentstack/contentstack-swift). It provides utilities (for example JSON RTE rendering and embedded items) for use **alongside** the Swift Content Delivery API (CDA) client. It is **not** a replacement for the core CDA SDK—you still use the [Swift SDK](https://github.com/contentstack/contentstack-swift) for stack, queries, and delivery.

## What we recommend for new work

For **new** projects and new integrations, we recommend adding **ContentstackUtils** with **Swift Package Manager (SPM)** from this repository, and using the **Swift SDK** via SPM as well. That keeps your dependency graph aligned with current tooling and our primary distribution path.

- **Contentstack Swift SDK (source):** [github.com/contentstack/contentstack-swift](https://github.com/contentstack/contentstack-swift)  
- **Swift SDK on Swift Package Index:** [swiftpackageindex.com/contentstack/contentstack-swift](https://swiftpackageindex.com/contentstack/contentstack-swift)  
- **Swift CDA reference:** [Content Delivery SDK — Swift reference](https://www.contentstack.com/docs/developers/sdks/content-delivery-sdk/swift/reference)

**Version alignment:** Use ContentstackUtils versions that match the guidance in this repository’s README (keep Utils in step with the Swift SDK version you use).

We are **deprecating CocoaPods as the recommended way** to add ContentstackUtils for **new** work. CocoaPods remains part of the broader ecosystem, but our product direction favors **SPM** for Apple platforms. For background on how the CocoaPods ecosystem is evolving, see [CocoaPods Specs Repo](https://blog.cocoapods.org/CocoaPods-Specs-Repo/).

## If you already use CocoaPods

**Existing** apps that already depend on the `ContentstackUtils` pod can continue to ship as they do today. You are not required to migrate on a fixed deadline to keep using what you have. When you are ready to standardize on SPM or refresh dependencies, plan a migration at your own pace.

## Maintenance and features

We continue to maintain ContentstackUtils for supported integration paths. **New** feature work and documentation will emphasize **SPM** and the Swift SDK. CocoaPods-based setups may receive necessary maintenance but are not our focus for new capabilities.

## Support

Questions or help with your integration: [support@contentstack.io](mailto:support@contentstack.io).

See also the **Important** section at the top of the [README](./README.md).
