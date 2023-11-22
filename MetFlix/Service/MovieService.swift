//
//  Movies.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies
import Network



protocol MovieServiceProtocol {
    func getPopular(query: PopularMovieQueryParameters) async throws -> PaginatedResult<Movie>
    func get(by id: String) async throws -> Movie
}

final class MovieService: MovieServiceProtocol {
    @Dependency(\.defaultNetwork) var network
    func getPopular(query: PopularMovieQueryParameters) async throws -> PaginatedResult<Movie> {
        @Cached(endpoint: .popular) var popularMovies: PaginatedResult<Movie>?
        
        if Internet.isAvailable {
            let movies = try await network.send(
                to: MoviesEnpoint.popular,
                with: query,
                type: PaginatedResult<Movie>.self)
            popularMovies = movies
            return movies
        }
        else if let cache = popularMovies {
            return cache
        }
        else {
            throw SystemError.network(.noInternetConnection)
        }
    }
    
    func get(by id: String) async throws -> Movie {
        @Cached(endpoint: .movie(id)) var movieDetail: PaginatedResult<Movie>?
        throw SystemError.network(.noInternetConnection)
    }
}
