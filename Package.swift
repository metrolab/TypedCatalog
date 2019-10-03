// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "TypedCatalog",
    dependencies: [],
    targets: [
        .target(
            name: "TypedCatalog",
            dependencies: []),
        .testTarget(
            name: "TypedCatalogTests",
            dependencies: ["TypedCatalog"]),
    ]
)
