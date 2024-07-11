// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "PJSIPLibrary",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "PJSIPLibrary",
            targets: ["PJSIPLibrary"]
        ),
    ],
    targets: [
        .systemLibrary(
            name: "CPJSIP",
            pkgConfig: "libpjproject",
            providers: [
                .brew(["pjproject"]),
                .apt(["libpjproject-dev"])
            ]
        ),
        .target(
            name: "PJSIPLibrary",
            dependencies: ["Pjsua2"]
        ),
        .target(
            name: "Pjsua2",
            dependencies: ["CPJSIP"],
            path: "Sources/Pjsua2",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjsip/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjlib/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjlib-util/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjmedia/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjnath/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/third_party/include"),
                .headerSearchPath("../LibraryFile/Libraries"),
                .define("PJ_AUTOCONF=1", to: "GCC_PREPROCESSOR_DEFINITIONS"),
            ],
            cxxSettings: [
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjsip/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjlib/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjlib-util/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjmedia/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/pjnath/include"),
                .headerSearchPath("../LibraryFile/PjsipLibrary/third_party/include"),
                .headerSearchPath("../LibraryFile/Libraries"),
                .define("PJ_AUTOCONF=1", to: "GCC_PREPROCESSOR_DEFINITIONS"),
            ]
        ),
        .testTarget(
            name: "PJSIPLibraryTests",
            dependencies: ["PJSIPLibrary"]
        )
    ]
)
