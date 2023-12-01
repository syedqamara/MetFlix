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
            name: "Get Episodes Api",
            host: Config.mindValleyHost,
            endpoint: MindValleyEndpoints.episodes,
            method: .get,
            contentType: .queryParam,
            responseType: EpisodesApiData.self,
            headers: [:]
        )
        try registrar.networkRegister(
            name: "Get Channels Api",
            host: Config.mindValleyHost,
            endpoint: MindValleyEndpoints.channels,
            method: .get,
            contentType: .queryParam,
            responseType: ChannelsApiData.self,
            headers: [:]
        )
        try registrar.networkRegister(
            name: "Get Categories Api",
            host: Config.mindValleyHost,
            endpoint: MindValleyEndpoints.categories,
            method: .get,
            contentType: .queryParam,
            responseType: CategoriesApiData.self,
            headers: [:]
        )
        
        
    }
    catch let error {
        #if DEBUG
            print("Launch_Configuration_Error")
            print(error)
        #endif
    }
}
