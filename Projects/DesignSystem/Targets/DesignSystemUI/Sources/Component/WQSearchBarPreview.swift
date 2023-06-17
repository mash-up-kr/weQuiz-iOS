//
//  WQSearchBarPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQSearchBarPreview: View {
    @State var input1: String = ""
    @State var input2: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SearchBar")
                .font(.title)
            VStack(alignment: .center) {
                WQSearchBar(
                    input: $input1,
                    placeholder: .init(projectedValue: .constant("Placeholder"))
                )
                WQSearchBar(
                    input: $input2,
                    placeholder: .init(projectedValue: .constant("Placeholder")),
                    onSubmit: {
                        print("엔터버튼 눌렀을 때")
                    }
                )
            }
        }
    }
}
