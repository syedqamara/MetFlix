//
//  LineView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import SwiftUI

struct LineView: View {
    var color: Color
    var lineHeight: CGFloat

    init(color: Color, lineHeight: CGFloat) {
        self.color = color
        self.lineHeight = lineHeight
    }

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: lineHeight)
                .foregroundColor(color)
                .shadow(color: color, radius: 3, x: 0, y: 2)
        }
    }
}
