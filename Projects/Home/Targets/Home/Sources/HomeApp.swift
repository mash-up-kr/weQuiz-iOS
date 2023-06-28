import SwiftUI
import HomeUI

@main
struct HomeApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(HomeViewModel())
        }
    }
}
