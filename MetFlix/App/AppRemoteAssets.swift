//
//  AppRemoteAssets.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import Network

public enum MoviesAssetsEnpoint {
case image(String)
}

extension MoviesAssetsEnpoint: Pointable {
    public var pointing: String {
        switch self {
        case .image(let name):
            return name
        }
    }
    
    public static var allCases: [MoviesAssetsEnpoint] {
        [
            .image("")
        ]
    }
    
    public var debugID: String { "debugging.id.\(pointing)" }
    public var configID: String { "configuration.id.\(pointing)" }
}

extension Cached {
    init(endpoint: MoviesAssetsEnpoint) {
        self.init(key: endpoint.pointing)
    }
}
