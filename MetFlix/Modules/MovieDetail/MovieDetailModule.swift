//
//  MovieDetailModule.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies

public struct MovieDetailModule<V: MovieDetailViewModeling>: ViewModuling {
    public typealias ViewType = MovieDetailView<V>
    public struct ModuleInput: ModulingInput {
        let movieId: Int
        let vm: V
    }
    private let input: ModuleInput
    
    public init(input: ModuleInput) {
        self.input = input
    }
    
    public func view() -> MovieDetailView<V> {
        MovieDetailView(viewModel: input.vm)
    }
}
