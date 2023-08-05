//
//  HomeAPI.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum HomeAPI {
    case getMyInfo
    case getFriendRank(FriendRankRequestModel)
    case getQuizGroup(QuizGroupRequestModel)
    case getQuizDetail(QuizDetailRequestModel)
    case deleteQuiz(QuizDeleteRequestModel)
}

extension HomeAPI: NetworkRequestable {
    public var path: String {
        switch self {
        case .getMyInfo:
            return "/api/v1/user"
        case .getFriendRank:
            return "/api/v1/ranking/my-quiz"
        case .getQuizGroup(_):
            return "/api/v1/quiz"
        case .getQuizDetail(let model):
            return "/api/v1/statistic/quiz/\(model.quizId)"
        case .deleteQuiz(let model):
            return "/api/v1/quiz/\(model.quizId)"
        }
    }

    public var method: NetworkMethod {
        switch self {
        case .getMyInfo:
            return .get
        case .getFriendRank:
            return .get
        case .getQuizGroup(_):
            return .get
        case .getQuizDetail(_):
            return .get
        case .deleteQuiz(_):
            return .delete
        }
    }
    
    public var parameters: Encodable? {
        switch self {
        case .getMyInfo:
            return nil
        case .getFriendRank(let model):
            return model
        case .getQuizGroup(let model):
            return model
        case .getQuizDetail(let model):
            return model
        case .deleteQuiz(let model):
            return model
        }
    }
    
    public var encoding: NetworkParameterEncoding {
        switch self {
        case .getMyInfo:
            return .urlEncoding
        case .getFriendRank(_):
            return .urlEncoding
        case .getQuizGroup(_):
            return .urlEncoding
        case .getQuizDetail(_):
            return .urlEncoding
        case .deleteQuiz(_):
            return .urlEncoding
        }
    }
}
