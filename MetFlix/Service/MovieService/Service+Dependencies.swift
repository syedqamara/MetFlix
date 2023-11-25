//
//  Service+Dependencies.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import Dependencies

public enum MovieServiceDependency: DependencyKey {
    public static var liveValue: MovieServiceProtocol { MovieService() }
}

extension DependencyValues {
    public var movieService: MovieServiceProtocol {
        get {
            self[MovieServiceDependency.self]
        }
        set {
            self[MovieServiceDependency.self] = newValue
        }
    }
}
