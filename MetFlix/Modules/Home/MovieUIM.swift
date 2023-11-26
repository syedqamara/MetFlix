//
//  MovieUI.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import core_architecture



public struct PaginatedResultUIM<T: UIModeling>: UIModeling {
    public var page: Int
    public var results: [T]
    public var totalPages: Int
    public var totalResults: Int
    public init(page: Int, results: [T], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    public init(dataModel: PaginatedResult<T.DataModelType>) {
        self.page = dataModel.page
        self.results = dataModel.results.map { .init(dataModel: $0) }
        self.totalPages = dataModel.totalPages
        self.totalResults = dataModel.totalResults
    }
}

/// MovieUIM:
///  A UIModel that holds the data being rendered in the View related to Movies.
public struct MovieUIM: UIModeling, Identifiable {
    public typealias DataModelType = Movie
    // Flag whether it is for adults or non-adults.
    public let adult: Bool
    // Movie Backdrop Image Path
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    // Orignal language in which the movie is recorded
    public let originalLanguage: String
    // Original Movie Title
    public let originalTitle: String
    public let overview: String
    // Popularity scale
    public let popularity: Double
    // Movie Poster Image path
    public let posterPath: String?
    // Movie release date
    public let releaseDate: String
    // Movie Title
    public let title: String
    // Is Video
    public let video: Bool
    // Average vote
    public let voteAverage: Double
    // Vote Count
    public let voteCount: Int
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
    public init(dataModel: Movie) {
        self.adult = dataModel.adult
        self.backdropPath = dataModel.backdropPath
        self.genreIds = dataModel.genreIds
        self.id = dataModel.id
        self.originalLanguage = dataModel.originalLanguage
        self.originalTitle = dataModel.originalTitle
        self.overview = dataModel.overview
        self.popularity = dataModel.popularity
        self.posterPath = dataModel.posterPath
        self.releaseDate = dataModel.releaseDate
        self.title = dataModel.title
        self.video = dataModel.video
        self.voteAverage = dataModel.voteAverage
        self.voteCount = dataModel.voteCount
    }
}

extension MovieUIM {
    func allow(search text: String) -> Bool {
        originalLanguage.lowercased().contains(text.lowercased()) ||
        originalTitle.lowercased().contains(text.lowercased()) ||
        title.lowercased().contains(text.lowercased())
    }
}
