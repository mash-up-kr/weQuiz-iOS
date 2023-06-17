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
    
    public let style: Style
    
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
            HStack {
                Button {
                    model.leftAction?()
                } label: {
                    Text(model.titles.leftTitle)
                        .font(.pretendard(.bold, size: ._16))
                        .foregroundColor(.white)
                        .padding()
                }
                .background {
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .foregroundColor(.designSystem(.g5))
                }
                Button {
                    model.rightAction?()
                } label: {
                    Text(model.titles.rightTitle)
                        .font(.pretendard(.bold, size: ._16))
                        .foregroundColor(.designSystem(.g9))
                        .padding()
                }
                .background {
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .foregroundColor(.designSystem(.main))
                }
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
                    .font(.pretendard(.bold, size: ._16))
                    .foregroundColor(.designSystem(.g9))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(.designSystem(.main))
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
                    .font(.pretendard(.bold, size: ._16))
                    .foregroundColor(.designSystem(.g9))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(.designSystem(.main))
                
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
        
        public init(title: String, action: Action) {
            self.title = title
            self.action = action
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .double: return 12
        case .single: return 16
        case .fullRadiusSingle: return .zero
        }
    }
    
    fileprivate var padding: EdgeInsets {
        switch self {
        case .double, .single:
            return .init(
                top: 12,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        case .fullRadiusSingle:
            return .init(
                top: 8,
                leading: 8,
                bottom: 8,
                trailing: 8
            )
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