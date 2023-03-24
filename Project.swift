import ProjectDescription

// MARK: - Project Creation

private struct ProjectConfiguration {
    let appName: String
    let organizationName: String
    
    init(appName: String, organizationName: String) {
        self.appName = appName
        self.organizationName = organizationName
    }
}

private let projectConfig = ProjectConfiguration(
    appName: "TuistApp",
    organizationName: "com.prometheus"
)

let project = Project(
    name: projectConfig.appName,
    organizationName: projectConfig.organizationName,
    targets: makeTargets()
)

// MARK: - Targets

private func makeTargets() -> [Target] {
    var targets: [Target] = []
    
    targets.append(Target(
        name: "PModels",
        platform: .iOS,
        product: .framework,
        bundleId: projectConfig.organizationName+".GameList.PModels",
        infoPlist: .default,
        sources: ["Frameworks/PModels/Sources/**"]
    ))
    
    targets.append(Target(
        name: "PNetwork",
        platform: .iOS,
        product: .framework,
        bundleId: projectConfig.organizationName+".GameList.PNetwork",
        infoPlist: .default,
        sources: ["Frameworks/PNetwork/Sources/**"],
        dependencies: [
            .target(name: "PModels"),
            .external(name: "Dependencies")
        ]
    ))
    
    targets.append(Target(
        name: "GameList",
        platform: .iOS,
        product: .app,
        bundleId: projectConfig.organizationName+".GameList",
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: [
            .target(name: "PModels"),
            .target(name: "PNetwork"),
            .external(name: "ComposableArchitecture")
        ]
    ))
    
    return targets
}
