//
//  Factory+Dependencies.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies
import Network

extension SwiftUIViewFactory: DependencyKey {
    public static var liveValue: SwiftUIViewFactory = SwiftUIViewFactory()
}

extension DependencyValues {
    public var viewFactory: SwiftUIViewFactory {
        get {
            self[SwiftUIViewFactory.self]
        }
        set {
            self[SwiftUIViewFactory.self] = newValue
        }
    }
}
