// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Builder",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "Builder",
            targets: ["Builder"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.0")
    ],
    targets: [
        .target(
            name: "Builder",
            dependencies: [],
            path: "Builder/Classes"
        ),
        .testTarget(
            name: "BuilderTests",
            dependencies: [
                "Builder", "Quick", "Nimble"
            ],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ]
)