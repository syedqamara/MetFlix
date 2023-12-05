//
//  MindValley+Dependency.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import Dependencies

enum EpisodeServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: EpisodeServiceProtocol = MindValleyService()
    static var testValue: EpisodeServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}
enum ChannelServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: ChannelServiceProtocol = MindValleyService()
    static var testValue: ChannelServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}
enum CategoryServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: CategoriesServiceProtocol = MindValleyService()
    static var testValue: CategoriesServiceProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}

enum ImageDownloadServiceDependency: DependencyKey, TestDependencyKey {
    static var liveValue: ImageDownloadingProtocol = MindValleyService()
    static var testValue: ImageDownloadingProtocol = MockMindValleyServiceProtocol(parameter: .none(.init()), returned: .none(.init()))
}

extension DependencyValues {
    var episodeService: EpisodeServiceProtocol {
        get {
            self[EpisodeServiceDependency.self]
        }
        set {
            self[EpisodeServiceDependency.self] = newValue
        }
    }
    var channelService: ChannelServiceProtocol {
        get {
            self[ChannelServiceDependency.self]
        }
        set {
            self[ChannelServiceDependency.self] = newValue
        }
    }
    var categoryService: CategoriesServiceProtocol {
        get {
            self[CategoryServiceDependency.self]
        }
        set {
            self[CategoryServiceDependency.self] = newValue
        }
    }
    var imageService: ImageDownloadingProtocol {
        get {
            self[ImageDownloadServiceDependency.self]
        }
        set {
            self[ImageDownloadServiceDependency.self] = newValue
        }
    }
}
