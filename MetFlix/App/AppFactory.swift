//
//  AppFactory.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies
import Debugger
import DebuggerUI

extension SwiftUIViewFactory {
    enum MetflixInput {
    case home, episodes(EpisodesDataUIM?), channels(ChannelsDataUIM?), categories(CategoriesDataUIM?), breakpoint, debug(NetworkDebuggerActions)
    }
    func makeView(input: MetflixInput) -> any SwiftUIView {
        switch input {
        case .home:
            return HomeModule(
                input: .init(
                    viewModel: HomeViewModel(
                        sections: [
                            .episodes(nil),
                            .channels(nil),
                            .categories(nil)
                        ]
                    )
                )
            )
            .view()
        case .channels(let channels):
            return ChannelsModule(
                input: .init(
                    vm: ChannelsViewModel(
                        channels: channels
                    )
                )
            )
            .view()
        case .categories(let categories):
            return CategoriesModule(
                input: .init(
                    vm: CategoriesViewModel(
                        categories: categories
                    )
                )
            )
            .view()
        case .episodes(let episodes):
            return EpisodesModule(
                input: .init(
                    viewModel: EpisodesViewModel(episodes: episodes)
                )
            )
            .view()
        case .breakpoint:
            return BreakpointConfigurationsModule(input: .init()).view()
        case .debug(let action):
            return NetworkDebugModule(input: action).view()
        }
    }
}

