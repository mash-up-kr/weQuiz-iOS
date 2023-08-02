import SwiftUI

import DesignSystemKit

@main
struct WeQuizApp: App {
    
    init() {
        DesignSystemKit.registerFont()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
