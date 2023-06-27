//
//  PhoneNumberInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/27.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct PhoneNumberInputView: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            WQTopBar(style: .navigation(.init(title: "")))
            VStack(alignment: .leading, spacing: .zero) {
                Text("회원가입을 위해\n휴대폰 번호를 입력해주세요")
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 36)
                VStack(alignment: .leading, spacing: 12) {
                    Text("휴대폰번호")
                        .font(.pretendard(.medium, size: ._12))
                        .foregroundColor(.designSystem(.g2))
                    // 임시 컴포넌트
                    Text("임시 PhoneNumber Input")
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .background(Color.designSystem(.p1))
                    //
                }
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
            WQButton(
                style: .fullRadiusSingle(
                    .init(
                        title: "인증번호 받기",
                        action: {
                            // TODO: 인증번호 입력 화면 진입
                        }
                    )
                )
            )
        }
    }
}

struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputView()
    }
}
