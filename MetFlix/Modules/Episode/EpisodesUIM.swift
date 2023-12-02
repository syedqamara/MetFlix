//
//  EpisodesUIM.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture

public struct EpisodesDataUIM: UIModel {
    public typealias DataModelType = EpisodesApiData
    public var data: EpisodeUIM? = nil

    public init(dataModel: EpisodesApiData) {
        if let episodes = dataModel.data {
            self.data = EpisodeUIM(dataModel: episodes)
        }
    }
}

public struct EpisodeUIM: UIModel {
    public typealias DataModelType = Episode
    public var media: [EpisodeMediaUIM]? = nil

    public init(dataModel: Episode) {
        if let media = dataModel.media {
            self.media = media.map { EpisodeMediaUIM(dataModel: $0) }
        }
    }
}

public struct EpisodeMediaUIM: UIModel, Identifiable {
    public typealias DataModelType = EpisodeMedia
    public var type: String?
    public var title: String?
    public var coverAsset: CoverAssetUIM?
    public var channel: EpisodeChannelUIM?
    public var id: String { title ?? ""}
    public init(dataModel: EpisodeMedia) {
        self.type = dataModel.type
        self.title = dataModel.title
        self.coverAsset = dataModel.coverAsset.map { CoverAssetUIM(dataModel: $0) }
        self.channel = dataModel.channel.map { EpisodeChannelUIM(dataModel: $0) }
    }
}

public struct CoverAssetUIM: UIModel {
    public typealias DataModelType = CoverAsset
    public var url: String?

    public init(dataModel: CoverAsset) {
        self.url = dataModel.url
    }
}

public struct EpisodeChannelUIM: UIModel {
    public typealias DataModelType = EpisodeChannel
    public var title: String?

    public init(dataModel: EpisodeChannel) {
        self.title = dataModel.title
    }
}
