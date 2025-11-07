// swift-tools-version: 6.2

/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SwiftUIFlow",
    platforms: [
        .iOS(.v14),
        .macCatalyst(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftUIFlow",
            targets: ["SwiftUIFlow"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIFlow",
            dependencies: []
        )
    ]
)
