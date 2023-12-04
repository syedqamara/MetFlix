//
//  AnimatedView.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import Lottie
import SwiftUI

struct AnimatedView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    var size: CGSize
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.frame.size = size
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.frame.size = size
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

struct AnimatedView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedView(animationFileName: "loading_animation", loopMode: .loop, size: .init(width: 40, height: 40))
    }
}
