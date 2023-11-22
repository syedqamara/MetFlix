//
//  MovieDetail+Dependencies.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import Dependencies

public enum MovieDetailDependency: DependencyKey {
    public static var liveValue: MovieDetailViewModel { MovieDetailViewModel() }
}

extension DependencyValues {
    public var movieDetailVM: MovieDetailViewModel {
        get {
            self[MovieDetailDependency.self]
        }
        set {
            self[MovieDetailDependency.self] = newValue
        }
    }
}
