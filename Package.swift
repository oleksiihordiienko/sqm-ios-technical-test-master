// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sqm-ios-technical-test-master",
    platforms: [.iOS("14.4")],
    products: [
        .library(name: "Models", targets: ["Models"]),
        .library(name: "DataManager", targets: ["DataManager"]),
        .library(name: "Utils", targets: ["Utils"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "Store", targets: ["Store"]),
        .library(name: "AppFlow", targets: ["AppFlow"]),
        .library(name: "QuoteFlow", targets: ["QuoteFlow"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Models"),
        .target(name: "DataManager"),
        .target(name: "Utils"),
        .target(
            name: "Resources",
            resources: [.process("Localization"), .process("Assets")]
        ),
        .target(name: "Store", dependencies: ["Utils"]),
        .target(name: "AppFlow", dependencies: ["QuoteFlow"]),
        .target(name: "QuoteFlow", dependencies: ["Models", "DataManager", "Utils", "Resources"]),
    ]
)
