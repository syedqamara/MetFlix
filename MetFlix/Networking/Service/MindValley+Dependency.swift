//
//  MindValley+Dependency.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import Dependencies

enum MindValleyServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: MindValleyServiceProtocol { MindValleyService() }
    static var testValue: MindValleyServiceProtocol { MockMindValleyServiceProtocol() }
}

extension DependencyValues {
    var mindValleyService: MindValleyServiceProtocol {
        get {
            self[MindValleyServiceDependency.self]
        }
        set {
            self[MindValleyServiceDependency.self] = newValue
        }
    }
    var mindValleyImageService: ImageDownloadingProtocol {
        self.mindValleyService as ImageDownloadingProtocol
    }
}
