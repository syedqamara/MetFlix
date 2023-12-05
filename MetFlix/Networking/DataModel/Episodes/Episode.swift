//
//  Episode.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation
import core_architecture

public struct EpisodeMedia: DataModel {
    public let type: String?
    public let title: String?
    public let coverAsset: CoverAsset?
    public let channel: EpisodeChannel?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.coverAsset = try container.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
        self.channel = try container.decodeIfPresent(EpisodeChannel.self, forKey: .channel)
    }
    public init(type: String?, title: String?, coverAsset: CoverAsset?, channel: EpisodeChannel?) {
        self.type = type
        self.title = title
        self.coverAsset = coverAsset
        self.channel = channel
    }
}

public struct CoverAsset: DataModel {
    public let url: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
    public init(url: String?) {
        self.url = url
    }
}

public struct EpisodeChannel: DataModel {
    public let title: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    public init(title: String?) {
        self.title = title
    }
}

public struct EpisodesApiData: DataModel {
    public let data: Episode?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(Episode.self, forKey: .data)
    }
    public init(data: Episode?) {
        self.data = data
    }
}

public struct Episode: DataModel {
    public let media: [EpisodeMedia]?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.media = try container.decodeIfPresent([EpisodeMedia].self, forKey: .media)
    }
    public init(media: [EpisodeMedia]?) {
        self.media = media
    }
}
