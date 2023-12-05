//
//  Deocding+Bool.swift
//  MetFlix
//
//  Created by Apple on 26/11/2023.
//

import Foundation
import SwiftUI

extension KeyedDecodingContainer {
    func decodeCustomBool(key: K) throws -> Bool {
        do {
            return try decode(Bool.self, forKey: key)
        } catch DecodingError.typeMismatch {
            // If a type mismatch occurs, try decoding as Int and convert to Bool
            let intValue = try decode(Int.self, forKey: key)
            return intValue != 0
        }
    }
}
