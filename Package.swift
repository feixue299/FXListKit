// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FXListKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "FXListKit",
            targets: ["FXListKit"]),
        .library(
            name: "FXListKitAnimation",
            targets: ["FXListKitAnimation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ra1028/DifferenceKit.git", from: "1.1.5")
    ],
    targets: [
        .target(name: "FXListKitInternal",
                path: "Sources/FXListKit/internal",
                publicHeadersPath: "."),
        .target(
            name: "FXListKit",
            dependencies: ["FXListKitInternal"],
            sources: ["Core", "Bridge", "Utilities"]
        ),
        .target(
            name: "FXListKitAnimation",
            dependencies: ["FXListKit", "DifferenceKit"]),
    ]
)
