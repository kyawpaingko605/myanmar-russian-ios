// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MyanmarRussianLearner",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        // No external dependencies - using native iOS frameworks
    ],
    targets: [
        .executableTarget(
            name: "MyanmarRussianLearner",
            dependencies: [],
            path: "Sources"
        )
    ]
)
