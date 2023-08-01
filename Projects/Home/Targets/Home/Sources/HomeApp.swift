import SwiftUI
import HomeUI
import DesignSystemKit
import HomeKit
import CoreKit

@main
struct HomeApp: App {
    public init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    private let navigator = HomeNavigator.shared
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(navigator)
        }
    }
}
