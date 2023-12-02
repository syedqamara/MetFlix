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

extension SwiftUIViewFactory: DependencyKey, TestDependencyKey {
    public static var liveValue: SwiftUIViewFactory = SwiftUIViewFactory()
    public static var testValue: SwiftUIViewFactory = SwiftUIViewFactory()
}

public extension DependencyValues {
    var viewFactory: SwiftUIViewFactory {
        get {
            self[SwiftUIViewFactory.self]
        }
        set {
            self[SwiftUIViewFactory.self] = newValue
        }
    }
}
