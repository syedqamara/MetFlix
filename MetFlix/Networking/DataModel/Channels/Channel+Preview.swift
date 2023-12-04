//
//  Channel+Preview.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation

public extension Series {
    static var preview: Series {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/049742c3-9489-40b0-a415-e80976cd710b.jpg?transform=w_1080")
        return Series(title: "Coaching Mastery by Evercoach", coverAsset: previewCoverAsset, id: nil)
    }
    static var preview2: Series {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/8e35036a-50f8-42d0-8dbf-a55034a0053f.jpg?transform=w_1080")
        return Series(title: "Bonus Trainings", coverAsset: previewCoverAsset, id: nil)
    }
    static var preview3: Series {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/b7e4062a-f861-4273-8350-d548f6809e93.jpg?transform=w_1080")
        return Series(title: "Category 13", coverAsset: previewCoverAsset, id: "21")
    }
    static var preview4: Series {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/e019134c-fdb0-497c-a613-6b9f1c7166a4.jpg?transform=w_1080")
        return Series(title: "Live Your Quest", coverAsset: previewCoverAsset, id: "10")
    }
}

public extension Course {
    static var preview: Course {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/a90653b8-8475-41a9-925a-3a1bf0e7cd5f.jpg?transform=w_1080")
        return Course(type: "preview_type", title: "How Journaling Helped Create a $500M Company", coverAsset: previewCoverAsset, channel: nil)
    }
    static var preview2: Course {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/c3b924a1-7e33-4175-9647-95d011b986ba.jpg?transform=w_1080")
        return Course(type: "preview_type", title: "The Truth About Water", coverAsset: previewCoverAsset, channel: nil)
    }
    static var preview3: Course {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/953f74d2-52a9-4769-9369-04849e786bb4.jpg?transform=w_1080")
        return Course(type: "preview_type", title: "Vishen's Optimized Morning Routine", coverAsset: previewCoverAsset, channel: nil)
    }
    static var preview4: Course {
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/bff42af7-5a7e-46fb-bcda-7eb7dc3fb342.jpg")
        return Course(type: "preview_type", title: "What To Eat For A Genius Brain", coverAsset: previewCoverAsset, channel: nil)
    }
}

public extension Channel {
    static var previewCourse: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080")
        let previewLatestMedia: [Course] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Mindvalley Mentoring", mediaCount: 10, series: [], latestMedia: previewLatestMedia, id: "previewCourse", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
    static var previewCourse2: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080")
        let previewLatestMedia: [Course] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Mindvalley Mentoring 2", mediaCount: 10, series: [], latestMedia: previewLatestMedia, id: "previewCourse2", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
    static var previewCourse3: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080")
        let previewLatestMedia: [Course] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Mindvalley Mentoring 3", mediaCount: 10, series: [], latestMedia: previewLatestMedia, id: "previewCourse3", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
    static var previewSeries: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/9ea03476-36c4-4358-a784-75f4cce0e2ad.jpg?transform=w_1080")
        let previewSeries: [Series] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Coaching Mastery by Evercoach", mediaCount: 10, series: previewSeries, latestMedia: [], id: "previewSeries", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
    static var previewSeries2: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/9ea03476-36c4-4358-a784-75f4cce0e2ad.jpg?transform=w_1080")
        let previewSeries: [Series] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Coaching Mastery by Evercoach 2", mediaCount: 10, series: previewSeries, latestMedia: [], id: "previewSeries2", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
    }
    static var previewSeries3: Channel {
        let previewIconAsset = Asset(thumbnailUrl: "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png")
        let previewCoverAsset = CoverAsset(url: "https://assets.mindvalley.com/api/v1/assets/9ea03476-36c4-4358-a784-75f4cce0e2ad.jpg?transform=w_1080")
        let previewSeries: [Series] = [.preview, .preview2, .preview3, .preview4]
        return Channel(title: "Coaching Mastery by Evercoach 3", mediaCount: 10, series: previewSeries, latestMedia: [], id: "previewSeries3", iconAsset: previewIconAsset, coverAsset: previewCoverAsset)
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
        let previewChannel1 = Channel.previewCourse
        let previewChannel2 = Channel.previewSeries
        return Channels(channels: [.previewCourse, .previewSeries, .previewCourse2, .previewSeries2, .previewCourse3, .previewSeries3])
    }
}

public extension Asset {
    static var preview: Asset {
        return Asset(thumbnailUrl: "https://example.com/preview_asset.jpg")
    }
}
