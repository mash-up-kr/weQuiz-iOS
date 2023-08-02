//
//  DynamicLinks.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/02.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

import FirebaseDynamicLinks

public func makeDynamicLink(_ id: Int, completion: @escaping (URL?) -> Void) {
    guard let link = URL(string: "https://wequiz.page.link?quizId=\(id)") else {
        return
    }
    let dynamicLinksDomainURIPrefix = "https://wequiz.page.link"
    let builder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
    
    
    builder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "wequiz.ios.Main")
    builder?.androidParameters = DynamicLinkAndroidParameters(packageName: "team.ommaya.wequiz.android")
    
    builder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
    builder?.socialMetaTagParameters?.title = "친구가 만든 찐친고사에 도전해보세요!"

    builder?.shorten(completion: { url, options, error in
        guard let error = error else {
            completion(url)
            return
        }
        print(error)
    })
}
