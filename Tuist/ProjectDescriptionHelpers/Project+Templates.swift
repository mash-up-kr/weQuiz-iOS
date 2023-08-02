import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        return Project(
            name: name,
            organizationName: "wequiz.io",
            packages: [
                .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .exact("5.6.1")),
                .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .exact("10.12.0"))
            ],
            targets: makeAppTargets(
                name: name,
                platform: .iOS,
                dependencies: [
                    .project(target: "DesignSystemKit", path: .relativeToRoot("Projects/DesignSystem")),
                    .package(product: "Alamofire"),
                    .package(product: "FirebaseAuth"),
                    .package(product: "FirebaseDynamicLinks"),
                    .package(product: "FirebaseAnalytics"),
                    .package(product: "FirebaseCrashlytics")
                ]
            )
        )
    }

    // MARK: - Private

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "wequiz.ios.\(name)",
            infoPlist: .file(path: "SupportingFiles/\(name)-Info.plist"),
            sources: ["Sources/**"],
            resources: [
                "Resources/**",
                "SupportingFiles/GoogleService-Info.plist"
            ],
            entitlements: "\(name).entitlements",
            dependencies: dependencies
        )
        return [mainTarget, ]
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
        return Project(
            name: name,
            organizationName: "ommaya.io",
            targets: targets
        )
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
        return [sources]
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
        return [mainTarget]
    }
}

