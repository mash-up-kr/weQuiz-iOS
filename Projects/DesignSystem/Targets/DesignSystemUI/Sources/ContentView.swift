import SwiftUI

import DesignSystemKit

public struct ContentView: View {
    public init() {
        /// Preview에서 Typography를 적용하려면 아래 코드를 작성해야합니다
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }

    public var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.pretendard(.bold, size: ._12))
                .padding()
            Text("Hello, World!")
                .font(.pretendard(.regular, sementic: .h4))
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
