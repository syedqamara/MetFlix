//
//  CardCarouselView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import Foundation
import SwiftUI

struct CardCarouselView: View {
    @State private var isExpanded: Bool = false
    var companies: [ProductionCompanyUIM]
    public init(companies: [ProductionCompanyUIM] = []) {
        self.companies = companies
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Production Companies")
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: isExpanded ? "arrow.down.circle.fill" : "arrow.down.circle")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            .padding(.horizontal)
            if isExpanded {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(companies) { company in
                            CardView(company: company)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
}
