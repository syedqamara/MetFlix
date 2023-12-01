//
//  Mocks.swift
//  MetFlixTests
//
//  Created by Apple on 26/11/2023.
//

import Foundation

// MARK: - Mocks

/**
 A mock implementation for the HomeViewModeling protocol.
 */
class MockHomeViewModeling: HomeViewModeling {
    @Published var error: Error?
    @Published var isLoading: Bool = false
    @Published var search: String = ""
//    @Published var movies: [MovieUIM] = []
    
    func onAppear() {}
    
    func loadNextPage() {}
}
/**
 A mock implementation for the MovieDetailViewModeling protocol.
 */
class MockMovieDetailViewModeling: MovieDetailViewModeling {
    @Published var movieId: Int = 0
//    @Published var movieDetail: MovieDetailUIM?
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    func onAppear() {}
}

/**
 A mock implementation for the MovieServiceProtocol protocol.
 */

public class MockFunctionArgument<V> {
    public var argumentRecievedCount: Int
    public var isArgumentRecieved: Bool { argumentRecievedCount > 0 }
    public var argumentLastValue: V?
    public var argumentAllValues: [V]
    public var argumentRecievedClouser: ((V?) -> ())?
    public init(argumentRecievedCount: Int = 0, argumentLastValue: V? = nil, argumentAllValues: [V] = [], argumentRecievedClouser: ((V?) -> Void)? = nil) {
        self.argumentRecievedCount = argumentRecievedCount
        self.argumentLastValue = argumentLastValue
        self.argumentAllValues = argumentAllValues
        self.argumentRecievedClouser = argumentRecievedClouser
    }
    func invoked(by argument: V?) {
        argumentRecievedCount += 1
        argumentLastValue = argument
        if let argument {
            argumentAllValues.append(argument)
        }
        argumentRecievedClouser?(argument)
    }
}

public class MockEpisodeServiceProtocol: EpisodeServiceProtocol {
    
    public var episodeArgument: MockFunctionArgument<EpisodesApiData> = .init()
    
    public init() {}
    
    public func episodes() async throws -> EpisodesApiData {
        if let returnValue = episodeArgument.argumentLastValue {
            episodeArgument.invoked(by: returnValue)
            return returnValue
        }
        return .preview
    }
}
public class MockChannelServiceProtocol: ChannelServiceProtocol {
    
    public var channelArgument: MockFunctionArgument<ChannelsApiData> = .init()
    
    public init() {}
    public func channels() async throws -> ChannelsApiData {
        if let returnValue = channelArgument.argumentLastValue {
            channelArgument.invoked(by: returnValue)
            return returnValue
        }
        return .preview
    }
}
public class MockCategoriesServiceProtocol: CategoriesServiceProtocol {
    
    public var categoriesArgument: MockFunctionArgument<CategoriesApiData> = .init()
    
    public init() {}
    
    public func categories() async throws -> CategoriesApiData {
        if let returnValue = categoriesArgument.argumentLastValue {
            categoriesArgument.invoked(by: returnValue)
            return returnValue
        }
        return .preview
    }
}
