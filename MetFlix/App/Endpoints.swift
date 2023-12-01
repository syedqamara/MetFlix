//
//  AppNetworking.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Network

public enum MindValleyEndpoints {
case episodes, channels, categories
}

extension MindValleyEndpoints: Pointable {
    public var pointing: String {
        switch self {
        case .episodes:
            return "z5AExTtw"
        case .channels:
            return "Xt12uVhM"
        case .categories:
            return "A0CgArX3"
        }
    }

    public static var allCases: [MindValleyEndpoints] {
        [
            .episodes,
            .channels,
            .categories
        ]
    }

    public var debugID: String { "debugging.id.\(pointing)" }
    public var configID: String { "configuration.id.\(pointing)" }
}

extension Cached {
    init(endpoint: MindValleyEndpoints) {
        self.init(key: endpoint.pointing)
    }
}
