//
//  HomeModule.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies

public struct HomeModule<V: HomeViewModeling>: ViewModuling {
    public typealias ViewType = HomeView<V>
    public struct ModuleInput: ModulingInput {
        let vm: V
    }
    private let input: ModuleInput
    
    public init(input: ModuleInput) {
        self.input = input
    }
    
    public func view() -> HomeView<V> {
        HomeView(viewModel: input.vm)
    }
}
