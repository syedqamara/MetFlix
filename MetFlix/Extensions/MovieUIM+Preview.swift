//
//  MovieUIM+Extension.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
public extension PaginatedResultUIM<MovieUIM> {
    static var preview: PaginatedResultUIM<MovieUIM> {
        return PaginatedResultUIM(
            page: 1,
            results: MovieUIM.previewArray,
            totalPages: 3,
            totalResults: 30
        )
    }
}

public extension MovieUIM {
    static var preview: MovieUIM {
        return MovieUIM(
            adult: false,
            backdropPath: "/kjQBrc00fB2RjHZB3PGR4w9ibpz.jpg",
            genreIds: [878, 28, 53],
            id: 123,
            originalLanguage: "en",
            originalTitle: "Dummy Movie",
            overview: "This is a dummy overview for the movie.",
            popularity: 123.45,
            posterPath: "/vBZ0qvaRxqEhZwl6LWmruJqWE8Z.jpg",
            releaseDate: "2023-01-01",
            title: "Dummy Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 100
        )
    }

    static var previewArray: [MovieUIM] {
        return [
            MovieUIM.preview,
            MovieUIM(
                adult: true,
                backdropPath: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg",
                genreIds: [28, 12],
                id: 456,
                originalLanguage: "es",
                originalTitle: "Another Dummy Movie",
                overview: "This is another dummy overview for the movie.",
                popularity: 67.89,
                posterPath: "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
                releaseDate: "2023-02-15",
                title: "Another Dummy Movie",
                video: true,
                voteAverage: 8.2,
                voteCount: 150
            )
            // Add more dummy data as needed
        ]
    }
}
