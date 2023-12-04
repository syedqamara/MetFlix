//
//  Shake.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import UIKit
import DebuggerUI

extension DebugUITheme.NetworkDebugModule.KeyValue {
    public static var appTheme: DebugUITheme.NetworkDebugModule.KeyValue {
        .init(
            borderColor: .appThemeSecondary,
            backgroundColor: .appTheme,
            keyTiteColor: .white,
            valueTiteColor: .appThemeSecondary,
            
            navigationTitleFont: .title.bold(),
            headerTitleFont: .subheadline.bold(),
            keyTitleFont: .caption.bold(),
            valueTitleFont: .caption.bold(),
            
            headerPadding: 5,
            keyPadding: 5,
            valuePadding: 5,
            
            headerHeight: 30,
            jsonContentHeight: 20,
            
            radius: 10
        )
    }
}
