// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PJSIPLibrary",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PJSIPLibrary",
            targets: ["PJSIPLibrary"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
                name: "Pjsua2",
                path: "Sources/Pjsua2",
                publicHeadersPath: "include"
        ),
        .target(
            name: "PJSIPLibrary",
            dependencies: ["Pjsua2"]
        ),
        .testTarget(
            name: "PJSIPLibraryTests",
            dependencies: ["PJSIPLibrary"]),
        
        
    ]
)
