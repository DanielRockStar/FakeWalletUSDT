// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "FakeWalletUSDT",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .executable(name: "FakeWalletUSDT", targets: ["FakeWalletUSDT"]),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "FakeWalletUSDT",
            dependencies: []
        ),
    ]
)

