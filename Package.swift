// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sqm-ios-technical-test-master",
    platforms: [.iOS("14.4")],
    products: [
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Utils", targets: ["Utils"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "Store", targets: ["Store"]),
        .library(name: "Environment", targets: ["Environment"]),
        .library(name: "API", targets: ["API"]),
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "AppFlow", targets: ["AppFlow"]),
        .library(name: "QuoteFlow", targets: ["QuoteFlow"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMinor(from: "1.0.2")
        )
    ],
    targets: [
        .target(name: "Models", dependencies: ["Resources"]),
        .target(name: "Utils"),
        .target(
            name: "Resources",
            resources: [.process("Localization"), .process("Assets")]
        ),
        .target(name: "Store", dependencies: ["Utils"]),
        .target(name: "Environment", dependencies: ["Utils", "Models"]),
        .target(name: "APIClient", dependencies: ["Environment", "Utils"]),
        .target(name: "API", dependencies: ["APIClient", "Models", "Utils"]),
        .target(name: "AppFlow", dependencies: ["QuoteFlow"]),
        .target(
            name: "QuoteFlow",
            dependencies: [
                "Models",
                "Utils",
                "Resources",
                "Environment",
                "API",
                "Store",
                .product(name: "Collections", package: "swift-collections"),
            ],
            resources: [.process("Stubs")]
        ),
        .testTarget(name: "QuoteFlowTests", dependencies: ["QuoteFlow"]),
    ]
)
