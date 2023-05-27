import SwiftUI

import DesignSystemKit

public struct ContentView: View {
    public init() {
        /// Preview에서 Typography를 적용하려면 아래 코드를 작성해야합니다
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("Typography Semantic", value: TypographyPreview.TypographyType.semantic)
                NavigationLink("Typography Manual", value: TypographyPreview.TypographyType.manual)
            }
            .navigationDestination(for: TypographyPreview.TypographyType.self) {
                TypographyPreview(typographyType: $0)
            }
            .navigationTitle("WeQuiz DesignSystem")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
