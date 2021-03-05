// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTableView",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(name: "SwiftTableView", targets: ["SwiftTableView"])
    ],
    dependencies: [
        .package(name: "SequenceBuilder", url: "https://github.com/andtie/SequenceBuilder", from: "0.0.3" )
    ],
    targets: [
        .target(name: "SwiftTableView", dependencies: ["SequenceBuilder"])
    ]
)
