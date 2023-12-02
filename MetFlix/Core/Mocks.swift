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
//class MockHomeViewModeling: HomeViewModeling {
//    @Published var error: Error?
//    @Published var isLoading: Bool = false
//    @Published var search: String = ""
////    @Published var movies: [MovieUIM] = []
//    
//    func onAppear() {}
//    
//    func loadNextPage() {}
//}
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
 Function Argument(parameters, returns)
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

/**
 A mock implementation for the MockMindValleyServiceProtocol protocol.
 */

public class MockMindValleyServiceProtocol: MindValleyServiceProtocol {
    enum Errors: String, Error {
    case noValue
    }
    public var episodeArgument: MockFunctionArgument<EpisodesApiData> = .init()
    public var channelArgument: MockFunctionArgument<ChannelsApiData> = .init()
    public var categoriesArgument: MockFunctionArgument<CategoriesApiData> = .init()
    public var imageURLArgument: MockFunctionArgument<String> = .init()
    public var imageArgument: MockFunctionArgument<Data> = .init()
    
    public init() {}
}

extension MockMindValleyServiceProtocol {
    public func episodes() async throws -> EpisodesApiData {
        if let returnValue = episodeArgument.argumentLastValue {
            episodeArgument.invoked(by: returnValue)
            return returnValue
        }
        episodeArgument.invoked(by: nil)
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol {
    public func channels() async throws -> ChannelsApiData {
        if let returnValue = channelArgument.argumentLastValue {
            channelArgument.invoked(by: returnValue)
            return returnValue
        }
        channelArgument.invoked(by: nil)
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol {
    public func categories() async throws -> CategoriesApiData {
        if let returnValue = categoriesArgument.argumentLastValue {
            categoriesArgument.invoked(by: returnValue)
            return returnValue
        }
        categoriesArgument.invoked(by: nil)
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol {
    public func image(for url: String) async throws -> Data {
        if let returnValue = imageArgument.argumentLastValue {
            imageArgument.invoked(by: returnValue)
            return returnValue
        }
        imageArgument.invoked(by: nil)
        throw Errors.noValue
    }
}
