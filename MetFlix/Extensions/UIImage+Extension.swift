//
//  UIImage+Extension.swift
//  MetFlix
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import UIKit

public extension Data {
    init?(assetName: String) {
        if let image = UIImage(named: assetName) {
            if let data = image.pngData() {
                self = data
            }
            
            // If you want to use JPEG format instead of PNG
            // if let data = image.jpegData(compressionQuality: 1.0) {
            //     return data
            // }
        }
        return nil
        
    }
}
