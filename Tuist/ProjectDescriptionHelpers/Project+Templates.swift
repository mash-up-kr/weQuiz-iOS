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
    private static func makeFrameworkTargets(name: String, platform: Platform = .iOS) -> [Target] {
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
    
    private static func makeFrameworkTargets(
        name: String,
        platform: Platform = .iOS,
        additionalDependencies: [TargetDependency]
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: additionalDependencies
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
    private static func makeAppTargets(name: String, platform: Platform = .iOS, dependencies: [TargetDependency]) -> [Target] {
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

// MARK: - DesignSystem

extension Project {
    public static func designSystem(name: String, additionalTargets: [String]) -> Project {
        var targets = makeDesignSystemAppTargets(
            name: name,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
        )
        targets += additionalTargets.flatMap({
            makeDesignSystemFrameworkTargets(
                name: $0,
                needResource: $0.contains("Kit")
            )
        })
        return Project(name: name,
                       organizationName: "ommaya.io",
                       targets: targets)
    }
    
    // MARK: - Private
    
    private static func makeDesignSystemFrameworkTargets(
        name: String,
        needResource: Bool = false
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: .iOS,
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
            platform: .iOS,
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
    
    private static func makeDesignSystemAppTargets(name: String, dependencies: [TargetDependency]) -> [Target] {
        let mainTarget = Target(
            name: name,
            platform: .iOS,
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
            platform: .iOS,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ]
        )
        return [mainTarget, testTarget]
    }
}


// MARK: - Core

extension Project {
    public static func core() -> Project {
        return Project(
            name: "Core",
            organizationName: "ommaya.io",
            targets: [
                Target(
                    name: "CoreKit",
                    platform: .iOS,
                    product: .framework,
                    bundleId: "wequiz.ios.Core",
                    deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
                    infoPlist: "Targets/CoreKit/SupportingFiles/Core-info.plist",
                    sources: ["Targets/CoreKit/Sources/**"],
                    resources: [],
                    dependencies: [
                        .external(name: "Alamofire")
                    ]
                )
            ]
        )
    }
}

// MARK: - Main

extension Project {
    public static func main(name: String) -> Project {
        var targets = makeMainAppTargets(
            name: name,
            dependencies: [
                TargetDependency.target(name: "MainKit"),
                TargetDependency.target(name: "MainUI")
            ]
        )
        targets.append(makeMainKitFrameworkTarget())
        targets.append(makeMainUIFrameworkTarget())
        return Project(
            name: name,
            organizationName: "ommaya.io",
            targets: targets
        )
    }
    
    private static func makeMainKitFrameworkTarget() -> Target {
        Target(
            name: "MainKit",
            platform: .iOS,
            product: .framework,
            bundleId: "wequiz.ios.MainKit",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            sources: ["Targets/MainKit/Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "HomeKit", path: .relativeToRoot("Projects/Home")),
                .project(target: "QuizKit", path: .relativeToRoot("Projects/Quiz")),
                .project(target: "CoreKit", path: .relativeToRoot("Projects/Core")),
                .project(target: "AuthenticationKit", path: .relativeToRoot("Projects/Authentication")),
            ]
        )
    }
    
    private static func makeMainUIFrameworkTarget() -> Target {
        Target(
            name: "MainUI",
            platform: .iOS,
            product: .framework,
            bundleId: "wequiz.ios.MainUI",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            sources: ["Targets/MainUI/Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "DesignSystemKit", path: .relativeToRoot("Projects/DesignSystem")),
                .project(target: "MainKit", path: .relativeToRoot("Projects/Main")),
                .project(target: "HomeUI", path: .relativeToRoot("Projects/Home")),
                .project(target: "QuizUI", path: .relativeToRoot("Projects/Quiz")),
                .project(target: "AuthenticationUI", path: .relativeToRoot("Projects/Authentication")),
                
            ]
        )
    }
    
    private static func makeMainAppTargets(name: String, dependencies: [TargetDependency]) -> [Target] {
        let mainTarget = Target(
            name: name,
            platform: .iOS,
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
            platform: .iOS,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ]
        )
        return [mainTarget, testTarget]
    }
}

// MARK: - Authentication

extension Project {
    public static func authetication(name: String) -> Project {
        var targets: [Target] = makeAuthenticationAppTarget(name: name)
        let authenticationKitTarget = makeFrameworkTargets(
            name: "AuthenticationKit",
            additionalDependencies: [
                .project(target: "DesignSystemKit", path: .relativeToRoot("Projects/DesignSystem")),
                .project(target: "CoreKit", path: .relativeToRoot("Projects/Core")),
                .external(name: "FirebaseAuth")
            ]
        )
        let authenticationUITarget = makeFrameworkTargets(
            name: "AuthenticationUI",
            additionalDependencies: []
        )
        targets.append(contentsOf: authenticationKitTarget)
        targets.append(contentsOf: authenticationUITarget)
        return Project(
            name: "Authetication",
            organizationName: "ommaya.io",
            targets: targets
        )
    }
    
    private static func makeAuthenticationAppTarget(name: String) -> [Target] {
        let main = Target(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: "wequiz.ios.\(name)",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)-info.plist",
            sources: [
                "Targets/\(name)/Sources/**"
            ],
            resources: [
                "Targets/\(name)/Resources/**",
                "Targets/\(name)/SupportingFiles/GoogleService-Info.plist"
            ],
            dependencies: [
                TargetDependency.target(name: "AuthenticationKit"),
                TargetDependency.target(name: "AuthenticationUI")
            ]
        )
        let tests =  Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "wequiz.ios.\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: "Targets/\(name)/SupportingFiles/\(name)Tests-info.plist",
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        
        return [
            main, tests
        ]
    }
}
