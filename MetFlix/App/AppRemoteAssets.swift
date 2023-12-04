//
//  AppRemoteAssets.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import Network

public enum AssetsEnpoint {
case png(String), json(String)
}

extension AssetsEnpoint: Pointable {
    public var pointing: String {
        switch self {
        case .png(let name):
            return name + ".png"
        case .json(let name):
            return name + ".json"
        }
    }
    
    public static var allCases: [AssetsEnpoint] {
        [
            .png("")
        ]
    }
    
    public var debugID: String { "debugging.id.\(pointing)" }
    public var configID: String { "configuration.id.\(pointing)" }
}

extension Cached {
    init(endpoint: AssetsEnpoint) {
        self.init(key: endpoint.pointing)
    }
}
