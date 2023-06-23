//
//  WQModalPreview.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/10.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQModalPreview: View {
    @State private var oneButtonModalIsPresent: Bool = false
    @State private var twoButtonModalIsPresent: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Modal")
                    .font(.title)
                Button("OneButton Modal") {
                    oneButtonModalIsPresent = true
                }
                Button("TwoButton Modal") {
                    twoButtonModalIsPresent = true
                }
            }
        }
        .modal(
            .init(
                message: "원버튼 모달",
                singleButtonStyleModel: .init(
                    title: "버튼 타이틀",
                    action: {
                        print("버튼이 눌렸넹")
                        oneButtonModalIsPresent = false
                    }
                )
            ),
            isPresented: $oneButtonModalIsPresent
        )
        .modal(
            .init(
                message: "투버튼 모달",
                doubleButtonStyleModel: .init(
                    titles: ("왼쪽버튼타이틀", "오른쪽버튼 타이틀"),
                    leftAction: {
                        print("왼쪽버튼이 눌렸넹")
                        twoButtonModalIsPresent = false
                    },
                    rightAction: {
                        print("오른쪽버튼이 눌렸넹")
                        twoButtonModalIsPresent = false
                    }
                )
            ),
            isPresented: $twoButtonModalIsPresent
        )
    }
}
