//
//  QuizDetailDataStore.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

final class QuizDetailDataStore: ObservableObject {
    @Published var quizInfo: QuizDetailViewModel
    
    public init(quizInfo: QuizDetailViewModel) {
        self.quizInfo = quizInfo
    }
}
