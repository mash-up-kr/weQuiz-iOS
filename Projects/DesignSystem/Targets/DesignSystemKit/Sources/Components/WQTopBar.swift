//
//  WQTopBar.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQTopBar: View {
    public enum Style {
        case title(TitleNavigationModel)
        case logo(LogoNavigationModel)
        case navigation(TitleNavigationModel)
        case navigationSearchBar(SearchBarNavigationModel)
        case navigationWithButtons(ButtonNavigationModel)
        case navigationWithListEdit(ListEditNavigationModel)
        
        public struct TitleNavigationModel {
            let title: String
            let action: (() -> Void)?
            
            public init(
                title: String,
                action: (() -> Void)? = nil
            ) {
                self.title = title
                self.action = action
            }
        }
        
        public struct LogoNavigationModel {
            let iconImage: Image
            
            public init(iconImage: Image) {
                self.iconImage = iconImage
            }
        }
        
        public struct ButtonNavigationModel {
            public struct Button {
                let icon: any IconRepresentable
                let action: (() -> Void)?
                
                public init(
                    icon: any IconRepresentable,
                    action: (() -> Void)? = nil
                ) {
                    self.icon = icon
                    self.action = action
                }
            }
            let title: String
            let bttons: [Button]
            let action: (() -> Void)?
            
            public init(
                title: String,
                bttons: [Button],
                action: (() -> Void)? = nil
            ) {
                self.title = title
                self.bttons = bttons
                self.action = action
            }
        }
        
        public struct SearchBarNavigationModel {
            @Binding var placeholder: String
            @Binding var input: String
            @Binding var isEditing: Bool
            let action: (() -> Void)?
            let onSubmit: (() -> Void)?
            
            public init(
                placeholder: Binding<String>,
                input: Binding<String>,
                isEditing: Binding<Bool>,
                action: (() -> Void)? = nil,
                onSubmit: (() -> Void)? = nil
            ) {
                self._placeholder = placeholder
                self._input = input
                self._isEditing = isEditing
                self.action = action
                self.onSubmit = onSubmit
            }
        }
        
        public struct ListEditNavigationModel {
            let buttonTitle: String = "순서 편집"
            let buttonNavigationModel: ButtonNavigationModel
            
            public init(title: String, editAction: @escaping (() -> Void), action: (() -> Void)?) {
                self.buttonNavigationModel = ButtonNavigationModel(
                    title: title,
                    bttons: [
                        .init(
                            icon: Icon.Edit.list,
                            action: editAction
                        )
                    ],
                    action: action
                )
            }
        }
    }
    
    public let style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public var body: some View {
        switch style {
        case .title(let model):
            title(model)
        case .logo(let model):
            logo(model)
        case .navigation(let model):
            navigation(model)
        case .navigationSearchBar(let model):
            navigation(model)
        case .navigationWithButtons(let model):
            navigation(model)
        case .navigationWithListEdit(let model):
            navigation(model)
        }
    }
    
    private func title(_ model: Style.TitleNavigationModel) -> some View {
        ZStack {
            HStack(spacing: .zero) {
                Text(model.title)
                    .font(.pretendard(.bold, size: ._18))
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 20,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
    
    private func logo(_ model: Style.LogoNavigationModel) -> some View {
        ZStack {
            HStack(spacing: .zero) {
                model.iconImage
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 20,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
    
    private func navigation(_ model: Style.TitleNavigationModel) -> some View {
        ZStack {
            HStack(spacing: .zero) {
                Button {
                    model.action?()
                } label: {
                    HStack(spacing: 4) {
                        Image(Icon.Chevron.leftBig)
                        Text(model.title)
                            .font(.pretendard(.bold, size: ._18))
                            .foregroundColor(.designSystem(.g2))
                    }
                }
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 12,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
    
    private func navigation(_ model: Style.ButtonNavigationModel) -> some View {
        ZStack {
            HStack(spacing: .zero) {
                Button {
                    model.action?()
                } label: {
                    HStack(spacing: 4) {
                        Image(Icon.Chevron.leftBig)
                        Text(model.title)
                            .font(.pretendard(.bold, size: ._18))
                            .foregroundColor(.designSystem(.g2))
                    }
                }
                Spacer()
                HStack {
                    ForEach(model.bttons.indices, id:\.self) { index in
                        let buttonConfigure = model.bttons[index]
                        Button {
                            buttonConfigure.action?()
                        } label: {
                            Image(buttonConfigure.icon)
                        }
                    }
                }
                .padding(.trailing, 20)
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 12,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
    
    private func navigation(_ model: Style.SearchBarNavigationModel) -> some View {
        ZStack {
            HStack(spacing: 12) {
                Button {
                    model.action?()
                } label: {
                    Image(Icon.Chevron.leftBig)
                }
                WQSearchBar(
                    input: model.$input,
                    placeholder: model.$placeholder,
                    onSubmit: model.onSubmit
                )
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 12,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
    
    private func navigation(_ model: Style.ListEditNavigationModel) -> some View {
        ZStack {
            HStack(spacing: .zero) {
                Button {
                    model.buttonNavigationModel.action?()
                } label: {
                    HStack(spacing: 4) {
                        Image(Icon.Chevron.leftBig)
                        Text(model.buttonNavigationModel.title)
                            .font(.pretendard(.bold, size: ._18))
                            .lineLimit(1)
                            .foregroundColor(.designSystem(.g2))
                    }
                }
                Spacer()
                if let editButtonModel = model.buttonNavigationModel.bttons.first {
                    Button {
                        editButtonModel.action?()
                    } label: {
                        HStack(spacing: 2) {
                            Image(editButtonModel.icon)
                                .renderingMode(.template)
                            Text(model.buttonTitle)
                                .font(.pretendard(.regular, size: ._16))
                        }
                        .foregroundColor(.designSystem(.g2))
                    }
                    .padding(.trailing, 20)
                }
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 12,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
    }
}

struct WQTopBar_Previews: PreviewProvider {
    static var previews: some View {
        WQTopBar(style: .title(.init(title: "타이트으으을")))
        WQTopBar(style: .navigation(.init(title: "타이트으으을", action: {
            print("타이틀 네비게이션 탑바 뒤로가기 클릭")
        })))
        WQTopBar(style: .navigationWithButtons(
            .init(
                title: "네비게이션 With Buttons",
                bttons: [
                    .init(icon: Icon.Magnifier.lineGray, action: {
                        print("돋보기 버튼 클릭")
                    }),
                    .init(icon: Icon.CircleAlert.fillMono, action: {
                        print("이상한버튼 클릭")
                    })
                ],
                action: {
                    print("타이틀 네비게이션 탑바 withButton 뒤로가기 클릭")
                }
            ))
        )
        WQTopBar(style: .navigationSearchBar(
            .init(
                placeholder: .init(projectedValue: .constant("placeholder")),
                input: .init(projectedValue: .constant("")),
                isEditing: .init(projectedValue: .constant(false)),
                action: {
                    print("네비게이션 탑바 withSearchBar 뒤로가기 클릭")
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
