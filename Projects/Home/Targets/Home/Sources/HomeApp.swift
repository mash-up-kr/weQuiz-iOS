import SwiftUI
import HomeUI
import DesignSystemKit

@main
struct HomeApp: App {
    public init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(HomeViewModel())
        }
    }
}
