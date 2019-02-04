// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PolarisUIKit",
    products: [
        .library(name: "PolarisUIKit",  targets: ["PolarisUIKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "PolarisUIKit", path: "Sources")
    ]
)
