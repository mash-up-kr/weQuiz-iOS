//
//  QuestionViewModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/15.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import Combine

import CoreKit

public class MakeQuizViewModel: ObservableObject {
    @Published public var quiz: MakeQuizModel
    
    public init() {
        self.quiz = .init()
    }
    
    public func toggleExpand(_ index: UUID) {
        for i in 0..<quiz.questions.count {
            if quiz.questions[i].id == index { continue }
            quiz.questions[i].isExpand = false
        }
    }
}

public class MakeQuizInteractor {
    private var makeQuizGroup = PassthroughSubject<MakeQuizResponseModel, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    public init(service: QuizService) {
        self.service = service
        
        makeQuizGroup
            .sink(receiveValue: { val in
                print("val : \(val)")
            })
            .store(in: &cancellables)
    }
    
    public func makeQuiz() {
        let requestModel = MakeQuizRequestModel(title: "테스트시험지", questions: [.init(title: "내가 좋아하는 색깔은", priority: 0, duplicatedOption: false, options: [.init(content: "노란색", priority: 0, isCorrect: true)])])
        
        self.service.makeQuiz(MakeQuizResponseModel.self, QuizAPI.makeQuiz(requestModel))
            .sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("finished:")
                }
            }, receiveValue: { value in
                guard let value = value else { return }
                print("value ::: \(value)")
                self.makeQuizGroup.send(value)
            })
        .store(in: &cancellables)
    }
}
