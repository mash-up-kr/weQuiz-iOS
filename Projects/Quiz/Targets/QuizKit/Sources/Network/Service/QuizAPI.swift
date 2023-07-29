//
//  QuizAPI.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import SwiftUI
import CoreKit
import Alamofire

public enum QuizAPI {
    case makeQuiz(MakeQuizRequestModel)
    case getQuiz(Int)
    case quizResult(Int, QuizResultRequestModel)
    case getQuizRank(Int, GetQuizRankRequestModel)
}

extension QuizAPI: NetworkRequestable {
    public var path: String {
        switch self {
        case .makeQuiz:
            return "/api/v1/quiz"
        case .getQuiz(let quizId):
            return "/api/v1/quiz/\(quizId)"
        case .quizResult(let quizId, _):
            return "/api/v1/\(quizId)/answers"
        case .getQuizRank(let quizId, _):
            return "/api/v1/ranking/quiz/\(quizId)"
        }
    }
    
    public var headers: NetworkHeader? {
        .init( [
            "Content-Type": "application/json",
            "x-wequiz-token": "AIE-54W-amwtn2V03BQXn5ibwu3my68KXVAL4b7wQMa7gIDLV_QGwcQji_5lQ30sV20L5igMhn4Daig6w4JhTPOF_rQ_c-CF5rojgpVw8EVKnNgJF2ePgAt4bRJ86Mvml51yWvWl2wcTX30StvIeSomDhlhUx2jcMw"
        ]
               )
    }
    
    public var method: NetworkMethod {
        switch self {
        case .makeQuiz(_):
            return .post
        case .getQuiz(_):
            return .get
        case .quizResult(_, _):
            return .post
        case .getQuizRank(_, _):
            return .get
        }
    }
    
    public var parameters: Encodable? {
        switch self {
        case .makeQuiz(let model):
            return model
        case .getQuiz(_):
            return nil
        case .quizResult(_, let model):
            return model
        case .getQuizRank(_, let model):
            return model
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
        case .getQuizRank(_, _):
            return .urlEncoding
        }
    }
}
