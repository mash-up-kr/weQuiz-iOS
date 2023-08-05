//
//  DynamicLinks.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/02.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

import FirebaseDynamicLinks

enum DynamicLinks {
    /// DynamicLink 생성 타입
    enum DynamicLinkType {
        case solve(id: Int)
        case result(id: Int)
        
        var deepLinkString: String {
            let base = "https://wequiz.page.link"
            switch self {
            case .solve(let id): return "\(base)/solve?quizId=\(id)"
            case .result(let id): return "\(base)/result?quizId=\(id)"
            }
        }
        
        var metaTagtitle: String {
            switch self {
            case .solve: return "친구가 만든 찐친고사에 도전해보세요!"
            case .result: return "찐친고사 결과를 확인해보세요!"
            }
        }
    }
    
    /// DynamicLink의 앱 화면 진입  Path
    enum DynamicLinkPath: String {
        case solve
        case result
    }
    
    /// DynamicLink를 통해 앱 진입시 랜딩 페이지
    enum DynamicLinkDestination {
        case solve(id: Int)
        case result(id: Int, solverId: String)
    }

    static func makeDynamicLink(type: DynamicLinkType, completion: @escaping (URL?) -> Void) {
        guard let link = URL(string: type.deepLinkString) else {
            debugPrint("DynamicLink DeepLink Error")
            completion(nil)
            return
        }
        
        let dynamicLinksDomainURIPrefix = "https://wequiz.page.link"
        let builder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        builder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "wequiz.ios.Main")
        builder?.androidParameters = DynamicLinkAndroidParameters(packageName: "team.ommaya.wequiz.android")
        
        builder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        builder?.socialMetaTagParameters?.title = type.metaTagtitle
        
        builder?.shorten(completion: { url, options, error in
            if let error = error  {
                debugPrint(error)
                completion(nil)
            } else {
                completion(url)
            }
        })
    }
    
    static func id(from url: URL?) -> DynamicLinkDestination? {
        guard
            let url = url, let dynamicLink = extractLinkFromURL(url),
            let path = DynamicLinkPath(rawValue: dynamicLink.lastPathComponent),
            let components = URLComponents(url: dynamicLink, resolvingAgainstBaseURL: true),
            let values = components.queryItems
        else {
            return nil
        }
        
        switch path {
        case .solve:
            guard
                let idString = values.first?.value,
                let id = Int(idString)
            else {
                return nil
            }
            return .solve(id: id)
        case .result:
            guard
                let idString = values.first?.value,
                let id = Int(idString),
                let solverId = values.last?.value
            else {
                return nil
            }
            return .result(id: Int(id), solverId: solverId)
        }
    }
}

extension DynamicLinks {
    private static func extractLinkFromURL(_ url: URL) -> URL? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            for queryItem in components.queryItems ?? [] {
                if queryItem.name == "link", let linkValue = queryItem.value {
                    return URL(string: linkValue)
                }
            }
        }
        return nil
    }
}
