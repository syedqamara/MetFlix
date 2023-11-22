//
//  Home+Dependencies.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import Dependencies

public enum HomeDependency: DependencyKey {
    public static var liveValue: HomeViewModel { HomeViewModel() }
}

extension DependencyValues {
    public var homeVM: HomeViewModel {
        get {
            self[HomeDependency.self]
        }
        set {
            self[HomeDependency.self] = newValue
        }
    }
}
