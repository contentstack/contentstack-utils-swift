# ![Contentstack](https://www.contentstack.com/docs/static/images/contentstack.png)

# Contentstack Swift SDK
![ContentstackUtils CI](https://github.com/contentstack/contentstack-utils-swift/workflows/ContentstackUtils%20CI/badge.svg)

Contentstack is a headless CMS with an API-first approach. It is a CMS that developers can use to build powerful cross-platform applications in their favorite languages. Build your application frontend, and Contentstack will take care of the rest. [Read More](https://www.contentstack.com/).

Contentstack provides iOS SDK to build application on top of iOS. Given below is the detailed guide and helpful resources to get started with our iOS SDK.


### Prerequisite
Latest Xcode and Mac OS X

### Setup and Installation
To use this SDK on iOS platform, you will have to install the SDK according to the steps given below.

##### CocoaPods
Add the following to your Podfile:

    use_frameworks!
    pod 'ContentstackUtils', '~> 1.0.0'
    
#### Swift Package Manager
1. Installing libxml2 to your computer:

    ```bash
    // macOS: For xcode 11.3 and earlier, the following settings are required.
    $ brew install libxml2
    $ brew link --force libxml2

    // Linux(Ubuntu):
    $ sudo apt-get install libxml2-dev
    ```

2. Add the following to your `Package.swift`:

    ```swift
    // swift-tools-version:5.0
    import PackageDescription

    let package = Package(
        name: "YourProject",
        dependencies: [
            .package(url: "https://github.com/tid-kijyun/ContentstackUtils.git", from: "1.0.0"),
        ],
        targets: [
            .target(
                name: "YourTarget",
                dependencies: ["ContentstackUtils"]),
        ]
    )
    ```

    ```bash
    $ swift build
    ```

*Note: When a build error occurs, please try run the following command:*

    // Linux(Ubuntu)
    $ sudo apt-get install pkg-config

#### Manual Installation
1. Add Contentstack Utils file to your project:
    [ContentstackUtils](Sources/ContentstackUtils)  
1. Add Kanna files to your project:  
      [Kanna](Sources/Kanna)  
      [Modules](Modules)
1. In the target settings add `$(SDKROOT)/usr/include/libxml2` to the `Search Paths > Header Search Paths` field
1. In the target settings add `$(SRCROOT)/Modules` to the `Swift Compiler - Search Paths > Import Paths` field



