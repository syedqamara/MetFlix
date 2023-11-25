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





func launch() {
    @Dependency(\.registerar) var registrar
    @Dependency(\.networkDebugConnection) var connection
    @Dependency(\.networkDebugger) var networkDebugger
    @Dependency(\.defaultNetwork) var network
    
    do {
        
        try registrar.networkRegister(
            host: Config.moviesHost,
            endpoint: MoviesEnpoint.popular,
            method: .get,
            contentType: .queryParam,
            responseType: PaginatedResult<Movie>.self,
            headers: [
                "Authorization": "Bearer \(Config.movieApiReadToken)"
            ]
        )
        try registrar.networkRegister(
            host: Config.moviesHost,
            endpoint: MoviesEnpoint.movie(""),
            method: .get,
            contentType: .queryParam,
            responseType: MovieDetail.self,
            headers: [
                "Authorization": "Bearer \(Config.movieApiReadToken)"
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
