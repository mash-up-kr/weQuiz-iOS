//
//  Colors.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension DesignSystemKit {
    enum Colors: String, CaseIterable {
        
        // MARK: - Primary
        
        case p1
        
        // MARK: - Secondary
        
        case s1
        case s2
        case s3
        case s4
        case s5
        
        // MARK: - Semantic

        case disabled
        case alert
        
        // MARK: - Extended Gray
        
        case g9
        case g8
        case g7
        case g6
        case g5
        case g4
        case g3
        case g2
        case g1
        
        // MARK: - Opacity
        
        case dimed
        case black

        public var name: String {
            self.rawValue
        }
    }
}

public extension DesignSystemKit {
    enum Gradient: String, CaseIterable {
        
        // MARK: - Gradient
        
        case gradientS1
        case gradientS2
        case gradientS3
        case gradientS4
        case gradientS5
        
        public var stops: [SwiftUI.Gradient.Stop] {
            switch self {
            case .gradientS1:
                return [
                    SwiftUI.Gradient.Stop(color: Color(red: 0.8, green: 0.98, blue: 1), location: 0.00),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.43, green: 0.92, blue: 0.95), location: 0.41),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.42, green: 0.95, blue: 0.73), location: 1.00)
                ]
            case .gradientS2:
                return [
                    SwiftUI.Gradient.Stop(color: Color(red: 0.86, green: 0.95, blue: 1), location: 0.00),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.56, green: 0.79, blue: 1), location: 0.48),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.45, green: 0.82, blue: 0.79), location: 1.00)
                ]
            case .gradientS3:
                return [
                    SwiftUI.Gradient.Stop(color: Color(red: 0.87, green: 0.9, blue: 1), location: 0.00),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.68, green: 0.67, blue: 1), location: 0.46),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.48, green: 0.68, blue: 0.84), location: 1.00)
                ]
            case .gradientS4:
                return [
                    SwiftUI.Gradient.Stop(color: Color(red: 0.89, green: 0.85, blue: 1), location: 0.00),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.77, green: 0.58, blue: 1), location: 0.47),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.51, green: 0.55, blue: 0.89), location: 1.00)
                ]
            case .gradientS5:
                return [
                    SwiftUI.Gradient.Stop(color: Color(red: 0.95, green: 0.85, blue: 1), location: 0.00),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.86, green: 0.56, blue: 1), location: 0.41),
                    SwiftUI.Gradient.Stop(color: Color(red: 0.54, green: 0.41, blue: 0.95), location: 1.00)
                ]
            }
        }
        
        public var name: String {
            self.rawValue
        }
        
        public var startPont: UnitPoint {
            switch self {
            case .gradientS1:
                return UnitPoint(x: 0.01, y: 0.81)
            case .gradientS2:
                return UnitPoint(x: 0.01, y: 0.81)
            case .gradientS3:
                return UnitPoint(x: 0.01, y: 0.81)
            case .gradientS4:
                return UnitPoint(x: 0.01, y: 0.81)
            case .gradientS5:
                return UnitPoint(x: 0.04, y: 1)
            }
        }
        
        public var endtPont: UnitPoint {
            switch self {
            case .gradientS1:
                return UnitPoint(x: 0.72, y: 0.21)
            case .gradientS2:
                return UnitPoint(x: 0.72, y: 0.21)
            case .gradientS3:
                return UnitPoint(x: 0.72, y: 0.21)
            case .gradientS4:
                return UnitPoint(x: 0.72, y: 0.21)
            case .gradientS5:
                return UnitPoint(x: 0.66, y: 0)
            }
        }
        
        public var linearGradient: LinearGradient {
            LinearGradient(
                stops: self.stops,
                startPoint: self.startPont,
                endPoint: self.endtPont
            )
        }
    }
}
