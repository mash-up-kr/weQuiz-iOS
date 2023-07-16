//
//  HomeViewModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import SwiftUI


public class HomeViewModel: ObservableObject {
    @Published var questionGroups: [QuestionGroup]
    @Published var friendsRank: [Friend]
    @Published var profile: Profile
    @Published var explainContents: Explain
    
    public init() {
        self.questionGroups = questionsSamlple
        self.friendsRank = friendsRankSample
        self.profile = profileSamlple
        self.explainContents = explainSample
    }
}
