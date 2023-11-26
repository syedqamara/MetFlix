//
//  MovieDetail.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
extension MovieDetail {
    static public var preview: MovieDetail {
        
        return MovieDetail(
            adult: false,
            backdropPath: "/kjQBrc00fB2RjHZB3PGR4w9ibpz.jpg",
            belongsToCollection: nil,
            budget: 80000000,
            genres: [.previewScienceFiction, .previewAction, .previewThriller],
            homepage: "https://www.20thcenturystudios.com/movies/the-creator",
            id: 670292,
            imdbId: "tt11858890",
            originalLanguage: "en",
            originalTitle: "The Creator",
            overview: "Amid a future war between the human race and the forces of artificial intelligence, a hardened ex-special forces agent grieving the disappearance of his wife, is recruited to hunt down and kill the Creator, the elusive architect of advanced AI who has developed a mysterious weapon with the power to end the war—and mankind itself.",
            popularity: 1965.179,
            posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg",
            productionCompanies: [.previewNewRegency, .previewEntertainment, .previewRegency, .previewBadDreams],
            productionCountries: [.previewUS, .previewCA],
            releaseDate: "2023-09-27",
            revenue: 104000000,
            runtime: 134,
            spokenLanguages: [.previewEnglish, .previewJapanese, .previewThai, .previewVietnamese],
            status: "Released",
            tagline: "This is a fight for our very existence.",
            title: "The Creator",
            video: false,
            voteAverage: 7.218,
            voteCount: 985
        )
    }
}

extension SpokenLanguage {
    static public var previewEnglish: SpokenLanguage { SpokenLanguage(englishName: "English", iso639_1: "en", name: "English") }
    static public var previewJapanese: SpokenLanguage { SpokenLanguage(englishName: "Japanese", iso639_1: "ja", name: "日本語") }
    static public var previewThai: SpokenLanguage { SpokenLanguage(englishName: "Thai", iso639_1: "th", name: "ภาษาไทย") }
    static public var previewVietnamese: SpokenLanguage { SpokenLanguage(englishName: "Vietnamese", iso639_1: "vi", name: "Tiếng Việt") }
}

extension ProductionCountry {
    static public var previewCA: ProductionCountry { ProductionCountry(iso3166_1: "CA", name: "Canada") }
    static public var previewUS: ProductionCountry { ProductionCountry(iso3166_1: "US", name: "United States of America") }
    
}

extension ProductionCompany {
    static public var previewNewRegency: ProductionCompany { ProductionCompany(id: 10104, logoPath: "/wRn5HnYMGeJHmItRypgOZOC6gwY.png", name: "New Regency Pictures", originCountry: "US") }
    static public var previewEntertainment: ProductionCompany { ProductionCompany(id: 8147, logoPath: "/q6HOAdSNgCbeOqwoMVRc6REgbXF.png", name: "Entertainment One", originCountry: "CA") }
    static public var previewRegency: ProductionCompany { ProductionCompany(id: 508, logoPath: "/7cxRWzi4LsVm4Utfpr1hfARNurT.png", name: "Regency Enterprises", originCountry: "US") }
    static public var previewBadDreams: ProductionCompany { ProductionCompany(id: 206867, logoPath: nil, name: "Bad Dreams", originCountry: "") }
}

extension Genre {
    static public var previewScienceFiction: Genre { Genre(id: 878, name: "Science Fiction") }
    static public var previewAction: Genre { Genre(id: 28, name: "Action") }
    static public var previewThriller: Genre { Genre(id: 53, name: "Thriller") }
}
