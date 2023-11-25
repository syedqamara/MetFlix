//
//  RemoteImageView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

public struct RemoteImageView: View {
    public let image: String
    public let lottiePlaceholder: String
    public let lottieError: String
    public let overlayColor: Color
    public let size: CGSize
    @Binding var isDownloaded: Bool
    
    init(image: String, lottiePlaceholder: String, lottieError: String, overlayColor: Color = .clear, size: CGSize, isDownloaded: Binding<Bool> = .constant(false)) {
        self.image = image
        self.lottiePlaceholder = lottiePlaceholder
        self.lottieError = lottieError
        self.overlayColor = overlayColor
        self.size = size
        _isDownloaded = isDownloaded
    }
    
    public var body: some View {
        if let url = URL(string: image) {
            WebImage(url: url)
                .placeholder {
                    animationView {
                        AnimatedView(animationFileName: lottiePlaceholder, loopMode: .loop, size: size)
                            .frame(width: size.width, height: size.height)
                    }
                    .frame(maxHeight: Double.greatestFiniteMagnitude)
                }
                .onSuccess() { arg, arg1, arg2  in
                    isDownloaded = true
                }
                .resizable()
                .clipped(antialiased: false)
                .padding(0)
                .aspectRatio(contentMode: .fill)
                .overlay(isDownloaded ? overlayColor : .clear)
                .id(image)
        }
        else {
            animationView {
                AnimatedView(animationFileName: lottieError, loopMode: .loop, size: size)
            }
        }
    }
    
    @ViewBuilder
    func animationView(completion: () -> some View) -> some View {
        VStack(alignment: .center) {
            completion()
        }
        .background(Color.black)
        .padding(0)
    }
}