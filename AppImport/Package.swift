// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "AppImport",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "AppImport",
            targets: ["AppImport"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ivanvorobei/SPDiffable", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/sparrowcode/SwiftBoost", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/ivanvorobei/NativeUIKit", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/sparrowcode/SPSettingsIcons", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/sparrowcode/SafeSFSymbols", .upToNextMajor(from: "1.1.2")),
        .package(url: "https://github.com/sparrowcode/PermissionsKit", .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/ivanvorobei/SPAlert", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/ivanvorobei/SPIndicator", .upToNextMajor(from: "1.6.4")),
        .package(url: "https://github.com/sparrowcode/SPQRCode", .upToNextMajor(from: "1.0.4")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
        .package(url: "https://github.com/sparrowcode/OTP", .upToNextMajor(from: "1.0.0"))
        
    ],
    targets: [
        .target(
            name: "AppImport",
            dependencies: [
                .product(name: "SPDiffable", package: "SPDiffable"),
                .product(name: "SwiftBoost", package: "SwiftBoost"),
                .product(name: "NativeUIKit", package: "NativeUIKit"),
                .product(name: "SPSettingsIcons", package: "SPSettingsIcons"),
                .product(name: "SafeSFSymbols", package: "SafeSFSymbols"),
                .product(name: "CameraPermission", package: "PermissionsKit"),
                .product(name: "SPAlert", package: "SPAlert"),
                .product(name: "SPIndicator", package: "SPIndicator"),
                .product(name: "SPQRCode", package: "SPQRCode"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
                .product(name: "OTP", package: "OTP")
            ]
        )
    ]
)
