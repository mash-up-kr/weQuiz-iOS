//
//  AnswerListRowDataStore.swift
//  WeQuiz
//
//  Created by 최원석 on 2023/08/04.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation
import Combine
import DesignSystemKit
import SwiftUI


// viewModel을 사용할 경우 view size를 제대로 못가져오는 이슈가 계속해서 발생한다.
// 위 이슈를 해결해야 viewModel을 사용할 수 있을 듯 싶다.
final class AnswerListRowDataStore: ObservableObject {

    @Published var percentViewUseWidth: CGFloat = 0
    @Published var alphabetCircleUseWidth: CGFloat = 0
    @Published var contentTextUseWidth: CGFloat = 0
    @Published var spacerUseWidth: CGFloat = 0
    @Published var percentTextUseWidth: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func setupPercentViewUseWidth(size: CGSize) {
        self.percentViewUseWidth = size.width
    }
    
    func setupAlphabetCircleUseWidth(size: CGSize) {
        self.alphabetCircleUseWidth = size.width
    }
    
    func setupContentTextUseWidth(size: CGSize) {
        self.contentTextUseWidth = size.width + self.alphabetCircleUseWidth
    }
    
    func setupSpacerWidth(size: CGSize) {
        self.spacerUseWidth = size.width + self.contentTextUseWidth
    }
    
    func setupPercentTextUseWidth(size: CGSize) {
        self.percentTextUseWidth = size.width + self.spacerUseWidth
    }
}
