//
//  WQButton.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQButton: View {
    public enum Style {
        case double(DobuleButtonStyleModel)
        case single(SingleButtonStyleModel)
        case fullRadiusSingle(SingleButtonStyleModel)
    }
    
    private let style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public var body: some View {
        switch style {
        case .double(let model):
            twoButton(style, model: model)
        case .single(let model):
            oneButton(style, model: model)
        case .fullRadiusSingle(let model):
            fullButton(style, model: model)
        }
    }
    
    private func twoButton(_ style: Style, model: Style.DobuleButtonStyleModel) -> some View {
        ZStack {
            HStack(spacing: 7) {
                Button {
                    model.leftAction?()
                } label: {
                    HStack(spacing: .zero) {
                        Spacer()
                        Text(model.titles.leftTitle)
                            .font(.pretendard(.semibold, size: ._16))
                            .lineLimit(1)
                            .foregroundColor(.designSystem(.g2))
                            .padding()
                        Spacer()
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .foregroundColor(.designSystem(.g6))
                }
                .frame(height: 52)
                Button {
                    model.rightAction?()
                } label: {
                    HStack(spacing: .zero) {
                        Spacer()
                        Text(model.titles.rightTitle)
                            .font(.pretendard(.semibold, size: ._16))
                            .lineLimit(1)
                            .foregroundColor(.designSystem(.g2))
                            .padding()
                        Spacer()
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .foregroundColor(.designSystem(.p1))
                }
                .frame(height: 52)
            }
            .padding(style.padding)
        }
    }
    
    private func oneButton(_ style: Style, model: Style.SingleButtonStyleModel) -> some View {
        ZStack {
            Button {
                model.action?()
            } label: {
                Text(model.title)
                    .font(.pretendard(.semibold, size: ._16))
                    .foregroundColor(model.isEnable ? .designSystem(.g2) : .designSystem(.g4))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .disabled(!model.isEnable)
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(model.isEnable ? .designSystem(.p1) : .designSystem(.disabled))
                    .animation(.easeInOut, value: model.isEnable)
            }
            .padding(style.padding)
        }
    }
    
    private func fullButton(_ style: Style, model: Style.SingleButtonStyleModel) -> some View {
        ZStack {
            Button {
                model.action?()
            } label: {
                Text(model.title)
                    .font(.pretendard(.semibold, size: ._16))
                    .foregroundColor(model.isEnable ? .designSystem(.g2) : .designSystem(.g4))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .disabled(!model.isEnable)
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(model.isEnable ? .designSystem(.p1) : .designSystem(.disabled))
                    .animation(.easeInOut, value: model.isEnable)
                
            }
            .padding(style.padding)
        }
    }
 }

public extension WQButton.Style {
    typealias Action = (() -> Void)?
    
    struct DobuleButtonStyleModel {
        let titles: (leftTitle: String, rightTitle: String)
        let leftAction: Action
        let rightAction: Action
        
        public init(titles: (leftTitle: String, rightTitle: String), leftAction: Action, rightAction: Action) {
            self.titles = titles
            self.leftAction = leftAction
            self.rightAction = rightAction
        }
    }
    
    struct SingleButtonStyleModel {
        let title: String
        let action: Action
        @Binding var isEnable: Bool
        
        public init(
            title: String,
            isEnable: Binding<Bool> = .constant(true),
            action: Action
        ) {
            self.title = title
            self._isEnable = isEnable
            self.action = action
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .double, .single: return 12
        case .fullRadiusSingle: return .zero
        }
    }
    
    fileprivate var padding: EdgeInsets {
        switch self {
        case .double:
            return .init(
                top: 0,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        case .single:
            return .init(
                top: 12,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        case .fullRadiusSingle:
            return .init(.zero)
        }
    }
}

struct WQButton_Previews: PreviewProvider {
    static var previews: some View {
        WQButton(
            style: .double(
                .init(
                    titles: ("왼쪽","오른쪽 테스트 버튼"),
                    leftAction: {
                        print("왼쪽클릭")
                    }, rightAction: {
                        print("오른쪽클릭")
                    }
                )
            )
        )
        WQButton(
            style: .single(.init(title: "원버튼", action: {
                print("버튼클릭")
            }))
        )
        WQButton(
            style: .fullRadiusSingle(.init(title: "풀버튼", action: {
                print("버튼클릭")
            })))
    }
}
