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
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(HomeViewModel(service: HomeService(Networking())))
        }
    }
}
