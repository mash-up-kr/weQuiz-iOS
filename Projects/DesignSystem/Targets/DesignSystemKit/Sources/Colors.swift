//
//  Colors.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

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
        
        case main
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
                
        public var name: String {
            self.rawValue
        }
    }
}
