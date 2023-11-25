//
//  ErrorView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import SwiftUI
import Lottie

enum PlaceholderUIM {
    case error(String), noResult(String)
    var animationFileName: String {
        switch self {
        case .error(_):
            return Config.Lottie.errorAnimation
        case .noResult(_):
            return Config.Lottie.noResultAnimation
        }
    }
}


struct PlaceholderView: View {
    var placeholder: PlaceholderUIM

    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.top, 16)
            Text(subtitleText)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top, 8)
            AnimatedView(
                animationFileName: placeholder.animationFileName,
                loopMode: .loop,
                size: .init(
                    width: 100,
                    height: 100
                )
            )
            .scaleEffect(.init(width: 0.5, height: 0.5))
            .frame(maxHeight: 200)
        }
        .padding()
        .background(Color.black.ignoresSafeArea(.all, edges: [.top, .bottom]))
    }

    private var titleText: String {
        switch placeholder {
        case .error:
            return "Error"
        case .noResult:
            return "No Result Found"
        }
    }

    private var subtitleText: String {
        switch placeholder {
        case .error(let message), .noResult(let message):
            return message
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(placeholder: .error("Failed to load data"))
            .previewLayout(.device)
    }
}
