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
        case two(TwoButtonStyleModel)
        case one(OneButtonStyleModel)
        case full(OneButtonStyleModel)
    }
    
    public let style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public var body: some View {
        switch style {
        case .two(let model):
            twoButton(style, model: model)
        case .one(let model):
            oneButton(style, model: model)
        case .full(let model):
            fullButton(style, model: model)
        }
    }
    
    private func twoButton(_ style: Style, model: Style.TwoButtonStyleModel) -> some View {
        ZStack {
            HStack {
                Button {
                    model.leftAction?()
                } label: {
                    Text(model.titles.leftTitle)
                        .font(.pretendard(.semibold, size: ._16))
                        .foregroundColor(.designSystem(.g2))
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
                        .font(.pretendard(.semibold, size: ._16))
                        .foregroundColor(.designSystem(.g2))
                        .padding()
                }
                .background {
                    RoundedRectangle(cornerRadius: style.cornerRadius)
                        .foregroundColor(.designSystem(.p1))
                }
            }
            .padding(style.padding)
        }
    }
    
    private func oneButton(_ style: Style, model: Style.OneButtonStyleModel) -> some View {
        ZStack {
            Button {
                model.action?()
            } label: {
                Text(model.title)
                    .font(.pretendard(.semibold, size: ._16))
                    .foregroundColor(.designSystem(.g2))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(.designSystem(.p1))
            }
            .padding(style.padding)
        }
    }
    
    private func fullButton(_ style: Style, model: Style.OneButtonStyleModel) -> some View {
        ZStack {
            Button {
                model.action?()
            } label: {
                Text(model.title)
                    .font(.pretendard(.semibold, size: ._16))
                    .foregroundColor(.designSystem(.g2))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .foregroundColor(.designSystem(.p1))
                
            }
            .padding(style.padding)
        }
    }
 }

public extension WQButton.Style {
    typealias Action = (() -> Void)?
    
    struct TwoButtonStyleModel {
        let titles: (leftTitle: String, rightTitle: String)
        let leftAction: Action
        let rightAction: Action
        
        public init(titles: (leftTitle: String, rightTitle: String), leftAction: Action, rightAction: Action) {
            self.titles = titles
            self.leftAction = leftAction
            self.rightAction = rightAction
        }
    }
    
    struct OneButtonStyleModel {
        let title: String
        let action: Action
        
        public init(title: String, action: Action) {
            self.title = title
            self.action = action
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .two: return 12
        case .one: return 16
        case .full: return .zero
        }
    }
    
    fileprivate var padding: EdgeInsets {
        switch self {
        case .two, .one:
            return .init(
                top: 12,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        case .full:
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
            style: .two(
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
            style: .one(.init(title: "원버튼", action: {
                print("버튼클릭")
            }))
        )
        WQButton(
            style: .full(.init(title: "풀버튼", action: {
                print("버튼클릭")
            })))
    }
}
