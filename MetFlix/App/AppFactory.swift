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
    enum MetflixAppInput {
    case home
    }
    func makeView(input: MetflixAppInput) -> any SwiftUIView {
        switch input {
        case .home:
            return HomeModule(
                input: .init(
                    viewModel: HomeViewModel(
                        sections: [ ]
                    )
                )
            )
            .view()
        }
    }
}

