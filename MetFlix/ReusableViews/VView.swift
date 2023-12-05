//
//  VView.swift
//  MetFlix
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import SwiftUI

public struct VView<Content: View>: View {
    private let content: Content
    private let spacing: CGFloat?
    private let alignment: HorizontalAlignment
    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
    public var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content
        }
    }
}
