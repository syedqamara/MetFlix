//
//  Channel+Preview.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation

public extension Series {
    static var preview: Series {
        let previewCoverAsset = CoverAsset(url: "https://example.com/preview.jpg")
        return Series(title: "Preview Series", coverAsset: previewCoverAsset, id: "preview_id")
    }
}

public extension Course {
    static var preview: Course {
        let previewCoverAsset = CoverAsset(url: "https://example.com/preview_course.jpg")
        let previewChannel = EpisodeChannel(title: "Preview Channel")
        return Course(type: "preview_type", title: "Preview Course", coverAsset: previewCoverAsset, channel: previewChannel)
    }
}

public extension Channel {
    static var preview: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://example.com/preview_icon.jpg")
        let previewCoverAsset = CoverAsset(url: "https://example.com/preview_channel.jpg")
        let previewSeries = [Series.preview]
        let previewLatestMedia = [Course.preview]
        return Channel(title: "Preview Channel", mediaCount: 10, series: previewSeries, latestMedia: previewLatestMedia, id: "preview_id", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
}

public extension ChannelsApiData {
    static var preview: ChannelsApiData {
        let previewChannels = Channels.preview
        return ChannelsApiData(data: previewChannels)
    }
}

public extension Channels {
    static var preview: Channels {
        let previewChannel1 = Channel.preview
        let previewChannel2 = Channel.preview
        return Channels(channels: [previewChannel1, previewChannel2])
    }
}

public extension Asset {
    static var preview: Asset {
        return Asset(thumbnailUrl: "https://example.com/preview_asset.jpg")
    }
}
