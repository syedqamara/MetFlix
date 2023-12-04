//
//  EpisodesTileView.swift
//  MetFlix
//
//  Created by Apple on 04/12/2023.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI

struct EpisodesTileView: View {
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
                    ),
                    scale: 0.5
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .id(url)
                .frame(
                    width: width,
                    height: width * 1.5
                )
                .background(Color.categoriesTagColor)
            }
            VStack(alignment: .leading, spacing: .spacing(.small)) {
                if let title = episode.title {
                    Text(title)
                        .robotoFont(style: .medium(.small))
                        .foregroundColor(.white)
                }
                if let channel = episode.channel?.title {
                    Text(channel)
                        .lineLimit(1)
                        .robotoFont(style: .regular(.xSmall))
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
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<EpisodeMedia> {
        .init(
            configurations: [
                .init(name: "Preview", state: .preview),
                .init(name: "Preview 2", state: .preview2),
                .init(name: "Preview 3", state: .preview3)
            ]) { state in
                EpisodesTileView(
                    episode: .init(
                        dataModel: state
                    )
                )
                .background(Color.appTheme)
            }
    }
}
