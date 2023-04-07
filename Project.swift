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
    options: .options(
        textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2, wrapsLines: true)
    ),
    targets: makeTargets(),
    resourceSynthesizers: [
        .assets(),
        .custom(
            name: "Rive",
            parser: .json,
            extensions: ["rivDesc"]
        )
    ]
)



// MARK: - Targets

private func makeTargets() -> [Target] {
    var targets: [Target] = []
    
    var launchScreenPlist: [String: InfoPlist.Value] {
        var additionalPlistValues = [String: InfoPlist.Value]()
        additionalPlistValues["UILaunchStoryboardName"] = .string("LaunchScreen")
        additionalPlistValues["UIUserInterfaceStyle"] = .string("Light")
        
        return additionalPlistValues
    }
    
    targets.append(Target(
        name: "PModels",
        platform: .iOS,
        product: .framework,
        bundleId: projectConfig.organizationName+".GameList.PModels",
        infoPlist: .default,
        sources: ["Frameworks/PModels/Sources/**"]
    ))
    
    targets.append(Target(
        name: "PResources",
        platform: .iOS,
        product: .framework,
        bundleId: projectConfig.organizationName+".GameList.PResources",
        infoPlist: .default,
        sources: ["Frameworks/PResources/Sources/**"],
        resources: ["Frameworks/PResources/Resources/**"],
        dependencies: [
            .target(name: "PModels"),
            .external(name: "RiveRuntime")
        ]
    ))
    
    targets.append(Target(
        name: "PCache",
        platform: .iOS,
        product: .framework,
        bundleId: projectConfig.organizationName+".GameList.PCache",
        infoPlist: .default,
        sources: ["Frameworks/PCache/Sources/**"],
        dependencies: [
            .target(name: "PResources"),
            .external(name: "Dependencies")
        ]
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
            .target(name: "PResources"),
            .external(name: "Dependencies")
        ]
    ))
    
    targets.append(Target(
        name: "GameList",
        platform: .iOS,
        product: .app,
        bundleId: projectConfig.organizationName+".GameList",
        infoPlist: .extendingDefault(with: launchScreenPlist),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: [
            .target(name: "PModels"),
            .target(name: "PNetwork"),
            .target(name: "PCache"),
            .target(name: "PResources"),
            .external(name: "ComposableArchitecture"),
            .external(name: "RiveRuntime")
        ]
    ))
    
    return targets
}
