//
//  WQModal.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/10.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQModal: View {
    public enum Style {
        case oneButton(OneButtonAlertModel)
        case twoButton(TwoButtonAlertModel)
        
        public struct OneButtonAlertModel {
            let message: String
            let singleButtonStyleModel: WQButton.Style.SingleButtonStyleModel
            
            public init(message: String, singleButtonStyleModel: WQButton.Style.SingleButtonStyleModel) {
                self.message = message
                self.singleButtonStyleModel = singleButtonStyleModel
            }
        }
        
        public struct TwoButtonAlertModel {
            let message: String
            let doubleButtonStyleModel: WQButton.Style.DobuleButtonStyleModel
            
            public init(message: String, doubleButtonStyleModel: WQButton.Style.DobuleButtonStyleModel) {
                self.message = message
                self.doubleButtonStyleModel = doubleButtonStyleModel
            }
        }
    }
    
    private let style: Style
    @Binding private var isPresented: Bool
    
    public init(style: Style, isPresented: Binding<Bool>) {
        self.style = style
        self._isPresented = isPresented
    }
    
    public var body: some View {
        switch style {
        case .oneButton(let oneButtonAlertModel):
            modal(oneButtonAlertModel)
        case .twoButton(let twoButtonAlertModel):
            modal(twoButtonAlertModel)
        }
    }
    
    private struct DimView: View {
        @Binding var isPresented: Bool
        
        var body: some View {
            Color.designSystem(.dimed)
                .opacity(0.8)
                .onTapGesture {
                    isPresented = false
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func modal(_ model: Style.OneButtonAlertModel) -> some View {
        GeometryReader { proxy in
            if isPresented {
                ZStack {
                    DimView(isPresented: $isPresented)
                    VStack(spacing: .zero) {
                        HStack {
                            Text(model.message)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(.regular, size: ._16))
                        }
                        .padding(
                            .init(
                                top: 40,
                                leading: 12,
                                bottom: 40,
                                trailing: 12
                            )
                        )
                        WQButton(style: .single(model.singleButtonStyleModel))
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.designSystem(.g7))
                    }
                    .padding(.horizontal, 20)
                }
                .position(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0)
            }
        }
    }
    
    private func modal(_ model: Style.TwoButtonAlertModel) -> some View {
        GeometryReader { proxy in
            if isPresented {
                ZStack {
                    DimView(isPresented: $isPresented)
                    VStack(spacing: .zero) {
                        HStack {
                            Text(model.message)
                                .multilineTextAlignment(.center)
                                .font(.pretendard(.regular, size: ._16))
                        }
                        .padding(
                            .init(
                                top: 40,
                                leading: 12,
                                bottom: 40,
                                trailing: 12
                            )
                        )
                        WQButton(style: .double(model.doubleButtonStyleModel))
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.designSystem(.g7))
                    }
                    .padding(.horizontal, 20)
                }
                .position(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0)
            }
        }
    }
}

struct WQModal_Previews: PreviewProvider {
    static var previews: some View {
        WQModal(style: .oneButton(.init(
            message: "WQ Modal\nOne ButtonOne ButtonOne Button",
            singleButtonStyleModel: .init(
                title: "버튼",
                action: {
                    print("버튼클릭")
                })
        )), isPresented: .init(projectedValue: .constant(true))
        )
        WQModal(style: .twoButton(
            .init(
                message: "WQ Modal\nTwo Button",
                doubleButtonStyleModel: .init(
                    titles: (leftTitle: "왼쪽", rightTitle: "오른쪽"),
                    leftAction: {
                        print("왼쪽버튼클릭")
                    }, rightAction: {
                        print("오른쪽버튼클릭")
                    }
                )
            )), isPresented: .init(projectedValue: .constant(true))
        )
    }
}
