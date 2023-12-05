//
//  String+Extension.swift
//  MetFlix
//
//  Created by Apple on 04/12/2023.
//

import Foundation
import SwiftUI

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
