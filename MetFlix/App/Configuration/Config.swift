//
//  Config.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import Network
//https://pastebin.com/raw
struct Config {
    static let mindValleyHost = NetworkHost(scheme: "https", host: "pastebin.com", port: 0, path: "raw")
    
}

extension Config {
    struct Lottie {
        static let imageLoadingAnimation: String = "image_loading_animation"
        static let errorAnimation: String = "error_animation"
        static let noResultAnimation: String = "no_result_animation"
        static let loadingAnimation: String = "loading_animation"
    }
}
