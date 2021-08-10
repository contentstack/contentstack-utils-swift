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
    pod 'ContentstackUtils', '~> 1.2.0'
    
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
            .package(url: "https://github.com/tid-kijyun/ContentstackUtils.git", from: "1.2.0"),
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

> Note: If you are using Contentstack Swift SDK in your project, the ContentstackUtils file is already imported.

## Usage

Let’s learn how you can use Utils SDK to render embedded items.

### Create Render Option

To render embedded items on the front-end, create a class implementing Option protocol,  and define the UI elements you want to show in the front-end of your website, as shown in the example below:
```swift
import Foundation  
import ContentstackUtils  
class  CustomRenderOption: Option {  

override func renderMark(markType: MarkType, text: String) -> String {
    switch markType {
    case .bold:
        return "<b>\(text)</b>"
    default:
        return super.renderMark(markType: markType, text: text)
    }
}

override func renderNode(nodeType: String, node: Node, next: (([Node]) -> String)) -> String {
    switch nodeType {
    case "p":
        return "<p class='class-id'>\(next(node.children))</p>"
    case "h1":
        return "<h1 class='class-id'>\(next(node.children))</h1>"
    default:
        return super.renderNode(nodeType: nodeType, node: node, next: next)
    }
}
  
func renderOptions(embeddedObject: EmbeddedObject, metadata: Metadata) -> String? {
      switch metadata.styleType {
      case .block:
          if metadata.contentTypeUid == "product" {
              if let product = embeddedObject as? Product {
                  return """
                      <div>
                      <h2 >\(product.title)</h2>
                      <img src=\(product.product_image.url) alt=\(product.product_image.title)/>
                      <p>\(product.price)</p>
                      </div>
                  """
              }
          }else {
              if let entry = embeddedObject as? Entry {
                  return """
                      <div>
                      <h2>\(entry.title)</h2>
                      <p>\(entry.description)</p>
                      </div>
                      """
              }
          }
      default:
          return super.renderOptions(embeddedObject: embeddedObject, metadata: metadata)
      }
}
```

## Basic Queries
Contentstack Utils SDK lets you interact with the Content Delivery APIs and retrieve embedded items from the RTE field of an entry.

### Fetch Embedded Item(s) from a Single Entry
#### Render HTML RTE Embedded object
To get an embedded items of a single entry, you need to provide the stack API key, environment name, delivery token, content type and entry UID. Then, use the `ContentstackUtils.render` functions as shown below:
```swift
import ContentstackUtils  

let stack:Stack = Contentstack.stack(apiKey: API_KEY, deliveryToken: DELIVERY_TOKEN, environment: ENVIRONMENT)  

stack.contentType(uid: contentTypeUID)
     .entry(uid: entryUID)
     .include(.embeddedItems)  
     .fetch { (result: Result<EntryModel, Error>, response: ResponseType) in  
        switch result {  
            case .success(let model):
                ContentstackUtils.render(content: model.richTextContent, Option(entry: model))  
            case .failure(let error):  
                //Error Message  
        }  
    }
```

#### Render Supercharged RTE contents
To get a single entry, you need to provide the stack API key, environment name, delivery token, content type and entry UID. Then, use `ContentstackUtils.jsonToHtml` function as shown below:
```swift
import ContentstackUtils  

let stack:Stack = Contentstack.stack(apiKey: API_KEY, deliveryToken: DELIVERY_TOKEN, environment: ENVIRONMENT)  

stack.contentType(uid: contentTypeUID)
     .entry(uid: entryUID)
     .include(.embeddedItems)  
     .fetch { (result: Result<EntryModel, Error>, response: ResponseType) in  
        switch result {  
            case .success(let model):
                ContentstackUtils.jsonToHtml(content: model.richTextContent, Option(entry: model))  
            case .failure(let error):  
                //Error Message  
        }  
    }
```
> Node: Supercharged RTE also supports Embedded items to get all embedded items while fetching entry use `includeEmbeddedItems` function.

### Fetch Embedded Item(s) from Multiple Entries
#### Render HTML RTE Embedded object
To get embedded items from multiple entries, you need to provide the stack API key, environment name, delivery token, and content type UID. Then, use the `ContentstackUtils.render` functions as shown below:
```
import ContentstackUtils  

let stack = Contentstack.stack(apiKey: apiKey,  
deliveryToken: deliveryToken,  
environment: environment)  
  
stack.contentType(uid: contentTypeUID)
     .entry()
     .query()
     .include(.embeddedItems)
     .find { (result: Result<ContentstackResponse<EntryModel>, Error>, response: ResponseType) in  
        switch result {  
            case .success(let contentstackResponse):  
                for item in contentstackResponse.items {  
                    ContentstackUtils.render(content: item.richTextContent, CustomRenderOption(entry: item))  
                }  
            case .failure(let error):  
                //Error Message  
        }  
    }
```

#### Render Supercharged RTE contents
To get a Multiple entry, you need to provide the stack API key, environment name, delivery token, and content type UID. Then, use `Contentstack.Utils.jsonToHtml` function as shown below:
```swift
import ContentstackUtils  

let stack:Stack = Contentstack.stack(apiKey: API_KEY, deliveryToken: DELIVERY_TOKEN, environment: ENVIRONMENT)  

stack.contentType(uid: contentTypeUID)
     .entry()
     .query()
     .include(.embeddedItems)
     .find { (result: Result<EntryModel, Error>, response: ResponseType) in  
        switch result {  
            case .success(let model):
                for item in contentstackResponse.items {  
                    ContentstackUtils.jsonToHtml(content: item.richTextContent, CustomRenderOption(entry: item))  
                }
            case .failure(let error):  
                //Error Message  
        }  
    }
```

### GraphQL implementation
After fetching the entries from the content type pass the JSON RTE to `ContentstackUtils.GQL.jsonToHtml` function as shown below:

```swift
import ContentstackUtils  
import Apollo
...
let graphQLClient: ApolloClient
...

graphQLClient.fetch (query: ProductsQuery(), cachePolicy: CachePolicy.fetchIgnoringCacheData, queue: DispatchQueue.main) {[weak self] (result: Result<GraphQLResult<ProductsQuery.Data>, Error>) in
    guard let slf = self else {
                   return
               }
    switch result {
    case .success(let graphQLResult):
        guard let data = graphQLResult.data, let products = data.allAbcd?.items else {
           return
        }

        for product in products {
            if let rte = product.superchargedRte {
               let result = try? ContentstackUtils.GQL.jsonToHtml(rte: rte.resultMap)
            }
        }
    case .failure(let error):
      print("Failure! Error: \(error)")
    }
}
```

