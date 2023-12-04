//
//  ChannelsUIM.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
public struct SeriesUIM: UIModel, Identifiable {
    public typealias DataModelType = Series
    public var title: String?
    public var coverAsset: CoverAssetUIM?
    public var identifier: String?
    public var id: String? { identifier ?? title ?? "" }

    public init(dataModel: Series) {
        self.title = dataModel.title
        self.coverAsset = dataModel.coverAsset.map { CoverAssetUIM(dataModel: $0) }
        self.identifier = dataModel.id
    }
}

public struct CourseUIM: UIModel, Identifiable {
    public typealias DataModelType = Course
    public var type: String?
    public var title: String?
    public var id: String { title ?? type ?? "" }
    public var coverAsset: CoverAssetUIM? = nil
    public var channel: EpisodeChannelUIM? = nil

    public init(dataModel: Course) {
        self.type = dataModel.type
        self.title = dataModel.title
        if let coverAsset = dataModel.coverAsset {
            self.coverAsset = CoverAssetUIM(dataModel: coverAsset)
        }
        if let channel = dataModel.channel {
            self.channel = EpisodeChannelUIM(dataModel: channel)
        }
        
    }
}

public struct ChannelUIM: UIModel, Identifiable {
    public typealias DataModelType = Channel
    public var title: String?
    public var mediaCount: Int?
    public var series: [SeriesUIM]?
    public var latestMedia: [CourseUIM]?
    public var identifier: String?
    public var iconAsset: AssetUIM?
    public var coverAsset: CoverAssetUIM?
    public var id: String { identifier ?? title ?? "" }
    public var isSeries: Bool { (series ?? []).isNotEmpty }
    public init(dataModel: Channel) {
        self.title = dataModel.title
        self.mediaCount = dataModel.mediaCount
        self.series = dataModel.series?.map { SeriesUIM(dataModel: $0) }
        self.latestMedia = dataModel.latestMedia?.map { CourseUIM(dataModel: $0) }
        self.identifier = dataModel.id
        self.iconAsset = dataModel.iconAsset.map { AssetUIM(dataModel: $0) }
        self.coverAsset = dataModel.coverAsset.map { CoverAssetUIM(dataModel: $0) }
    }
}

public struct ChannelsDataUIM: UIModel {
    public typealias DataModelType = ChannelsApiData
    public var data: ChannelsUIM?

    public init(dataModel: ChannelsApiData) {
        self.data = dataModel.data.map { ChannelsUIM(dataModel: $0) }
    }
}

public struct ChannelsUIM: UIModel {
    public typealias DataModelType = Channels
    public var channels: [ChannelUIM]?

    public init(dataModel: Channels) {
        self.channels = dataModel.channels?.map { ChannelUIM(dataModel: $0) }
    }
}

public struct AssetUIM: UIModel {
    public typealias DataModelType = Asset
    public var thumbnailUrl: String?

    public init(dataModel: Asset) {
        self.thumbnailUrl = dataModel.thumbnailUrl
    }
}
