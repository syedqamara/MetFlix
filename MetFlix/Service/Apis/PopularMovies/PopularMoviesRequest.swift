//
//  MoviesRequest.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import core_architecture

public enum SortBy: String, DataModel {
    case popularity = "popularity.desc"
}

public struct PopularMovieQueryParameters: DataModel {
    var includeAdult: Bool
    var includeVideo: Bool
    var language: String
    var page: Int
    var sortBy: SortBy

    enum CodingKeys: String, CodingKey {
        case includeAdult = "include_adult"
        case includeVideo = "include_video"
        case language
        case page
        case sortBy = "sort_by"
    }
    public init(includeAdult: Bool = false, includeVideo: Bool = false, language: String = "en-US", page: Int = 1, sortBy: SortBy = .popularity) {
        self.includeAdult = includeAdult
        self.includeVideo = includeVideo
        self.language = language
        self.page = page
        self.sortBy = sortBy
    }
}
