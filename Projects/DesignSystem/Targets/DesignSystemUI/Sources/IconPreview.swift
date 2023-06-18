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
    
    private let checkmark: IconDataSet = (
        "Checkmark",
        [
            Icon.Checkmark.trueFill24,
            Icon.Checkmark.trueFill20,
            Icon.Checkmark.falseLine24,
            Icon.Checkmark.falseLine20,
            Icon.Checkmark.falseFill24,
            Icon.Checkmark.falseFill20
        ]
    )
    
    private let circleAlert: IconDataSet = (
        "CircleAlert",
        [
            Icon.CircleAlert.fillMono
        ]
    )
    
    private let close: IconDataSet = (
        "Close",
        [
            Icon.Close.fillBlack,
            Icon.Close.fillGray,
            Icon.Close.fillWhite
        ]
    )
    
    private let edit: IconDataSet = (
        "Edit",
        [
            Icon.Edit.list
        ]
    )

    private let siren: IconDataSet = (
        "Siren",
        [
            Icon.Siren.mono
        ]
    )
    
    private let magnifier: IconDataSet = (
        "Magnifier",
        [
            Icon.Magnifier.lineGray
        ]
    )
    
    private let arrow: IconDataSet = (
        "Arrow",
        [
            Icon.Arrow.up
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
                IconSectionView(title: siren.title, data: siren.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: magnifier.title, data: magnifier.data)
            }
            VStack(alignment: .leading) {
                IconSectionView(title: arrow.title, data: arrow.data)
            }
        }
        .navigationTitle("Icon")
        .padding()
    }
}
