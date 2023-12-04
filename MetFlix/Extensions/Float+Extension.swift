//
//  Float+Extension.swift
//  MetFlix
//
//  Created by Apple on 04/12/2023.
//

import Foundation
extension CGFloat {
    #if os(iOS)
    public enum Spacing: CGFloat {
        case xLarge = 30
        case large = 25
        case medium = 20
        case normal = 15
        case small = 10
        case xSmall = 5
    }
    #else
    public enum Spacing: CGFloat {
        case xLarge = 40
        case large = 30
        case medium = 25
        case normal = 20
        case small = 15
        case xSmall = 10
    }
    #endif
    static public func spacing(_ space: Spacing) -> CGFloat {
        return space.rawValue
    }
}
