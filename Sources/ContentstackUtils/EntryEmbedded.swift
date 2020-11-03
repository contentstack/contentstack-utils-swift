public protocol EmbeddedObject: class {
/// The `unique identifier` of the entity.
    var uid: String { get }
}

public protocol EmbeddedContentTypeUid: EmbeddedObject {
    /// The content type uid for `Entry`.
    static var contentTypeUid: String { get }
}

public protocol EmbeddedEntry: EmbeddedObject {
    var title: String { get }
}

/// The Protocol for creating Asset model.
public protocol EmbeddedAsset: EmbeddedObject {
    /// The title of the entity.
    var title: String { get }
    /// The `file name` of the Asset.
    var filename: String { get }
    /// The url for the Asset.
    var url: String { get }
}

public protocol EntryEmbedable {
    var embeddedEntries: [AnyHashable: [EmbeddedContentTypeUid]]? { get }
    var embeddedAssets: [AnyHashable: [EmbeddedAsset]]? { get }
}
