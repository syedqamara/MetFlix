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





public final class MovieService: MovieServiceProtocol {
    @Dependency(\.defaultNetwork) var network
    public func getPopular(query: PopularMovieQueryParameters) async throws -> PaginatedResult<Movie> {
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
    
    public func get(by id: String) async throws -> MovieDetail {
        @Cached(endpoint: .movie(id)) var movieDetail: MovieDetail?
        if Internet.isAvailable {
            let detail = try await network.send(
                to: MoviesEnpoint.movie(id),
                with: nil,
                type: MovieDetail.self
            )
            return detail
        }
        else if let cache = movieDetail {
            return cache
        }
        else {
            throw SystemError.network(.noInternetConnection)
        }
    }
}
