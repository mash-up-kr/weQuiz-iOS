//
//  SolveQuizPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

protocol SolveQuizPresentationLogic {
    func presentQuizResult(response: SolveQuiz.LoadQuizResult.Response)
}

final class SolveQuizPresenter {
    var view: SolveQuizDisplayLogic?
}

extension SolveQuizPresenter: SolveQuizPresentationLogic {
    func presentQuizResult(response: SolveQuiz.LoadQuizResult.Response) {
        let viewModel = QuizResultModel(
            myScore: response.result.totalScore,
            myNickname: response.result.quizResolver.name,
            friendNickname: response.result.quizCreator.name,
            resultImage: setResultImage(response.result.totalScore),
            scoreDescription: setScoreDescription(response.result.totalScore)
        )
        
        view?.displayQuizResult(viewModel: .init(result: viewModel))
    }
    
    private func setResultImage(_ score: Int) -> String {
        switch score {
        case 90...100:
            return WeQuizAsset.Assets.quizResult05.name
        case 70..<90:
            return WeQuizAsset.Assets.quizResult04.name
        case 50..<70:
            return WeQuizAsset.Assets.quizResult03.name
        case 30..<50:
            return WeQuizAsset.Assets.quizResult02.name
        default:
            return WeQuizAsset.Assets.quizResult01.name
        }
    }
    
    private func setScoreDescription(_ score: Int) -> String {
        switch score {
        case 90...100:
            return "영혼을 공유한 사이 🩷"
        case 70..<90:
            return "찐친 그자체라구!"
        case 50..<70:
            return "우리 정도면 친한편이지?"
        case 30..<50:
            return "그냥 얼굴만 아는 사이..."
        default:
            return "지금 싸우자는 거지?"
        }
    }
}
