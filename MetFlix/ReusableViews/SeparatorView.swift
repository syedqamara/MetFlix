//
//  SeparatorView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .fill(Color.separatorColor)
            .frame(height: 1)
            .padding()
    }
}

