//
//  Config.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import Network

struct Config {
    static let moviesHost = NetworkHost(scheme: "https", host: "api.themoviedb.org", port: 0, path: "3")
    static let moviesImageHost = NetworkHost(scheme: "https", host: "image.tmdb.org", port: 0, path: "t/p/w500")
    static let movieApiKey = "19ad264d4a35074e4978a08424024270"
    static let movieApiReadToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOWFkMjY0ZDRhMzUwNzRlNDk3OGEwODQyNDAyNDI3MCIsInN1YiI6IjY1NWU1ODVmN2RmZGE2MDBhYzIwZDIyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.--08s17Mmx2-tMKd7OeU9z_8ml-BQDX1Z2w-4Vr0nLs"
}

extension Config {
    struct Lottie {
        static let imageLoadingAnimation: String = "image_loading_animation"
        static let errorAnimation: String = "error_animation"
        static let noResultAnimation: String = "no_result_animation"
        static let loadingAnimation: String = "loading_animation"
    }
}
