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
        case color
        case component
        case modal
        case input
        case toast
        case progressbar
    }

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("Typography Semantic", value: NavigationType.typography(.semantic))
                NavigationLink("Typography Manual", value: NavigationType.typography(.manual))
                NavigationLink("Icon", value: NavigationType.icon)
                NavigationLink("Color", value: NavigationType.color)
                NavigationLink("Component", value: NavigationType.component)
                NavigationLink("Modal", value: NavigationType.modal)
                NavigationLink("Input", value: NavigationType.input)
                NavigationLink("Toast", value: NavigationType.toast)
                NavigationLink("ProgressBar", value: NavigationType.progressbar)
            }
            .navigationDestination(for: NavigationType.self) {
                switch $0 {
                case let .typography(type):
                    TypographyPreview(typographyType: type)
                case .icon:
                    IconPreview()
                case .color:
                    ColorPreview()
                case .component:
                    ComponentPreview()
                case .modal:
                    WQModalPreview()
                case .input:
                    WQInputFieldPreview()
                case .toast:
                    WQToastPreview()
                case .progressbar:
                    WQGradientProgressBarPreview()
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
