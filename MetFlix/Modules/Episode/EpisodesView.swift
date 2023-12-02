//
//  EpisodesView.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI

public struct EpisodesView<VM: EpisodesViewModeling>: SwiftUIView {
    public typealias ViewModelType = VM
    @ObservedObject var viewModel: VM
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack(alignment: .leading) {
            if viewModel.episodes == nil {
                AnimatedView(
                    animationFileName: Config.Lottie.loadingAnimation,
                    loopMode: .loop,
                    size: .init(width: 100, height: 100)
                )
            } else {
                HStack {
                    Text("New Episodes")
                        .robotoFont(style: .black(.headline))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top)
                EpisodeTileListView(viewModel: viewModel)
            }
        }
        .padding(.horizontal)
    }
}

private struct EpisodeTileListView<VM: EpisodesViewModeling>: SwiftUIView {
    typealias ViewModelType = VM
    @ObservedObject var viewModel: VM
    init(viewModel: VM) {
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack(alignment: .top, spacing: .spacing(.medium)) {
                    if let episodes = viewModel.episodes?.data?.media {
                        ForEach(episodes) { episode in
                            EpisdoesTileView(
                                episode: episode
                            )
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct EpisdoesTileView: View {
    var episode: EpisodeMediaUIM
    let width = UIScreen.main.bounds.size.width / 2
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing(.medium)) {
            if let url = episode.coverAsset?.url {
                RemoteImage(
                    url: url,
                    lottiePlaceholder: Config.Lottie.loadingAnimation,
                    size: .init(
                        width: width,
                        height: width * 1.5
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .id(url)
                .frame(
                    width: width,
                    height: width * 1.5
                )
            }
            VStack(alignment: .leading, spacing: .spacing(.small)) {
                if let title = episode.title {
                    Text(title)
                        .robotoFont(style: .medium(.subtitle))
                        .foregroundColor(.white)
                }
                if let channel = episode.channel?.title {
                    Text(channel)
                        .lineLimit(1)
                        .robotoFont(style: .regular(.small))
                        .foregroundColor(.gray)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: width)
    }
}

struct EpisodesTileView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    static var previews: some View {
        EpisdoesTileView(
            episode: .init(
                dataModel: .preview
            )
        )
        .background(Color.appTheme)
    }
}
struct EpisodesView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    static var previews: some View {
        AnyView(
            viewFactory.makeView(
                input: .episodes(
                    .init(
                        dataModel: .preview
                    )
                )
            )
        )
        .background(Color.appTheme)
    }
}
