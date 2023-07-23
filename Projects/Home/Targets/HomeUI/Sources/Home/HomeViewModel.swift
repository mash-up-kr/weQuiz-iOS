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
    
    @Published var questions: [SummaryQuestionModel] = []
    @Published var friendsRank: [FriendModel] = []
    @Published var myInfo: MyInfoModel = MyInfoModel(id: 0, image: "", nickname: "", contents: "")
    @Published var detailQuestions: [QuestionModel] = []
    
    private var questionGroup = CurrentValueSubject<QuestionGroupModel, Never>(questionSample)
    private var friendRankGroup = CurrentValueSubject<FriendRankGroupModel, Never>(friendsRankSample)
    private var myInfoGroup = CurrentValueSubject<MyInfoModel, Never>(myInfoSamlple)
    private var questionDetailGroup = CurrentValueSubject<QuestionDetailModel, Never>(questionDetailSample)
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        
        questionGroup
            .sink {
                self.questions = $0.quiz
            }
            .store(in: &cancellables)
        
        friendRankGroup
            .sink {
                self.friendsRank = $0.rankings
            }
            .store(in: &cancellables)
        
        myInfoGroup
            .sink {
                self.myInfo = $0
            }
            .store(in: &cancellables)
        
        questionDetailGroup
            .sink {
                self.detailQuestions = $0.questions
            }
            .store(in: &cancellables)
    }
}
