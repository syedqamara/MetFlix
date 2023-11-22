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
    case home, breakpoint, debug(NetworkDebuggerActions)
    }
    func makeView(input: MetflixInput) -> any SwiftUIView {
        switch input {
        case .home:
            @Dependency(\.homeVM) var homeVM
            let module = HomeModule(input: .init(vm: homeVM))
            return module.view()
        case .breakpoint:
            return BreakpointConfigurationsModule(input: .init()).view()
        case .debug(let action):
            return NetworkDebugModule(input: action).view()
        }
    }
}



