//
//  HomeAbstract.swift
//  MetFlix
//
//  Created by Apple on 26/11/2023.
//

import Foundation
import core_architecture

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
    var error: Error? { get }
    var isLoading: Bool { get }
    var search: String { get set }
//    var movies: [MovieUIM] { get set }
    
    func onAppear()
    func loadNextPage()
}


/**
 A protocol representing the view for the Home module in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `SwiftUIView` protocol.
 */
public protocol HomeViewProtocol: SwiftUIView {
    
}


// MARK: - Movie Detail Module Abstracts

/**
 A protocol representing the view for the Movie Detail module in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `SwiftUIView` protocol.
 */
public protocol MovieDetailViewProtocol: SwiftUIView {
    
}

/**
 A protocol defining the view model for the Movie Detail module in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s `ViewModeling` protocol.
 */
public protocol MovieDetailViewModeling: ViewModeling {
    var movieId: Int { get set }
//    var movieDetail: MovieDetailUIM? { get set }
    var error: Error? { get }
    var isLoading: Bool { get }
    func onAppear()
}


// MARK: - Movie Service Abstract

/**
 A protocol defining the services for movie-related operations in the MetFlix application.
 
 - Note: Conforms to `core_architecture`'s service protocol with asynchronous methods.
 */
public protocol MindValleyServiceProtocol {}

public protocol EpisodeServiceProtocol: MindValleyServiceProtocol {
    func episodes() async throws -> EpisodesApiData
}
public protocol ChannelServiceProtocol: MindValleyServiceProtocol {
    func channels()  async throws-> ChannelsApiData
}
public protocol CategoriesServiceProtocol: MindValleyServiceProtocol {
    func categories() async throws -> CategoriesApiData
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

