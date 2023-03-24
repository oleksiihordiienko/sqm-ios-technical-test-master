// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let quoteFlowDependencies: [PackageDescription.Target.Dependency] = [
    "Models",
    "Utils",
    "Resources",
    "Environment",
    "QuoteFlowDataManager",
]

let package = Package(
    name: "sqm-ios-technical-test-master",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Models", targets: ["Models"]),
        .library(name: "Utils", targets: ["Utils"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "Store", targets: ["Store"]),
        .library(name: "Environment", targets: ["Environment"]),
        .library(name: "API", targets: ["API"]),
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "AppFlow", targets: ["AppFlow"]),
        .library(name: "QuoteFlowUIKit", targets: ["QuoteFlowUIKit"]),
        .library(name: "QuoteFlowSwiftUI", targets: ["QuoteFlowSwiftUI"]),
        .library(name: "QuoteFlowDataManager", targets: ["QuoteFlowDataManager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMinor(from: "1.0.2" )),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMinor(from: "0.52.0")),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators", .upToNextMinor(from: "0.4.0")),
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
        .target(name: "AppFlow", dependencies: ["QuoteFlowUIKit"]),
        .target(
            name: "QuoteFlowDataManager",
            dependencies: ["Models", "Utils", "Environment", "API"],
            path: "Sources/QuoteFlow/DataManager",
            resources: [.process("Stubs")]
        ),
        .target(
            name: "QuoteFlowUIKit",
            dependencies: [
                "Store",
                .product(name: "Collections", package: "swift-collections"),
            ] + quoteFlowDependencies,
            path: "Sources/QuoteFlow/UIKit"
        ),
        .testTarget(name: "QuoteFlowUIKitTests", dependencies: ["QuoteFlowUIKit"]),
        .target(
            name: "QuoteFlowSwiftUI",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCACoordinators", package: "TCACoordinators"),
            ] + quoteFlowDependencies,
            path: "Sources/QuoteFlow/SwiftUI"
        ),
    ]
)
