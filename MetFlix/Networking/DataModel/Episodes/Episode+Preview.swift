//
//  Episode+Preview.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation

public extension EpisodeMedia {
    static var preview: EpisodeMedia {
        let previewCoverAsset = CoverAsset(url: "https://example.com/preview_cover.jpg")
        let previewChannel = EpisodeChannel(title: "Preview Episode Channel")
        return EpisodeMedia(type: "preview_type", title: "Preview Episode Media", coverAsset: previewCoverAsset, channel: previewChannel)
    }
}

public extension CoverAsset {
    static var preview: CoverAsset {
        return CoverAsset(url: "https://example.com/preview_url.jpg")
    }
}

public extension EpisodeChannel {
    static var preview: EpisodeChannel {
        return EpisodeChannel(title: "Preview Episode Channel")
    }
}

public extension EpisodesApiData {
    static var preview: EpisodesApiData {
        let previewEpisode = Episode.preview
        return EpisodesApiData(data: previewEpisode)
    }
}

public extension Episode {
    static var preview: Episode {
        let previewMedia = [EpisodeMedia.preview]
        return Episode(media: previewMedia)
    }
}
