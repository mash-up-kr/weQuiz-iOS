//
//  HomeViewModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import SwiftUI
import HomeKit

public class HomeViewModel: ObservableObject {
    
    // output
    @Published var questions: [SummaryQuestionModel] = []
    @Published var friendsRank: [FriendModel] = []
    @Published var myInfo: MyInfoModel = MyInfoModel(id: 0, image: "", nickname: "", contents: "")
    @Published var detailQuizInfo: QuizInfoModel = QuizInfoModel(quizId: 0, quizTitle: "", questions: [])
    @Published var detailQuizStatistic: [QuestionStatisticModel] = []
    @Published var detailQuiz: QuestionDetailModel = QuestionDetailModel(quizInfo: QuizInfoModel(quizId: 0, quizTitle: "", questions: []), statistic: [])

    // input
    private var myInfoGroup = PassthroughSubject<MyInfoModel, Never>()
    private var friendRankGroup = PassthroughSubject<FriendRankGroupModel, Never>()
    private var questionGroup = PassthroughSubject<QuestionGroupModel, Never>()
    private var questionDetailGroup = PassthroughSubject<QuestionDetailModel, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let service: HomeService
    
    
    public init(service: HomeService) {
        
        self.service = service

        
        myInfoGroup
            .sink {
                self.myInfo = $0
            }
            .store(in: &cancellables)
        
        friendRankGroup
            .sink {
                self.friendsRank = $0.rankings
            }
            .store(in: &cancellables)
        
        questionGroup
            .sink {
                self.questions = $0.quiz
            }
            .store(in: &cancellables)

        questionDetailGroup
            .sink {
                self.detailQuizInfo = $0.quizInfo
                self.detailQuizStatistic = $0.statistic
                self.detailQuiz = $0
            }
            .store(in: &cancellables)
        
        self.getMyInfo()
        self.getFriendRank(FriendRankRequestModel(size: 10, quizAnswerCursorId: nil))
        self.getQuestionGroup(QuestionGroupRequestModel(size: 100, cursor: nil))
    }

    
    func getMyInfo() {
        self.service.getMyInfo(MyInfoModel.self, HomeAPI.getMyInfo)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.myInfoGroup.send(value)
            })
            .store(in: &cancellables)
    }
    
    func getFriendRank(_ request: FriendRankRequestModel) {
        self.service.getFriendRank(FriendRankGroupModel.self, HomeAPI.getFriendRank(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.friendRankGroup.send(value)
            })
            .store(in: &cancellables)
    }
    
    func getQuestionGroup(_ request: QuestionGroupRequestModel) {
        self.service.getQuestionGroup(QuestionGroupModel.self, HomeAPI.getQuestionGroup(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.questionGroup.send(value)
            })
            .store(in: &cancellables)
    }
    
    func getQuestionStatistic(_ request: QuestionStatisticRequestModel) {
        self.service.getQuestionDetail(QuestionDetailModel.self, HomeAPI.getQuestionStatistic(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.questionDetailGroup.send(value)
            })
            .store(in: &cancellables)
    }
    
    func deleteQuestion(_ request: QuestionDeleteRequestModel) {
        self.service.deleteQuestion(QuestionDetailModel.self, HomeAPI.deleteQuestion(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.questionDetailGroup.send(value)
            })
            .store(in: &cancellables)
    }
}
