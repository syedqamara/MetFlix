//
//  MovieDetail.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import core_architecture

struct MovieDetailQueryParameters: DataModel {
    var language: String

    enum CodingKeys: String, CodingKey {
        case language
    }
    init(language: String = "en-US") {
        self.language = language
    }
}
