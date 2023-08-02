//
//  DynamicLinks.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/02.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

import FirebaseDynamicLinks

enum DynamicLinkType {
    case solve(id: Int)
    case result(id: Int)
    
    var deepLinkString: String {
        let base = "https://wequiz.page.link"
        switch self {
        case .solve(let id): return "\(base)/solve/quizId=\(id)"
        case .result(let id): return "\(base)/result/quizId=\(id)"
        }
    }
    
    var metaTagtitle: String {
        switch self {
        case .solve: return "친구가 만든 찐친고사에 도전해보세요!"
        case .result: return "찐친고사 결과를 확인해보세요!"
        }
    }
}

func makeDynamicLink(type: DynamicLinkType, completion: @escaping (URL?) -> Void) {
    guard let link = URL(string: type.deepLinkString) else { return }
    
    let dynamicLinksDomainURIPrefix = "https://wequiz.page.link"
    let builder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
    
    builder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "wequiz.ios.Main")
    builder?.androidParameters = DynamicLinkAndroidParameters(packageName: "team.ommaya.wequiz.android")
    
    builder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
    builder?.socialMetaTagParameters?.title = type.metaTagtitle

    builder?.shorten(completion: { url, options, error in
        guard let error = error else {
            completion(url)
            return
        }
    })
}
