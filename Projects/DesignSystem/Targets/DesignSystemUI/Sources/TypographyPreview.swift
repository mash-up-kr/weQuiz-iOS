//
//  TypographyPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/05/27.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct TypographyPreview: View {
    enum TypographyType: Hashable {
        case semantic
        case manual
    }
    
    @State private var weight: DesignSystemKit.Typography.Weight = .regular
    let typographyType: TypographyType
    
    var body: some View {
        List {
            switch typographyType {
            case .semantic:
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("H3 48")
                            .font(.pretendard(weight, semantic: .h3))
                        Text("H4 34")
                            .font(.pretendard(weight, semantic: .h4))
                        Text("H5 32")
                            .font(.pretendard(weight, semantic: .h5))
                        Text("H6 28")
                            .font(.pretendard(weight, semantic: .h6))
                    }
                    VStack(alignment: .leading) {
                        Text("title 24")
                            .font(.pretendard(weight, semantic: .title))
                        Text("subtitle1 20")
                            .font(.pretendard(weight, semantic: .subtitle1))
                        Text("subtitle2 18")
                            .font(.pretendard(weight, semantic: .subtitle2))
                    }
                    VStack(alignment: .leading) {
                        Text("base 16")
                            .font(.pretendard(weight, semantic: .base))
                    }
                    VStack(alignment: .leading) {
                        Text("caption1 14")
                            .font(.pretendard(weight, semantic: .caption1))
                        Text("caption2 12")
                            .font(.pretendard(weight, semantic: .caption2))
                    }
                    VStack(alignment: .leading) {
                        Text("xs 10")
                            .font(.pretendard(weight, semantic: .xs))
                    }
                }
                .navigationTitle("Semantic")
                .navigationBarTitleDisplayMode(.large)
            case .manual:
                VStack(alignment: .leading) {
                    let text = "그래, 그리 쉽지는 않겠지 나를 허락해준 세상이란, 손쉽게 다가오는 편하고도 감미로운 공간이 아니야"
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.pretendard(weight, size: ._48))
                    }
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.pretendard(weight, size: ._34))
                        Text(text)
                            .font(.pretendard(weight, size: ._32))
                    }
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.pretendard(weight, size: ._28))
                        Text(text)
                            .font(.pretendard(weight, size: ._24))
                    }
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.pretendard(weight, size: ._18))
                        Text(text)
                            .font(.pretendard(weight, size: ._16))
                        Text(text)
                            .font(.pretendard(weight, size: ._14))
                        Text(text)
                            .font(.pretendard(weight, size: ._12))
                        Text(text)
                            .font(.pretendard(weight, size: ._10))
                    }
                }
                .navigationTitle("Manual")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .toolbar {
            Menu("Weight") {
                Picker("Select Weight", selection: $weight) {
                    let weights = DesignSystemKit.Typography.Weight.allCases
                    ForEach(weights.indices, id:
                                \.self) { index in
                        Text(weights[index].rawValue.capitalized).tag(weights[index])
                    }
                }
            }
        }
    }
}
