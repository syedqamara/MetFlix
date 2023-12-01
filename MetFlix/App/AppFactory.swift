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
    case breakpoint, debug(NetworkDebuggerActions)
    }
    func makeView(input: MetflixInput) -> any SwiftUIView {
        switch input {
        case .breakpoint:
            return BreakpointConfigurationsModule(input: .init()).view()
        case .debug(let action):
            return NetworkDebugModule(input: action).view()
        }
    }
}

