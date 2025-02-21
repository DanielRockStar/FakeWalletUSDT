// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "FakeWalletUSDT",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FakeWalletUSDT",
            targets: ["FakeWalletUSDT"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FakeWalletUSDT",
            dependencies: []
        )
    ]
)
