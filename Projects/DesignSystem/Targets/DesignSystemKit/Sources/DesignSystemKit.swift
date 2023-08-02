import Foundation

public enum DesignSystemKit {
    static let bundleId = "wequiz.ios.DesignSystemKit"
    
    public static func registerFont() {
        _ = try? Pretendard.registerFonts()
    }
}
