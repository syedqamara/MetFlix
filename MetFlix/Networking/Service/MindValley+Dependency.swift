//
//  MindValley+Dependency.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import Dependencies

enum MindValleyServiceDependency: DependencyKey {
    static var liveValue: MindValleyServiceProtocol { MindValleyService() }
}
