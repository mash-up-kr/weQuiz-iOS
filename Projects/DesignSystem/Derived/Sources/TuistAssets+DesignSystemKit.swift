// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DesignSystemKitAsset {
  public static let p1 = DesignSystemKitColors(name: "p1")
  public static let s1 = DesignSystemKitColors(name: "s1")
  public static let s2 = DesignSystemKitColors(name: "s2")
  public static let s3 = DesignSystemKitColors(name: "s3")
  public static let s4 = DesignSystemKitColors(name: "s4")
  public static let s5 = DesignSystemKitColors(name: "s5")
  public static let g1 = DesignSystemKitColors(name: "g1")
  public static let g2 = DesignSystemKitColors(name: "g2")
  public static let g3 = DesignSystemKitColors(name: "g3")
  public static let g4 = DesignSystemKitColors(name: "g4")
  public static let g5 = DesignSystemKitColors(name: "g5")
  public static let g6 = DesignSystemKitColors(name: "g6")
  public static let g7 = DesignSystemKitColors(name: "g7")
  public static let g8 = DesignSystemKitColors(name: "g8")
  public static let g9 = DesignSystemKitColors(name: "g9")
  public static let black = DesignSystemKitColors(name: "Black")
  public static let dimed = DesignSystemKitColors(name: "dimed")
  public static let alert = DesignSystemKitColors(name: "alert")
  public static let disabled = DesignSystemKitColors(name: "disabled")
  public static let main = DesignSystemKitColors(name: "main")
  public static let addCircle = DesignSystemKitImages(name: "add_circle")
  public static let arrowUp = DesignSystemKitImages(name: "arrow_up")
  public static let checkmarkFalseFill20 = DesignSystemKitImages(name: "checkmark_false_fill_20")
  public static let checkmarkFalseFill24 = DesignSystemKitImages(name: "checkmark_false_fill_24")
  public static let checkmarkFalseLine20 = DesignSystemKitImages(name: "checkmark_false_line_20")
  public static let checkmarkFalseLine24 = DesignSystemKitImages(name: "checkmark_false_line_24")
  public static let checkmarkTrueFill20 = DesignSystemKitImages(name: "checkmark_true_fill_20")
  public static let checkmarkTrueFill24 = DesignSystemKitImages(name: "checkmark_true_fill_24")
  public static let chevronDownBig = DesignSystemKitImages(name: "chevron_down_big")
  public static let chevronDownMedium = DesignSystemKitImages(name: "chevron_down_medium")
  public static let chevronDownSmall = DesignSystemKitImages(name: "chevron_down_small")
  public static let chevronLeftBig = DesignSystemKitImages(name: "chevron_left_big")
  public static let chevronLeftMedium = DesignSystemKitImages(name: "chevron_left_medium")
  public static let chevronLeftSmall = DesignSystemKitImages(name: "chevron_left_small")
  public static let chevronRightBig = DesignSystemKitImages(name: "chevron_right_big")
  public static let chevronRightMedium = DesignSystemKitImages(name: "chevron_right_medium")
  public static let chevronRightSmall = DesignSystemKitImages(name: "chevron_right_small")
  public static let chevronUpBig = DesignSystemKitImages(name: "chevron_up_big")
  public static let chevronUpMedium = DesignSystemKitImages(name: "chevron_up_medium")
  public static let chevronUpSmall = DesignSystemKitImages(name: "chevron_up_small")
  public static let circleAlertFillMono = DesignSystemKitImages(name: "circle_alert_fill_mono")
  public static let closeFillBlack = DesignSystemKitImages(name: "close_fill_black")
  public static let closeFillGray = DesignSystemKitImages(name: "close_fill_gray")
  public static let closeFillWhite = DesignSystemKitImages(name: "close_fill_white")
  public static let editList = DesignSystemKitImages(name: "edit_list")
  public static let homeFillGray24 = DesignSystemKitImages(name: "home_fill_gray_24")
  public static let maginfierLineGray = DesignSystemKitImages(name: "maginfier_line_gray")
  public static let medalBronze = DesignSystemKitImages(name: "medal_bronze")
  public static let medalGold = DesignSystemKitImages(name: "medal_gold")
  public static let medalSilver = DesignSystemKitImages(name: "medal_silver")
  public static let shareFillGray24 = DesignSystemKitImages(name: "share_fill_gray_24")
  public static let sirenMono = DesignSystemKitImages(name: "siren_mono")
  public static let trashCanFillGray24 = DesignSystemKitImages(name: "trash_can_fill_gray_24")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DesignSystemKitColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DesignSystemKitColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: DesignSystemKitColors) {
    let bundle = DesignSystemKitResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: DesignSystemKitColors) {
    let bundle = DesignSystemKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DesignSystemKitImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = DesignSystemKitResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension DesignSystemKitImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the DesignSystemKitImages.image property")
  convenience init?(asset: DesignSystemKitImages) {
    #if os(iOS) || os(tvOS)
    let bundle = DesignSystemKitResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: DesignSystemKitImages) {
    let bundle = DesignSystemKitResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DesignSystemKitImages, label: Text) {
    let bundle = DesignSystemKitResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DesignSystemKitImages) {
    let bundle = DesignSystemKitResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
