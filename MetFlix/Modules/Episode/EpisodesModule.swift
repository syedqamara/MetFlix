//
//  EpisodesModule.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture

struct EpisodesModule<VM: EpisodesViewModeling>: ViewModuling {
    typealias ViewType = EpisodesView<VM>
    struct ModuleInput: ModulingInput {
        let viewModel: VM
    }
    private let input: ModuleInput
    init(input: ModuleInput) {
        self.input = input
    }
    func view() -> EpisodesView<VM> {
        EpisodesView(
            viewModel: input.viewModel
        )
    }
}
