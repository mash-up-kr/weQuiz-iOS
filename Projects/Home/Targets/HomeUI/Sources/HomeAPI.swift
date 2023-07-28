//
//  HomeAPI.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI
import CoreKit
import HomeKit


enum HomeAPI {
    case getMyInfo
    case getFriendRank(FriendRankRequestModel)
    case getQuestionGroup(QuestionGroupRequestModel)
    case getQuestionStatistic(QuestionStatisticRequestModel)
    case deleteQuestion(QuestionDeleteRequestModel)
}

extension HomeAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .getMyInfo:
            return "/api/v1/user"
        case .getFriendRank:
            return "/api/v1/ranking/my-quiz"
        case .getQuestionGroup(_):
            return "/api/v1/quiz"
        case .getQuestionStatistic(let model):
            return "/api/v1/statistic/quiz/\(model.quizId)"
        case .deleteQuestion(let model):
            return "/api/v1/quiz/\(model.quizId)"
        }
    }
    
    var headers: HTTPHeaders {
        // 향후 userDefault에 개인 토큰값을 저장하고 해당 값을 넣어준다.
        [
            "x-wequiz-token": "AIE-54W-amwtn2V03BQXn5ibwu3my68KXVAL4b7wQMa7gIDLV_QGwcQji_5lQ30sV20L5igMhn4Daig6w4JhTPOF_rQ_c-CF5rojgpVw8EVKnNgJF2ePgAt4bRJ86Mvml51yWvWl2wcTX30StvIeSomDhlhUx2jcMw"
        ]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMyInfo:
            return .get
        case .getFriendRank:
            return .get
        case .getQuestionGroup(_):
            return .get
        case .getQuestionStatistic(_):
            return .get
        case .deleteQuestion(_):
            return .delete
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .getMyInfo:
            return nil
        case .getFriendRank(let model):
            return model
        case .getQuestionGroup(let model):
            return model
        case .getQuestionStatistic(let model):
            return model
        case .deleteQuestion(let model):
            return model
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMyInfo:
            return URLEncoding.default
        case .getFriendRank(_):
            return URLEncoding.default
        case .getQuestionGroup(_):
            return URLEncoding.default
        case .getQuestionStatistic(_):
            return URLEncoding.default
        case .deleteQuestion(_):
            return URLEncoding.default
        }
    }
}
