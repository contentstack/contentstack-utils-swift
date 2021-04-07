// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Starting with Xcode 12, we don't need to depend on our own libxml2 target
#if swift(>=5.3) && !os(Linux)
let dependencies: [Target.Dependency] = []
#else
let dependencies: [Target.Dependency] = ["libxml2"]
#endif

#if swift(>=5.2) && !os(Linux)
let pkgConfig: String? = nil
#else
let pkgConfig = "libxml-2.0"
#endif

#if swift(>=5.2)
let provider: [SystemPackageProvider] = [
    .apt(["libxml2-dev"])
]
#else
let provider: [SystemPackageProvider] = [
    .apt(["libxml2-dev"]),
    .brew(["libxml2"])
]
#endif
let package = Package(
    name: "ContentstackUtils",
    platforms: [.macOS(.v10_12),
                .iOS(.v10),
                .tvOS(.v10),
                .watchOS(.v3)],

    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ContentstackUtils",
            targets: ["ContentstackUtils"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .systemLibrary(
            name: "libxml2",
            path: "Modules",
            pkgConfig: pkgConfig,
            providers: provider
        ),
        .target(
            name: "ContentstackUtils",
            dependencies: dependencies,
            path: "Sources",
            exclude: [
                "Sources/Kanna/Info.plist",
                "Sources/Kanna/Kanna.h",
                "Tests/KannaTests/Data"
            ]),
        .testTarget(
            name: "ContentstackUtilsTests",
            dependencies: ["ContentstackUtils"]),
        
    ],
    swiftLanguageVersions: [.v5]
)
