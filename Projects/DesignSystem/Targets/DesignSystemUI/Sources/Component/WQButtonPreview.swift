//
//  WQButtonPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQButtonPreview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("버튼")
                .font(.title)
            VStack(alignment: .center) {
                WQButton(
                    style: .double(
                        .init(
                            titles: ("왼쪽버튼", "오른쪽버튼"),
                            leftAction: {
                                print("왼쪽버튼이 눌렸습니다")
                            },
                            rightAction: {
                                print("오른쪽버튼이 눌렸습니다")
                            }
                        )
                    )
                )
                WQButton(
                    style: .single(
                        .init(
                            title: "버튼",
                            action: {
                                print("버튼이 눌렸습니다")
                            }
                        )
                    )
                )
                WQButton(
                    style: .fullRadiusSingle(
                        .init(
                            title: "버튼",
                            action: {
                                print("버튼이 눌렸습니다")
                            }
                        )
                    )
                )
            }
        }
    }
}
