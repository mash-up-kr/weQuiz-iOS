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
    typealias IconDataSet = (title: String, data: [any IconRepresentable])
    
    private let chevron: IconDataSet = (
        "Chevron",
        [
           DesignSystemKit.Icon.Chevron.upBig,
           DesignSystemKit.Icon.Chevron.upMedium,
           DesignSystemKit.Icon.Chevron.upSmall,
           DesignSystemKit.Icon.Chevron.downBig,
           DesignSystemKit.Icon.Chevron.downMedium,
           DesignSystemKit.Icon.Chevron.downSmall,
           DesignSystemKit.Icon.Chevron.leftBig,
           DesignSystemKit.Icon.Chevron.leftMedium,
           DesignSystemKit.Icon.Chevron.leftSmall,
           DesignSystemKit.Icon.Chevron.rightBig,
           DesignSystemKit.Icon.Chevron.rightMedium,
           DesignSystemKit.Icon.Chevron.rightSmall
       ]
    )
    
    private let checkmark: IconDataSet = (
        "Checkmark",
        [
            DesignSystemKit.Icon.Checkmark.trueFill24,
            DesignSystemKit.Icon.Checkmark.trueFill20,
            DesignSystemKit.Icon.Checkmark.falseLine24,
            DesignSystemKit.Icon.Checkmark.falseLine20,
            DesignSystemKit.Icon.Checkmark.falseFill24,
            DesignSystemKit.Icon.Checkmark.falseFill20
        ]
    )
    
    private let circleAlert: IconDataSet = (
        "CircleAlert",
        [
            DesignSystemKit.Icon.CircleAlert.fillMono
        ]
    )
    
    private let close: IconDataSet = (
        "Close",
        [
            DesignSystemKit.Icon.Close.fillBlack,
            DesignSystemKit.Icon.Close.fillGray,
        ]
    )
    
    private let edit: IconDataSet = (
        "Edit",
        [
            DesignSystemKit.Icon.Edit.list
        ]
    )
    
    private let ranking: IconDataSet = (
        "Ranking",
        [
            DesignSystemKit.Icon.Ranking.down,
            DesignSystemKit.Icon.Ranking.up,
        ]
    )
    
    private let siren: IconDataSet = (
        "Siren",
        [
            DesignSystemKit.Icon.Siren.mono
        ]
    )
    
    private let magnifier: IconDataSet = (
        "Magnifier",
        [
            DesignSystemKit.Icon.Magnifier.lineGray
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
                Image.icon(representable)
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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                IconSectionView(title: chevron.title, data: chevron.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: checkmark.title, data: checkmark.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: circleAlert.title, data: circleAlert.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: close.title, data: close.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: edit.title, data: edit.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: ranking.title, data: ranking.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: siren.title, data: siren.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: magnifier.title, data: magnifier.data)
            }
        }
        .navigationTitle("Icon")
        .padding()
    }
}
