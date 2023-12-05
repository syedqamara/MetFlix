//
//  RemoteImageView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import SwiftUI
import core_architecture
import Dependencies

typealias RemoteImage = RemoteImageView<RemoteImageViewModel>

public struct RemoteImageView<VM: RemoteImageViewModeling>: View {
    public let lottiePlaceholder: String
    public let overlayColor: Color
    public let size: CGSize
    public let scale: CGFloat
    @State private var isAppeared: Bool = false
    @ObservedObject var viewModel: VM
    init(url: String, lottiePlaceholder: String, overlayColor: Color = .appTheme, size: CGSize, scale: CGFloat = 1, isDownloaded: Binding<Bool> = .constant(false)) {
        self.lottiePlaceholder = lottiePlaceholder
        self.overlayColor = overlayColor
        self.size = size
        self.viewModel = VM(url: url)
        self.scale = scale
    }
    public var body: some View {
        VView {
            if isAppeared {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(viewModel.isLoading ? .clear : overlayColor.opacity(0.25))
                        .frame(minWidth: size.width)
                        .clipped()
                        .padding(0)
                }
                else if viewModel.isLoading {
                    if lottiePlaceholder.isNotEmpty {
                        AnimatedView(
                            animationFileName: lottiePlaceholder,
                            loopMode: .loop,
                            size: .init(
                                width: size.width / 2,
                                height: size.height / 2
                            )
                        )
                        .scaleEffect(.init(width: scale, height: scale), anchor: .center)
                        .fixedSize()
                    } else {
                        if #available(iOS 14.0, *) {
                            ProgressView {
                                
                            }
                        }
                    }
                }
                else {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: size.width)
                        .clipped()
                        .padding(0)
                }
            }
        }
        .onAppear() {
            isAppeared = true
            viewModel.onAppear()
        }
    }
}
struct AnyShape<S: Shape>: Shape {
    var shape: S
    init(_ shape: S) {
        self.shape = shape
    }
    func path(in rect: CGRect) -> Path {
        return shape.path(in: rect)
    }
}


struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(
            url: "https://assets.mindvalley.com/api/v1/assets/cb8c79d9-af35-4727-9c4c-6e9eee5af1c3.jpg?transform=w_1080&param1=2",
            lottiePlaceholder: Config.Lottie.loadingAnimation,
            size: .init(width: 100, height: 100)
        )
    }
}
