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
    
    // input
    
    
    // output
    @Published var questions: [SummaryQuestionModel] = []
    @Published var friendsRank: [FriendModel] = []
    @Published var myInfo: MyInfoModel = MyInfoModel(id: 0, image: "", nickname: "", contents: "")
    @Published var detailQuizInfo: QuizInfoModel = QuizInfoModel(quizId: 0, quizTitle: "", questions: [])
    @Published var detailQuizStatistic: [QuestionStatisticModel] = []
    
    private var myInfoGroup = CurrentValueSubject<MyInfoModel, Never>(myInfoSamlple)
    private var friendRankGroup = CurrentValueSubject<FriendRankGroupModel, Never>(friendsRankSample)
    private var questionGroup = CurrentValueSubject<QuestionGroupModel, Never>(questionSample)
    private var questionDetailGroup = CurrentValueSubject<QuestionDetailModel, Never>(questionDetailSample)
    private var cancellables = Set<AnyCancellable>()
    
    
    private let service: HomeService
    
    
    public init(service: HomeService) {
        
        self.service = service
        
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
                self.detailQuizInfo = $0.quizInfo
                self.detailQuizStatistic = $0.statistic
            }
            .store(in: &cancellables)
        
        self.getMyInfo()
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
    
    
    
    
    //    func getMovieList(movieOrderType: Int, completion: @escaping () -> Void) {
    //        self.service.getMovieList(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType))) { result in
    //            guard let result = result else { return }
    //            self.movieList = result.movies
    //            completion()
    //        }
    //    }
    
    //    func testGetMovieList(movieOrderType: Int) {
    //        self.service.getMovieListCB(MovieList.self, MovieAPI.getMovieList(GetMovieListRequest(orderType: movieOrderType)))
    //            .map { $0.movies }
    //            .assign(to: \.movies, on: self.testMovieList)
    //            .store(in: &cancellables)
    //    }
}
