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
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}

struct AnimatedView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedView(animationFileName: "image_loading", loopMode: .loop)
    }
}
