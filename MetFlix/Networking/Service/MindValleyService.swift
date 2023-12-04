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

class MindValleyService: MindValleyServiceProtocol {
    private let imageService = MindValleyImageService()
    @Dependency(\.defaultNetwork) var network
    
    enum Errors: String, Error {
    case noInternet, invalidURL, invalidStatusCode
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


extension MindValleyService {
    func episodes() async throws -> EpisodesApiData {
        try await get(type: EpisodesApiData.self, endpoint: .episodes)
    }
}

extension MindValleyService {
    func channels() async throws -> ChannelsApiData {
        try await get(type: ChannelsApiData.self, endpoint: .channels)
    }
}
extension MindValleyService {
    func categories() async throws -> CategoriesApiData {
        try await get(type: CategoriesApiData.self, endpoint: .categories)
    }
}
extension MindValleyService {
    func image(for urlString: String) async throws -> Data {
        @Cached<String>(key: urlString) var localPath
        if let localPath {
            return try imageService.load(fileName: localPath)
        } else if Internet.isAvailable {
            guard let url = URL(string: urlString) else { throw Errors.invalidURL }
            let request = URLRequest(url: url)
            let response = try await URLSession.shared.data(for: request)
            guard let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 204 else {
                throw Errors.invalidStatusCode
            }
            let data = response.0
            let newFileName = "\(UUID().uuidString).png"
            _localPath.wrappedValue = newFileName
            imageService.save(fileName: newFileName, data: data)
            return data
        }
        throw Errors.noInternet
    }
}

extension MindValleyService {
    
}

private class MindValleyImageService {
    private let queue: DispatchQueue = .init(label: "com.cache.image.queue", qos: .background)
    func load(fileName: String) throws -> Data {
        try queue.sync {
            var url = URL.documentsDirectory
            url.append(component: fileName)
            @Configuration<Data>(fileName) var imageData
            if let imageData {
                return imageData
            }
            return try Data(contentsOf: url)
        }
    }
    func save(fileName: String, data: Data?) {
        queue.sync(flags: .barrier) {
            do {
                @Configuration<Data>(fileName) var imageData
                let cacheDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url = cacheDirectory.appendingPathComponent(fileName)
                imageData = data
                if let data = data {
                    if FileManager.default.fileExists(atPath: url.path) {
                        try data.write(to: url, options: .atomic)
                    } else {
                        try data.write(to: url, options: .atomic)
                    }
                } else {
                    if FileManager.default.fileExists(atPath: url.path) {
                        // Rule 1: Remove the existing file if data is nil
                        try FileManager.default.removeItem(at: url)
                    } else {
                        print("No file exists at: \(url)")
                    }
                }
            } catch {
                print("Error getting cache directory: \(error.localizedDescription)")
            }
        }
    }

}
