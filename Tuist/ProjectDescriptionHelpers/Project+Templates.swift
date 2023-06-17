import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        var targets = makeAppTargets(
            name: name,
            platform: platform,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
        )
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, platform: platform) })
        return Project(name: name,
                       organizationName: "ommaya.io",
                       targets: targets)
    }
    
    // MARK: - Private
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "DesignSystemKit", path: .relativeToRoot("Projects/DesignSystem"))
            ]
        )
        let tests = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        )
        return [sources, tests]
    }
    
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func designSystem(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        var targets = makeDesignSystemAppTargets(
            name: name,
            platform: platform,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
        )
        targets += additionalTargets.flatMap({
            makeDesignSystemFrameworkTargets(
                name: $0,
                platform: platform,
                needResource: $0.contains("Kit")
            )
        })
        return Project(name: name,
                       organizationName: "ommaya.io",
                       targets: targets)
    }
    
    // MARK: - Private
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeDesignSystemFrameworkTargets(
        name: String,
        platform: Platform,
        needResource: Bool = false
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: ["Targets/\(name)/Sources/**"],
            resources: needResource ? ["Targets/\(name)/Resources/**"] : [],
            dependencies: needResource == false ? [.project(target: "DesignSystemKit", path: .relativeToRoot("Projects/DesignSystem"))] : []
        )
        let tests = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        )
        return [sources, tests]
    }
    
    /// Helper function to create the application target and the unit test target.
    private static func makeDesignSystemAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}

