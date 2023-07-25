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

enum QuizAPI {
    case makeQuiz(MakeQuizRequestModel)
    case getQuiz(Int, GetQuizRequestModel)
    case getQuizRank(Int, GetQuizRankRequestModel)
}

extension QuizAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .makeQuiz:
            return "/api/v1/quiz"
        case .getQuiz(let quizId, _):
            return "/api/v1/\(quizId)/answers"
        case .getQuizRank(let quizId, _):
            return "/api/v1/ranking/quiz/\(quizId)"
        }
    }
    
    var headers: HTTPHeaders {
        [
            "Content-Type": "application/json",
            "x-wequiz-token": "AIE-54Ve5T1TA3ahiwsjfLWjNeFHvQxd4F9E05mRqSqV5OuoZPba-BSrd74JwpBvxobRpO1pocbDLRx0K5sU0Ahb5Q_Uj_53cMNfqf0v_wS3huRVQtQCPvf6-R_vwttoU7qbtN3YOKhW8Seb73kHVThfjsQoqo1hPw"
        ]
    }
    
    var method: HTTPMethod {
        switch self {
        case .makeQuiz(_):
            return .post
        case .getQuiz(_, _):
            return .post
        case .getQuizRank(_, _):
            return .get
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .makeQuiz(let model):
            return model
        case .getQuiz(_, let model):
            return model
        case .getQuizRank(_, let model):
            return model
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
