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
    @Published var movies: [MovieUIM] = []
    
    func onAppear() {}
    
    func loadNextPage() {}
}
/**
 A mock implementation for the MovieDetailViewModeling protocol.
 */
class MockMovieDetailViewModeling: MovieDetailViewModeling {
    @Published var movieId: Int = 0
    @Published var movieDetail: MovieDetailUIM?
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

public class MockMovieServiceProtocol: MovieServiceProtocol {
    
    public var getPopularQuery: MockFunctionArgument<PopularMovieQueryParameters> = .init()
    public var getByID: MockFunctionArgument<String> = .init()
    
    public var getPopularReturn: MockFunctionArgument<PaginatedResult<Movie>> = .init()
    public var getByIDReturn: MockFunctionArgument<MovieDetail> = .init()
    
    public init() {}
    
    public func getPopular(query: PopularMovieQueryParameters) async throws -> PaginatedResult<Movie> {
        // Implement mock logic for getPopular
        getPopularQuery.invoked(by: query)
        if let returnValue = getPopularReturn.argumentLastValue {
            getPopularReturn.invoked(by: returnValue)
            return returnValue
        }
        return PaginatedResult<Movie>.preview
    }
    
    public func get(by id: String) async throws -> MovieDetail {
        // Implement mock logic for get(by:)
        getByID.invoked(by: id)
        if let returnValue = getByIDReturn.argumentLastValue {
            getByIDReturn.invoked(by: returnValue)
            return returnValue
        }
        return MovieDetail.preview // Replace MovieDetail() with the actual mock for MovieDetail
    }
}
