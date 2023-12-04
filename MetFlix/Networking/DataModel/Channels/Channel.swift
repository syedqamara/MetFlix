//
//  Channel.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation
import core_architecture

public struct Series: DataModel {
    public let title: String?
    public let coverAsset: CoverAsset?
    public let id: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.coverAsset = try container.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
    }
    public init(title: String?, coverAsset: CoverAsset?, id: String?) {
        self.title = title
        self.coverAsset = coverAsset
        self.id = id
    }
}
public struct Course: DataModel {
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
public struct Channel: DataModel {
    public let title: String?
    public let mediaCount: Int?
    public let series: [Series]?
    public let latestMedia: [Course]?
    public let id: String?
    public let iconAsset: Asset?
    public let coverAsset: CoverAsset?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.mediaCount = try container.decodeIfPresent(Int.self, forKey: .mediaCount)
        self.series = try container.decodeIfPresent([Series].self, forKey: .series)
        self.latestMedia = try container.decodeIfPresent([Course].self, forKey: .latestMedia)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.iconAsset = try container.decodeIfPresent(Asset.self, forKey: .iconAsset)
        self.coverAsset = try container.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
    public init(title: String?, mediaCount: Int?, series: [Series]?, latestMedia: [Course]?, id: String?, iconAsset: Asset?, coverAsset: CoverAsset?) {
        self.title = title
        self.mediaCount = mediaCount
        self.series = series
        self.latestMedia = latestMedia
        self.id = id
        self.iconAsset = iconAsset
        self.coverAsset = coverAsset
    }
}

public struct ChannelsApiData: DataModel {
    public let data: Channels?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(Channels.self, forKey: .data)
    }
    public init(data: Channels?) {
        self.data = data
    }
}

public struct Channels: DataModel {
    public let channels: [Channel]?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.channels = try container.decodeIfPresent([Channel].self, forKey: .channels)
    }
    public init(channels: [Channel]?) {
        self.channels = channels
    }
}

// Additional Model for Reusable Asset
public struct Asset: DataModel {
    public let thumbnailUrl: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
    public init(thumbnailUrl: String?) {
        self.thumbnailUrl = thumbnailUrl
    }
}
