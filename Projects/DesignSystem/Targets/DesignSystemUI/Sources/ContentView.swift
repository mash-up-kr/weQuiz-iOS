import SwiftUI

import DesignSystemKit

public struct ContentView: View {
    public init() {
        /// Preview에서 Typography를 적용하려면 아래 코드를 작성해야합니다
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    private enum NavigationType: Hashable {
        case typography(TypographyPreview.TypographyType)
        case icon
    }

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("Typography Semantic", value: NavigationType.typography(.semantic))
                NavigationLink("Typography Manual", value: NavigationType.typography(.manual))
                NavigationLink("Icon", value: NavigationType.icon)
            }
            .navigationDestination(for: NavigationType.self) {
                switch $0 {
                case let .typography(type):
                    TypographyPreview(typographyType: type)
                case .icon:
                    IconPreview()
                }
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
