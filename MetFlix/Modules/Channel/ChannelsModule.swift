//
//  ChannelsModule.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import core_architecture

public struct ChannelsModule<VM: ChannelsViewModeling>: ViewModuling {
    public typealias ViewType = ChannelsView<VM>
    public struct ModuleInput: ModulingInput {
        public let vm: VM
        public init(vm: VM) {
            self.vm = vm
        }
    }
    private let input: ModuleInput
    public init(input: ModuleInput) {
        self.input = input
    }
    public func view() -> ChannelsView<VM> {
        .init(
            viewModel: input.vm
        )
    }
}
