//
//  View+Extension.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import Foundation
import SwiftUI

extension View {
    // Custom tag view style
    func tagViewStyle() -> some View {
        self
            .foregroundColor(.white)
            .padding(8)
            .background(Color.red)
            .cornerRadius(8)
            .shadow(color: .red, radius: 5)
    }
}
