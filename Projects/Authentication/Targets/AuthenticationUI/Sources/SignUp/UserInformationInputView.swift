//
//  UserInformationInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct UserInformationInputView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            WQTopBar(style: .navigation(.init(title: "")))
            VStack(alignment: .leading, spacing: .zero) {
                Text("{서비스명}에서 사용 할\n닉네임을 입력해 주세요")
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 36)
                Input()
                Spacer()
                WQButton(
                    style: .fullRadiusSingle(
                        .init(
                            title: "다음",
                            action: {
                                // TODO: 인증번호 입력 화면 진입
                            }
                        )
                    )
                )
            }
            .padding(
                .init(
                    top: 20,
                    leading: 20,
                    bottom: .zero,
                    trailing: 20
                )
            )
            Spacer()
        }
    }
    
    private struct Input: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 4) {
                        Text("닉네임")
                            .font(.pretendard(.medium, size: ._12))
                            .foregroundColor(.designSystem(.g2))
                        Text("(필수)")
                            .font(.pretendard(.regular, size: ._12))
                            .foregroundColor(.designSystem(.alert))
                    }
                    // 임시 컴포넌트
                    Text("임시 CharacterLimit Input")
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .background(Color.designSystem(.p1))
                    //
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 4) {
                        Text("자기소개")
                            .font(.pretendard(.medium, size: ._12))
                            .foregroundColor(.designSystem(.g2))
                        Text("(필수)")
                            .font(.pretendard(.regular, size: ._12))
                            .foregroundColor(.designSystem(.g4))
                    }
                    // 임시 컴포넌트
                    Text("임시 CharacterLimit Input")
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .background(Color.designSystem(.p1))
                    //
                }
            }
        }
    }
}

struct UserInformationInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationInputView()
    }
}
