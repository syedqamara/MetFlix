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
    @Dependency(\.defaultNetwork) var network
    
    enum Errors: String, Error {
    case noInternet, invalidURL
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
            return try load(fileName: localPath)
        } else if Internet.isAvailable {
            guard let url = URL(string: urlString) else { throw Errors.invalidURL }
            let request = URLRequest(url: url)
            let response = try await URLSession.shared.data(for: request)
            let data = response.0
            let newFileName = "\(UUID().uuidString).png"
            _localPath.wrappedValue = newFileName
            save(fileName: newFileName, data: data)
            return data
        }
        throw Errors.noInternet
    }
}

extension MindValleyService {
    private func load(fileName: String) throws -> Data {
        var url = URL.temporaryDirectory
        url.append(component: fileName)
        return try Data(contentsOf: url)
    }
    private func save(fileName: String, data: Data?) {
        var url = URL.temporaryDirectory
        url.appendPathComponent(fileName)

        if let data = data {
            if FileManager.default.fileExists(atPath: url.path) {
                // Rule 3: Update the existing file with new data
                do {
                    try data.write(to: url, options: .atomic)
                    print("File updated successfully at: \(url)")
                } catch {
                    print("Error updating file: \(error.localizedDescription)")
                }
            } else {
                // Rule 2: Create a new file and save data
                do {
                    try data.write(to: url, options: .atomic)
                    print("File created and saved successfully at: \(url)")
                } catch {
                    print("Error creating and saving file: \(error.localizedDescription)")
                }
            }
        } else {
            if FileManager.default.fileExists(atPath: url.path) {
                // Rule 1: Remove the existing file if data is nil
                do {
                    try FileManager.default.removeItem(at: url)
                    print("File removed successfully at: \(url)")
                } catch {
                    print("Error removing file: \(error.localizedDescription)")
                }
            } else {
                print("No file exists at: \(url)")
            }
        }
    }
}
