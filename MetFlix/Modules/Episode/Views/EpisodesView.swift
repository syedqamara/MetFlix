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
        VView(alignment: .leading) {
            if viewModel.episodes == nil {
                AnimatedView(
                    animationFileName: Config.Lottie.loadingAnimation,
                    loopMode: .loop,
                    size: .init(width: 100, height: 100)
                )
                .scaleEffect(.init(width: 0.5, height: 0.5), anchor: .center)
            } else {
                HView {
                    Text("New Episodes")
                        .robotoFont(style: .black(.headline))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top)
                EpisodeTileListView(viewModel: viewModel)
                SeparatorView()
            }
        }
        .padding(.horizontal)
    }
}


struct EpisodesView_Previews: PreviewProvider {
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
                AnyView(
                    viewFactory.makeView(
                        input: .episodes(
                            .init(
                                dataModel: state
                            )
                        )
                    )
                )
                .background(Color.appTheme)
            }
    }
}
