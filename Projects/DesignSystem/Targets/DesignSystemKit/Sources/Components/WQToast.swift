//
//  WQToast.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/24.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQToast: View {
    private let model: Model
    
    public struct Model: Equatable {
        public enum Status: Equatable {
            case success
            case warning
        }
        
        let status: Status
        let text: String
        
        public init(status: Status, text: String) {
            self.status = status
            self.text = text
        }
    }
    
    public init(model: Model) {
        self.model = model
    }
    
    public var body: some View {
        toast(model)
    }
    
    private func toast(_ model: Model) -> some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 4) {
                Image(model.status == .success ? Icon.Checkmark.trueFill24 : Icon.CircleAlert.fillMono)
                    .animation(.easeInOut.delay(0.3))
                Text(model.text)
                    .lineSpacing(6)
                    .font(.pretendard(.regular, size: ._16))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(
                .init(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16
                )
            )
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(
                    .designSystem(.g9).opacity(0.9)
                )
        }
        .padding(
            .init(
                top: .zero,
                leading: 20,
                bottom: .zero,
                trailing: 20
            )
        )
    }
}

struct WQToast_Previews: PreviewProvider {
    static var previews: some View {
        WQToast(
            model: .init(
                status: .success,
                text: "두줄\n텍스트"
            )
        )
        WQToast(
            model: .init(
                status: .warning,
                text: "한줄텍스트"
            )
        )
    }
}
