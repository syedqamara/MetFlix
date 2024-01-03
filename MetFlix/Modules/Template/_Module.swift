//
//  _Module.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture

struct _Module<V: _ViewModeling>: ViewModuling {
    typealias ViewType = _View<V>
    private let input: ModuleInput
    init(input: ModuleInput) {
        self.input = input
    }
}

extension _Module {
    struct ModuleInput: ModulingInput {
        let viewModel: V
    }
    
    func view() -> _View<V> {
        _View(
            viewModel: input.viewModel
        )
    }
}
