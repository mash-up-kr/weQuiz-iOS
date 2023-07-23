//
//  IconPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct IconPreview: View {
    private struct IconDataSet: Hashable {
        let title: String
        let data: [any IconRepresentable]
        
        static func == (lhs: IconPreview.IconDataSet, rhs: IconPreview.IconDataSet) -> Bool {
            lhs.title == rhs.title && lhs.data.count == rhs.data.count
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }
    
    private let chevron: IconDataSet = .init(
        title: "Chevron",
        data: [
            Icon.Chevron.upBig,
            Icon.Chevron.upMedium,
            Icon.Chevron.upSmall,
            Icon.Chevron.downBig,
            Icon.Chevron.downMedium,
            Icon.Chevron.downSmall,
            Icon.Chevron.leftBig,
            Icon.Chevron.leftMedium,
            Icon.Chevron.leftSmall,
            Icon.Chevron.rightBig,
            Icon.Chevron.rightMedium,
            Icon.Chevron.rightSmall
        ]
    )
    
    private let checkmark: IconDataSet = .init(
        title: "Checkmark",
        data: [
            Icon.Checkmark.trueFill24,
            Icon.Checkmark.trueFill20,
            Icon.Checkmark.falseLine24,
            Icon.Checkmark.falseLine20,
            Icon.Checkmark.falseFill24,
            Icon.Checkmark.falseFill20
        ]
    )
    
    private let circleAlert: IconDataSet = .init(
        title: "CircleAlert",
        data: [
            Icon.CircleAlert.fillMono
        ]
    )
    
    private let close: IconDataSet = .init(
        title: "Close",
        data: [
            Icon.Close.fillBlack,
            Icon.Close.fillGray,
            Icon.Close.fillWhite
        ]
    )
    
    private let edit: IconDataSet = .init(
        title: "Edit",
        data: [
            Icon.Edit.list
        ]
    )
    
    private let siren: IconDataSet = .init(
        title: "Siren",
        data: [
            Icon.Siren.mono
        ]
    )
    
    private let magnifier: IconDataSet = .init(
        title: "Magnifier",
        data: [
            Icon.Magnifier.lineGray
        ]
    )
    
    private let arrow: IconDataSet = .init(
        title: "Arrow",
        data: [
            Icon.Arrow.up
        ]
    )
    
    private let add: IconDataSet = .init(
        title: "Add",
        data: [
            Icon.Add.circle
        ]
    )
    
    private let share: IconDataSet = .init(
        title: "Share",
        data: [
            Icon.Share.fillGray
        ]
    )
    
    private let trashCan: IconDataSet = .init(
        title: "TrashCan",
        data: [
            Icon.TrashCan.fillGray
        ]
    )
    
    private struct IconSectionView: View {
        let title: String
        let data: [any IconRepresentable]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                ForEach(data.indices, id: \.self) { index in
                    IconRowView(representable: data[index])
                }
            }
        }
    }
    
    private struct IconRowView: View {
        let representable: any IconRepresentable
        
        var body: some View {
            HStack {
                Image(representable)
                    .fixedSize()
                    .frame(width: 45, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.gray)
                    )
                Text(representable.name)
                    .font(.pretendard(.regular, size: ._18))
                Spacer()
            }
        }
    }
    
    private var datas: [IconDataSet] {
        [
            chevron, checkmark, circleAlert, close, edit, siren, magnifier,
            arrow, add, share, trashCan
        ]
    }
    
    var body: some View {
        ScrollView {
            ForEach(datas, id: \.self) { icon in
                VStack(alignment: .leading) {
                    IconSectionView(title: icon.title, data: icon.data)
                }
            }
        }
        .navigationTitle("Icon")
        .padding()
    }
}
