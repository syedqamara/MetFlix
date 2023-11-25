//
//  MovieDetailUIModel.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import core_architecture

// UI Model of Movie Detail
public struct MovieDetailUIM: UIModeling {
    /*
     ChatGPT UI Building Guideline.
     Write a movie detail for bellow properties having comments on it. Use comments for view specific details related to each attribute.
     
     TagView must be red rounded border with red text color and red shadow but with black background.
     TasgListView must be a horizontally scrollable TagViews with 5 spacing between them.
     
     Cover Photo Must have the full width but 300 height. Cover Photo must be inside the vertical ScrollView of MovieDetailView and if the user scroll to the top and tries to drag the scroll more to the zero offset of the scrollY Axis the Height of Cover Photo Should be increase by the scrollY axis times.
     */
    public typealias DataModelType = MovieDetail
    // Show 18+ in info section
    public let adult: Bool
    // Back Drop Image in Circular Shape with Red Shadow
    public let backdropPath: String?
    public let belongsToCollection: CollectionUIM?
    // Show budget in info section
    public let budget: Int
    // Show Genre TagListView in horizontal carousel
    public let genres: [GenreUIM]
    // Homepage link in Info Tab
    public let homepage: String
    public let id: Int
    public let imdbId: String
    public let originalLanguage: String
    // Display Title Right to Backdrop image at equal spacing
    public let originalTitle: String
    // Expandable and collapsable multiline text view bellow the backdrop image.
    public let overview: String
    public let popularity: Double
    // Display in a Cover Photo with Horizontal Scrolling.
    public let posterPath: String?
    // Display in Production Companies Section
    public let productionCompanies: [ProductionCompanyUIM]
    public let productionCountries: [ProductionCountryUIM]
    // Display release date bellow the tag line with normal font size.
    public let releaseDate: String
    public let revenue: Int
    public let runtime: Int
    // Show Spoken language Tag View in horizontal carousel
    public let spokenLanguages: [SpokenLanguageUIM]
    public let status: String
    // Display release date bellow the orignal Title with normal font size
    public let tagline: String
    public let title: String
    public let video: Bool
    // Display start
    public let voteAverage: Double
    public let voteCount: Int

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
    public init(dataModel: MovieDetail) {
        self.adult = dataModel.adult ?? false
        self.backdropPath = dataModel.backdropPath
        self.belongsToCollection = dataModel.belongsToCollection == nil ? nil : .init(dataModel: dataModel.belongsToCollection!)
        self.budget = dataModel.budget ?? 0
        self.genres = dataModel.genres.map { .init(dataModel: $0) }
        self.homepage = dataModel.homepage
        self.id = dataModel.id
        self.imdbId = dataModel.imdbId
        self.originalLanguage = dataModel.originalLanguage
        self.originalTitle = dataModel.originalTitle
        self.overview = dataModel.overview
        self.popularity = dataModel.popularity
        self.posterPath = dataModel.posterPath
        self.productionCompanies = dataModel.productionCompanies.map { .init(dataModel: $0) }
        self.productionCountries = dataModel.productionCountries.map { .init(dataModel: $0) }
        self.releaseDate = dataModel.releaseDate
        self.revenue = dataModel.revenue
        self.runtime = dataModel.runtime
        self.spokenLanguages = dataModel.spokenLanguages.map { .init(dataModel: $0) }
        self.status = dataModel.status
        self.tagline = dataModel.tagline
        self.title = dataModel.title
        self.video = dataModel.video
        self.voteAverage = dataModel.voteAverage
        self.voteCount = dataModel.voteCount
    }
}

public struct CollectionUIM: UIModeling {
    public typealias DataModelType = Collection
     
    public let id: Int
    public let name: String
    public let posterPath: String?
    public let backdropPath: String?
    public init(dataModel: Collection) {
        self.id = dataModel.id
        self.name = dataModel.name
        self.posterPath = dataModel.posterPath
        self.backdropPath = dataModel.backdropPath
    }
}

public struct GenreUIM: UIModeling {
    public typealias DataModelType = Genre
    
    public let id: Int
    public let name: String
    
    public init(dataModel: Genre) {
        self.id = dataModel.id
        self.name = dataModel.name
    }
}

public struct ProductionCompanyUIM: UIModeling, Identifiable {
    public typealias DataModelType = ProductionCompany
    
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    public init(dataModel: ProductionCompany) {
        self.id = dataModel.id
        self.logoPath = dataModel.logoPath
        self.name = dataModel.name
        self.originCountry = dataModel.originCountry
        
    }
}

public struct ProductionCountryUIM: UIModeling {
    public typealias DataModelType = ProductionCountry
    
    public let iso3166_1: String
    public let name: String

    public init(dataModel: ProductionCountry) {
        self.iso3166_1 = dataModel.iso3166_1
        self.name = dataModel.name
    }
    
    private enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguageUIM: UIModeling {
    public typealias DataModelType = SpokenLanguage
    
    public let englishName: String
    public let iso639_1: String
    public let name: String

    public init(dataModel: SpokenLanguage) {
        self.englishName = dataModel.englishName
        self.iso639_1 = dataModel.iso639_1
        self.name = dataModel.name
    }
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
