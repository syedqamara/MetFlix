//
//  HView.swift
//  MetFlix
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import SwiftUI

public struct HView<Content: View>: View {
    private let content: Content
    private let spacing: CGFloat?
    private let alignment: VerticalAlignment
    public init(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    public var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            content
        }
    }
}
