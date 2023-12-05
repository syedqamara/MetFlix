//
//  HomeAbstract.swift
//  MetFlix
//
//  Created by Apple on 26/11/2023.
//

import Foundation
import core_architecture
import Network

// MARK: - App Abstracts

/**
 A protocol representing the UI model for views in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `UIModel` protocol with associated type `DataModelType` restricted to `DataModel`.
 */
public protocol UIModeling: UIModel where DataModelType: DataModel {
    
}


// MARK: - Home Module Abstracts

/**
 A protocol defining the view model for the Home module in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `ViewModeling` protocol.
 */
public protocol HomeViewModeling: ViewModeling {
    var sections: [HomeSectionUIM] { get set }
    func onAppear()
    func refresh()
}


/**
 A protocol representing the view for the Home module in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `SwiftUIView` protocol.
 */
public protocol HomeModuling: ViewModuling where ViewType: HomeViewProtocol {}
public protocol HomeViewProtocol: SwiftUIView where ViewModelType: HomeViewModeling {}

public protocol EpisodesModuling: ViewModuling where ViewType: EpisodesViewProtocol {}
public protocol EpisodesViewProtocol: SwiftUIView where ViewModelType: EpisodesViewModeling {}
public protocol EpisodesViewModeling: ViewModeling {
    var episodes: EpisodesDataUIM? { get }
}

public protocol CategoriesModuling: ViewModuling where ViewType: CategoriesViewProtocol {}
public protocol CategoriesViewProtocol: SwiftUIView where ViewModelType: CategoriesViewModeling {}
public protocol CategoriesViewModeling: ViewModeling {
    var categories: CategoriesDataUIM? { get }
}

// For Modules
public protocol ChannelsModuling: ViewModuling where ViewType: ChannelsViewProtocol {}
// For Views
public protocol ChannelsViewProtocol: SwiftUIView where ViewModelType: ChannelsViewModeling {}
// For ViewModels
public protocol ChannelsViewModeling: ViewModeling {
    var channels: ChannelsDataUIM? { get }
}

// MARK: - Service Abstract

/**
 A protocol defining the services for movie-related operations in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s service protocol with asynchronous methods.
 */

public protocol ServiceProtocol {
    
}

public protocol MindValleyServiceProtocol: ServiceProtocol {
    func serve<D: DataModel>(type: D.Type, dataModel: DataModel?, endpoint: Pointable) async throws -> D
}

public protocol EpisodeServiceProtocol: MindValleyServiceProtocol {
    func episodes() async throws -> EpisodesApiData
}
public protocol ChannelServiceProtocol: MindValleyServiceProtocol {
    func channels()  async throws-> ChannelsApiData
}
public protocol CategoriesServiceProtocol: MindValleyServiceProtocol {
    func categories() async throws -> CategoriesApiData
}
public protocol ImageDownloadingProtocol: MindValleyServiceProtocol {
    var maxRequest: Int { get set }
    func can(send url: String) -> Bool
    func image(for url: String) async throws -> Data
}


// MARK: - Cache Manager Abstract

/**
 A protocol defining the cache management operations for the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s cache manager protocol.
 */
protocol CacheManagerProtocol {
    func insert<V>(value: V, for key: String)
    func remove(for key: String)
    func get<V>(valuefor key: String) -> V?
}

