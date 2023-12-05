//
//  Color+Extension.swift
//  MetFlix
//
//  Created by Apple on 04/12/2023.
//

import Foundation
import SwiftUI

extension Color {
    static var appTheme: Color {
        "23272F".color
    }
    static var appThemeSecondary: Color {
        "95989D".color
    }
    static var categoriesTagColor: Color {
        appThemeSecondary.opacity(0.2)
    }
    static var separatorColor: Color {
        "3C434E".color
    }
}

extension UIColor {
    static public var appThemeUI: UIColor {
        "23272F".uiColor
    }
}
