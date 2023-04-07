import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMinor(from: "0.50.0")),
        .remote(url: "https://github.com/rive-app/rive-ios", requirement: .upToNextMinor(from: "3.1.8"))
    ],
    platforms: [.iOS]
)
