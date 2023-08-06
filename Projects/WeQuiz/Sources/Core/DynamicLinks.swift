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
        
        var metaTagTitle: String {
            "진정한 친구들만 통과할 수 있는 찐친고사"
        }
        
        var metaTagDescription: String {
            "너 나 알아? WeQuiz 우정테스트"
        }
        
        var metaTagImageURL: URL? {
            URL(string:"""
                https://firebasestorage.googleapis.com/v0/b/wequiz-3910f.appspot.com/o/metaTagImage.png?alt=media&token=22389993-44e2-4ffa-adce-0a8f369d0173
                """)
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
        builder?.socialMetaTagParameters?.title = type.metaTagTitle
        builder?.socialMetaTagParameters?.descriptionText = type.metaTagDescription
        builder?.socialMetaTagParameters?.imageURL = type.metaTagImageURL
        
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
