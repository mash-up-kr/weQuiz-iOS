//
//  QuizAPI.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum QuizAPI {
    case makeQuiz(MakeQuizRequestModel)
    case getQuiz(Int)
    case quizResult(Int, QuizResultRequestModel)
    case quizResultForAnonymous(Int, QuizResultRequestModel, String)
    case getQuizRank(Int, GetQuizRankRequestModel)
    case anonymous(TemporaryTokenRequestModel)
}

extension QuizAPI: NetworkRequestable {
    public var path: String {
        switch self {
        case .makeQuiz:
            return "/api/v1/quiz"
        case .getQuiz(let quizId):
            return "/api/v1/quiz/\(quizId)"
        case .quizResult(let quizId, _):
            return "/api/v1/quiz/\(quizId)/answers"
        case .quizResultForAnonymous(let quizId, _, _):
            return "/api/v1/quiz/\(quizId)/answers"
        case .getQuizRank(let quizId, _):
            return "/api/v1/ranking/quiz/\(quizId)"
        case .anonymous:
            return "/api/v1/user/join/anonymous"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .makeQuiz:
            return .post
        case .getQuiz:
            return .get
        case .quizResult, .quizResultForAnonymous:
            return .post
        case .getQuizRank:
            return .get
        case .anonymous:
            return .post
        }
    }
    
    public var parameters: Encodable? {
        switch self {
        case .makeQuiz(let model):
            return model
        case .getQuiz:
            return nil
        case .quizResult(_, let model):
            return model
        case .quizResultForAnonymous(_, let model, _):
            return model
        case .getQuizRank(_, let model):
            return model
        case .anonymous(let model):
            return model
        }
    }
    
    public var headers: NetworkHeader? {
        switch self {
        case .quizResultForAnonymous(_, _, let temporaryToken):
            return .init([
                "Content-Type": "application/json",
                "x-wequiz-token": temporaryToken
            ])
        default:
            return NetworkHeader.default
        }
    }
    
    public var encoding: NetworkParameterEncoding {
        switch self {
        case .makeQuiz(_):
            return .jsonEncoding
        case .getQuiz(_):
            return .urlEncoding
        case .quizResult(_, _):
            return .jsonEncoding
        case .quizResultForAnonymous:
            return .jsonEncoding
        case .getQuizRank(_, _):
            return .urlEncoding
        case .anonymous:
            return .jsonEncoding
        }
    }
}
