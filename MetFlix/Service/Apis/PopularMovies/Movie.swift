//
//  Movie.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import core_architecture
public struct PaginatedResult<T: DataModel>: DataModel {
    public let page: Int
    public let results: [T]
    public let totalPages: Int
    public let totalResults: Int
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: DataModel {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate: String
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



