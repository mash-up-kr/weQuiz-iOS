//
//  WQTopBarPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQTopBarPreview: View {
    @State var searchBarInput: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TopBar")
                .font(.title)
            VStack {
                WQTopBar(style: .title(.init(title: "타이틀만")))
                WQTopBar(style: .navigation(.init(title: "네비게이션이랑 타이틀")))
                WQTopBar(style: .navigationWithButtons(
                    .init(
                        title: "네비게이션이랑 버튼",
                        bttons: [
                            .init(icon: Icon.Edit.list, action: {
                                print("네비게이션 버튼 클릭1")
                            }),
                            .init(icon: Icon.CircleAlert.fillMono, action: {
                                print("네비게이션 버튼 클릭2")
                            })
                        ]
                    )
                ))
                WQTopBar(style: .navigationSearchBar(
                    .init(
                        placeholder: .init(projectedValue: .constant("placeholder")),
                        input: $searchBarInput,
                        isEditing: .init(projectedValue: .constant(false)),
                        action: {
                            print("네비게이션 탑바 withSearchBar 뒤로가기 클릭")
                        }, onSubmit: {
                            print("엔터버튼 누를시!")
                        })
                ))
                WQTopBar(style: .navigationWithListEdit(
                    .init(
                        title: "네비게이션 With List Edit",
                        editAction: {
                            print("리스트 편집 활성화")
                        }, action: {
                            print("네비게이션 탑바 withListEdit 뒤로가기 클릭")
                        })
                ))
            }
        }
    }
}
