//
//  Deocding+Bool.swift
//  MetFlix
//
//  Created by Apple on 26/11/2023.
//

import Foundation
import SwiftUI

extension KeyedDecodingContainer {
    func decodeCustomBool(key: K) throws -> Bool {
        do {
            return try decode(Bool.self, forKey: key)
        } catch DecodingError.typeMismatch {
            // If a type mismatch occurs, try decoding as Int and convert to Bool
            let intValue = try decode(Int.self, forKey: key)
            return intValue != 0
        }
    }
}

extension CGFloat {
    public enum Spacing: CGFloat {
        case xLarge = 30
        case large = 25
        case medium = 20
        case normal = 15
        case small = 10
        case xSmall = 5
    }
    static public func spacing(_ space: Spacing) -> CGFloat {
        return space.rawValue
    }
}
extension String {
    var color: Color {
        var formattedHex = trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")

        var hex: UInt64 = 0

        guard Scanner(string: formattedHex).scanHexInt64(&hex) else {
            return .black
        }

        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
    var uiColor: UIColor {
        var formattedHex = trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")

        var hex: UInt64 = 0

        guard Scanner(string: formattedHex).scanHexInt64(&hex) else {
            return .black
        }

        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
extension Color {
    static var appTheme: Color {
        "23272F".color
    }
}

extension UIColor {
    static public var appThemeUI: UIColor {
        "23272F".uiColor
    }
}
