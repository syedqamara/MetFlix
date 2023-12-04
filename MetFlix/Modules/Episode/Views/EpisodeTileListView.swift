//
//  EpisodeTileListView.swift
//  MetFlix
//
//  Created by Apple on 04/12/2023.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI

public struct EpisodeTileListView<VM: EpisodesViewModeling>: SwiftUIView {
    public typealias ViewModelType = VM
    @ObservedObject  var viewModel: VM
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    public var body: some View {
        ScrollView(.horizontal) {
            VStack {
                HStack(alignment: .top, spacing: .spacing(.medium)) {
                    if let episodes = viewModel.episodes?.data?.media {
                        ForEach(episodes) { episode in
                            EpisodesTileView(
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

struct EpisodeTileListView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<EpisodesApiData> {
        .init(
            configurations: [
                .init(name: "Preview", state: .preview),
                .init(name: "Preview 2", state: .preview2),
                .init(name: "Preview 3", state: .preview3)
            ]) { state in
                EpisodeTileListView(
                    viewModel: EpisodesViewModel(
                        episodes: .init(dataModel: state)
                    )
                )
                .padding(.vertical)
                .background(Color.appTheme)
                
            }
    }
}
