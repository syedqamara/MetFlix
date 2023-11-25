//
//  MovieDetail.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import core_architecture


public struct MovieDetail: DataModel {
    public let adult: Bool?
    public let backdropPath: String?
    public let belongsToCollection: Collection?
    public let budget: Int?
    public let genres: [Genre]
    public let homepage: String
    public let id: Int
    public let imdbId: String
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: String
    public let revenue: Int
    public let runtime: Int
    public let spokenLanguages: [SpokenLanguage]
    public let status: String
    public let tagline: String
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    
    public init(adult: Bool, backdropPath: String?, belongsToCollection: Collection?, budget: Int, genres: [Genre], homepage: String, id: Int, imdbId: String, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String?, productionCompanies: [ProductionCompany], productionCountries: [ProductionCountry], releaseDate: String, revenue: Int, runtime: Int, spokenLanguages: [SpokenLanguage], status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public struct Collection: DataModel {
    public let id: Int
    public let name: String
    public let posterPath: String?
    public let backdropPath: String?
}

public struct Genre: DataModel {
    public let id: Int
    public let name: String
}

public struct ProductionCompany: DataModel {
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String?

    init(id: Int, logoPath: String?, name: String, originCountry: String?) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

public struct ProductionCountry: DataModel {
    public let iso3166_1: String
    public let name: String
    
    public init(iso3166_1: String, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
    private enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: DataModel {
    public let englishName: String
    public let iso639_1: String
    public let name: String
    public init(englishName: String, iso639_1: String, name: String) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
