import SwiftUI
import QuizUI
import DesignSystemKit

@main
struct QuizApp: App {
    
    public init() {
        /// Preview에서 Typography를 적용하려면 아래 코드를 작성해야합니다
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            MakeQuizView().configureView()
        }
    }
}
