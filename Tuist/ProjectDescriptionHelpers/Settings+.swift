//
//  Settings+.swift
//  ProjectDescriptionHelpers
//
//  Created by AhnSangHoon on 2023/08/04.
//

import ProjectDescription

extension Settings {
    static let project: Settings = .settings(
        base: [
            "EXCLUEDED_ARCHS": "arm64"
        ],
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: "../Configurations/Project-Debug.xcconfig"
            ),
            .release(
                name: "Release",
                xcconfig: "../Configurations/Project-Release.xcconfig"
            )
        ],
        defaultSettings: .none)
    
    static let app: Settings = .settings(
        base: [:],
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: "../Configurations/WeQuiz-Debug.xcconfig"
            ),
            .release(
                name: "Release",
                xcconfig: "../Configurations/WeQuiz-Release.xcconfig"
            )
        ],
        defaultSettings: .none
    )
}
