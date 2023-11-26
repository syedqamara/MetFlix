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
    public init(page: Int, results: [T], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
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
    public init(adult: Bool, backdropPath: String?, genreIds: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String?, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode Bool values from both Bool and Int
        adult = try container.decodeCustomBool(key: .adult)
        video = try container.decodeCustomBool(key: .video)

        // Decode other properties
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        id = try container.decode(Int.self, forKey: .id)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}

