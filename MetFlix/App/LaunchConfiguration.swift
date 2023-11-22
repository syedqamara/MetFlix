//
//  LaunchConfiguration.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import Network
import Dependencies
import core_architecture



struct Config {
    static let moviesHost = NetworkHost(scheme: "https", host: "api.themoviedb.org", port: 0, path: "3")
    static let moviesImageHost = NetworkHost(scheme: "https", host: "image.tmdb.org", port: 0, path: "t/p/w500")
    static let movieApiKey = "19ad264d4a35074e4978a08424024270"
    static let movieApiReadToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOWFkMjY0ZDRhMzUwNzRlNDk3OGEwODQyNDAyNDI3MCIsInN1YiI6IjY1NWU1ODVmN2RmZGE2MDBhYzIwZDIyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.--08s17Mmx2-tMKd7OeU9z_8ml-BQDX1Z2w-4Vr0nLs"
}

func launch() {
    @Dependency(\.registerar) var registrar
    
    do {
        try registrar.networkRegister(
            host: Config.moviesHost,
            endpoint: MoviesEnpoint.popular,
            method: .get,
            contentType: .applicationJSON,
            responseType: PaginatedResult<Movie>.self,
            headers: [
                "Authorisation": "Bearer \(Config.movieApiReadToken)"
            ]
        )
    }
    catch let error {
        #if DEBUG
            print("Launch_Configuration_Error")
            print(error)
        #endif
    }
}
