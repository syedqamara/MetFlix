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
    case home, movie(Int), breakpoint, debug(NetworkDebuggerActions)
    }
    func makeView(input: MetflixInput) -> any SwiftUIView {
        switch input {
        case .home:
            let module = HomeModule(input: .init(vm: HomeViewModel(moviesResult: nil)))
            return module.view()
        case .breakpoint:
            return BreakpointConfigurationsModule(input: .init()).view()
        case .debug(let action):
            return NetworkDebugModule(input: action).view()
        case .movie(let id):
            var movieDetailVM = MovieDetailViewModel(movieDetail: nil, movieId: 0)
            movieDetailVM.movieId = id
            let module = MovieDetailModule(input: .init(movieId: id, vm: movieDetailVM))
            return module.view()
        }
    }
}

