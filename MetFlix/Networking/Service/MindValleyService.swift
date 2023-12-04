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
    private let fileService = MindValleyFileService()
    @Dependency(\.defaultNetwork) var network
    
    enum Errors: String, Error {
    case noInternet, invalidURL, invalidStatusCode
    }
    // Generic Get Method
    public func serve<D: DataModel>(type: D.Type, dataModel: DataModel? = nil, endpoint: Pointable) async throws -> D {
        @Cached<D>(key: endpoint.pointing) var cached
        @Cached<String>(key: endpoint.pointing) var fileNameCache
        if Internet.isAvailable {
            let dataModel = try await network.send(to: endpoint, with: dataModel, type: type)
            _cached.wrappedValue = dataModel
            let fileData = try JSONEncoder().encode(dataModel).base64EncodedData(options: .lineLength76Characters)
            let fileName = UUID().uuidString
            _fileNameCache.wrappedValue = fileName
            fileService.save(fileName: .json(fileName), data: fileData)
            return dataModel
        } else if let cached {
            return cached
        } else if let fileName = fileNameCache {
            let fileData = try fileService.load(fileName: .json(fileName))
            let dataModel = try JSONDecoder().decode(type, from: fileData)
            _cached.wrappedValue = dataModel
            return dataModel
        }
        throw Errors.noInternet
    }
}


extension MindValleyService: EpisodeServiceProtocol {
    func episodes() async throws -> EpisodesApiData {
        try await serve(type: EpisodesApiData.self, endpoint: MindValleyEndpoints.episodes)
    }
}

extension MindValleyService: ChannelServiceProtocol {
    func channels() async throws -> ChannelsApiData {
        try await serve(type: ChannelsApiData.self, endpoint: MindValleyEndpoints.channels)
    }
}
extension MindValleyService: CategoriesServiceProtocol {
    func categories() async throws -> CategoriesApiData {
        try await serve(type: CategoriesApiData.self, endpoint: MindValleyEndpoints.categories)
    }
}
extension MindValleyService: ImageDownloadingProtocol {
    func image(for urlString: String) async throws -> Data {
        @Cached<String>(key: urlString) var localPath
        if let localPath {
            return try fileService.load(fileName: .png(localPath))
        } else if Internet.isAvailable {
            guard let url = URL(string: urlString) else { throw Errors.invalidURL }
            let request = URLRequest(url: url)
            let response = try await URLSession.shared.data(for: request)
            guard let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 204 else {
                throw Errors.invalidStatusCode
            }
            let data = response.0
            let newFileName = UUID().uuidString
            _localPath.wrappedValue = newFileName
            fileService.save(fileName: .png(newFileName), data: data)
            return data
        }
        throw Errors.noInternet
    }
}

private class MindValleyFileService: ServiceProtocol {
    private let queue: DispatchQueue = .init(label: "com.cache.file.queue", qos: .background)
    func load(fileName: AssetsEnpoint) throws -> Data {
        try queue.sync {
            var url = URL.documentsDirectory
            url.append(component: fileName.pointing)
            @Cached<Data>(endpoint: fileName) var imageData
            if let imageData {
                return imageData
            }
            return try Data(contentsOf: url)
        }
    }
    func save(fileName: AssetsEnpoint, data: Data?) {
        queue.sync(flags: .barrier) {
            do {
                @Cached<Data>(endpoint: fileName) var imageData
                let cacheDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url = cacheDirectory.appendingPathComponent(fileName.pointing)
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
