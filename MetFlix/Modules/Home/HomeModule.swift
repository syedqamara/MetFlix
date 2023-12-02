//
//  HomeModule.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture

struct HomeModule<V: HomeViewModeling>: ViewModuling {
    typealias ViewType = HomeView<V>
    private let input: ModuleInput
    init(input: ModuleInput) {
        self.input = input
    }
}

extension HomeModule {
    struct ModuleInput: ModulingInput {
        let viewModel: V
    }
    
    func view() -> HomeView<V> {
        HomeView(
            viewModel: input.viewModel
        )
    }
}
