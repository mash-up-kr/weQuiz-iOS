//
//  WQToastPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQToastPreview: View {
    @State private var input: String = ""
    @State private var successToastModel: WQToast.Model?
    @State private var warningToastModel: WQToast.Model?

    var body: some View {
        VStack(alignment: .leading) {
            Text("SearchBar")
                .font(.title)
            TextField(
                "TextInput",
                text: $input,
                prompt: Text("토스트에 노출될 텍스트를 입력해주세요")
            )
            Spacer()
                .frame(height: 25)
            VStack(spacing: 10) {
                Button("Success 토스트") {
                    successToastModel = .init(status: .success, text: input)
                }
                Button("Warning 토스트") {
                    warningToastModel = .init(status: .warning, text: input)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .toast(model: $successToastModel)
        .toast(model: $warningToastModel)
    }
}
