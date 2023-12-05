//
//  Episode+Preview.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation

public extension EpisodeMedia {
    static var preview: EpisodeMedia {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080")
        let previewChannel = EpisodeChannel(title: "Little Humans")
        return EpisodeMedia(type: "course", title: "Conscious Parenting", coverAsset: previewCoverAsset, channel: previewChannel)
    }
    static var preview2: EpisodeMedia {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/cb8c79d9-af35-4727-9c4c-6e9eee5af1c3.jpg?transform=w_1080")
        let previewChannel = EpisodeChannel(title: "Little Humans")
        return EpisodeMedia(type: "course", title: "Raising Kids With Healthy Beliefs", coverAsset: previewCoverAsset, channel: previewChannel)
    }
    static var preview3: EpisodeMedia {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/9accb76c-fc05-4455-b20c-a39f947184a7.jpg?transform=w_1080")
        let previewChannel = EpisodeChannel(title: "Little Humans")
        return EpisodeMedia(type: "course", title: "Attachment Parenting: Nurturing Our Children", coverAsset: previewCoverAsset, channel: previewChannel)
    }
    static var preview4: EpisodeMedia {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/2f48bea4-24c8-4561-a984-7fb5f581e104.jpg?transform=w_1080")
        let previewChannel = EpisodeChannel(title: "Little Humans")
        return EpisodeMedia(type: "course", title: "Superparenting For Distracted Kids", coverAsset: previewCoverAsset, channel: previewChannel)
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
    static var preview2: EpisodesApiData {
        let previewEpisode = Episode.preview2
        return EpisodesApiData(data: previewEpisode)
    }
    static var preview3: EpisodesApiData {
        let previewEpisode = Episode.preview3
        return EpisodesApiData(data: previewEpisode)
    }
}

public extension Episode {
    static var preview: Episode {
        let previewMedia: [EpisodeMedia] = [.preview, .preview2, .preview3, .preview4]
        return Episode(media: previewMedia)
    }
    static var preview2: Episode {
        let previewMedia: [EpisodeMedia] = [.preview, .preview2, .preview3, .preview4]
        return Episode(media: previewMedia)
    }
    static var preview3: Episode {
        let previewMedia: [EpisodeMedia] = [.preview, .preview2, .preview3, .preview4]
        return Episode(media: previewMedia)
    }
}
