//
//  HomeAbstract.swift
//  MetFlix
//
//  Created by Apple on 26/11/2023.
//

import Foundation
import core_architecture
import Network

// MARK: - UIModeling Protocol

/// A protocol for UI models in the MetFlix app.
public protocol UIModeling: UIModel where DataModelType: DataModel {
    
}

// MARK: - HomeViewModeling Protocol

/// A protocol for view models in the home section of the MetFlix app.
public protocol HomeViewModeling: ViewModeling {
    var sections: [HomeSectionUIM] { get set }
    func onAppear()
    func refresh()
}

// MARK: - HomeModuling Protocol

/// A protocol for modules in the home section of the MetFlix app.
public protocol HomeModuling: ViewModuling where ViewType: HomeViewProtocol {}

// MARK: - HomeViewProtocol Protocol

/// A protocol for views in the home section of the MetFlix app.
public protocol HomeViewProtocol: SwiftUIView where ViewModelType: HomeViewModeling {}

// MARK: - EpisodesModuling Protocol

/// A protocol for modules in the episodes section of the MetFlix app.
public protocol EpisodesModuling: ViewModuling where ViewType: EpisodesViewProtocol {}

// MARK: - EpisodesViewProtocol Protocol

/// A protocol for views in the episodes section of the MetFlix app.
public protocol EpisodesViewProtocol: SwiftUIView where ViewModelType: EpisodesViewModeling {}

// MARK: - EpisodesViewModeling Protocol

/// A protocol for view models in the episodes section of the MetFlix app.
public protocol EpisodesViewModeling: ViewModeling {
    var episodes: EpisodesDataUIM? { get }
}

// MARK: - CategoriesModuling Protocol

/// A protocol for modules in the categories section of the MetFlix app.
public protocol CategoriesModuling: ViewModuling where ViewType: CategoriesViewProtocol {}

// MARK: - CategoriesViewProtocol Protocol

/// A protocol for views in the categories section of the MetFlix app.
public protocol CategoriesViewProtocol: SwiftUIView where ViewModelType: CategoriesViewModeling {}

// MARK: - CategoriesViewModeling Protocol

/// A protocol for view models in the categories section of the MetFlix app.
public protocol CategoriesViewModeling: ViewModeling {
    var categories: CategoriesDataUIM? { get }
}

// MARK: - ChannelsModuling Protocol

/// A protocol for modules in the channels section of the MetFlix app.
public protocol ChannelsModuling: ViewModuling where ViewType: ChannelsViewProtocol {}

// MARK: - ChannelsViewProtocol Protocol

/// A protocol for views in the channels section of the MetFlix app.
public protocol ChannelsViewProtocol: SwiftUIView where ViewModelType: ChannelsViewModeling {}

// MARK: - ChannelsViewModeling Protocol

/// A protocol for view models in the channels section of the MetFlix app.
public protocol ChannelsViewModeling: ViewModeling {
    var channels: ChannelsDataUIM? { get }
}

// MARK: - Service Protocols

// MARK: ServiceProtocol Protocol

/// A generic protocol for service classes in the MetFlix app.
public protocol ServiceProtocol {
    
}

// MARK: MindValleyServiceProtocol Protocol

/// A protocol for MindValley services in the MetFlix app, extending the ServiceProtocol.
public protocol MindValleyServiceProtocol: ServiceProtocol {
    func serve<D: DataModel>(type: D.Type, dataModel: DataModel?, endpoint: Pointable) async throws -> D
}

// MARK: EpisodeServiceProtocol Protocol

/// A protocol for services providing episode-related data, extending the MindValleyServiceProtocol.
public protocol EpisodeServiceProtocol: MindValleyServiceProtocol {
    func episodes() async throws -> EpisodesApiData
}

// MARK: ChannelServiceProtocol Protocol

/// A protocol for services providing channel-related data, extending the MindValleyServiceProtocol.
public protocol ChannelServiceProtocol: MindValleyServiceProtocol {
    func channels() async throws -> ChannelsApiData
}

// MARK: CategoriesServiceProtocol Protocol

/// A protocol for services providing category-related data, extending the MindValleyServiceProtocol.
public protocol CategoriesServiceProtocol: MindValleyServiceProtocol {
    func categories() async throws -> CategoriesApiData
}

// MARK: ImageDownloadingProtocol Protocol

/// A protocol for services handling image downloading in the MetFlix app, extending the MindValleyServiceProtocol.
public protocol ImageDownloadingProtocol: MindValleyServiceProtocol {
    var maxRequest: Int { get set }
    func can(send url: String) -> Bool
    func image(for url: String) async throws -> Data
}

// MARK: CacheManagerProtocol Protocol

/// A protocol for cache managers in the MetFlix app.
public protocol CacheManagerProtocol {
    func insert<V>(value: V, for key: String)
    func remove(for key: String)
    func get<V>(valuefor key: String) -> V?
}

