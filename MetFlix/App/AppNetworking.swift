//
//  AppNetworking.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Network

public enum MoviesEnpoint {
case popular, movie(String)
}

extension MoviesEnpoint: Pointable {
    public var pointing: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .movie(let id):
            return "movie/\(id)"
        }
    }
    
    public static var allCases: [MoviesEnpoint] {
        [
            .popular,
            .movie("")
        ]
    }
    
    public var debugID: String { "debugging.id.\(pointing)" }
    public var configID: String { "configuration.id.\(pointing)" }
}

extension Cached {
    init(endpoint: MoviesEnpoint) {
        self.init(key: endpoint.pointing)
    }
}
