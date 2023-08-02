//
//  Dependencies.swift
//  Config
//
//  Created by AhnSangHoon on 2022/06/22.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(swiftPackageManager: SwiftPackageManagerDependencies.dependencies,
                                platforms: [.iOS])

extension SwiftPackageManagerDependencies {
    public static var dependencies: SwiftPackageManagerDependencies {
        .init([
            .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .exact("5.6.1")),
            .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .exact("10.12.0"))
        ])
    }
}
