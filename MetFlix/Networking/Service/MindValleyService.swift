//
//  MindValleyService.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation
import Dependencies
import Network
import core_architecture

class MindValleyService {
    @Dependency(\.defaultNetwork) var network
    
    enum Errors: String, Error {
    case noInternet
    }
    // Generic Get Method
    private func `get`<D: DataModel>(type: D.Type, dataModel: DataModel? = nil, endpoint: MindValleyEndpoints) async throws -> D {
        @Cached<D>(endpoint: .episodes) var cached
        if Internet.isAvailable {
            let data = try await network.send(to: endpoint, with: dataModel, type: type)
            _cached.wrappedValue = data
            return data
        }
        else if let cached {
            return cached
        }
        throw Errors.noInternet
    }
}


extension MindValleyService: EpisodeServiceProtocol {
    func episodes() async throws -> EpisodesApiData {
        try await get(type: EpisodesApiData.self, endpoint: .episodes)
    }
}

extension MindValleyService: ChannelServiceProtocol {
    func channels() async throws -> ChannelsApiData {
        try await get(type: ChannelsApiData.self, endpoint: .channels)
    }
}
extension MindValleyService: CategoriesServiceProtocol {
    func categories() async throws -> CategoriesApiData {
        try await get(type: CategoriesApiData.self, endpoint: .categories)
    }
}
