//
//  ChannelHeaderView.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import SwiftUI
import core_architecture
import Dependencies

public struct ChannelHeaderView: View {
    @State var channel: ChannelUIM
    private let imageSize: CGFloat = 50
    public var body: some View {
        HStack {
            RemoteImage(
                url: (channel.iconAsset?.thumbnailUrl ?? ""),
                lottiePlaceholder: Config.Lottie.loadingAnimation,
                size: .init(
                    width: imageSize,
                    height: imageSize
                ),
                scale: 0.15
            )
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading, spacing: 0) {
                if let title = channel.title {
                    Text(title)
                        .robotoFont(style: .medium(.small))
                        .foregroundColor(.white)
                }
                if let subtitle = subtitle() {
                    Text(subtitle)
                        .robotoFont(style: .medium(.xSmall))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
    func subtitle() -> String? {
        if let series = channel.series, channel.isSeries {
            return "\(series.count) Series"
        } else if let courses = channel.latestMedia, courses.isNotEmpty {
            return "\(courses.count) Episodes"
        }
        return nil
    }
}
public struct ChannelHeaderView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<Channel> {
        .init(
            configurations: [
                .init(name: "Courses Header", state: .previewCourse),
                .init(name: "Series Header", state: .previewSeries),
                
                .init(name: "Courses Header 2", state: .previewCourse2),
                .init(name: "Series Header 2", state: .previewSeries2),
                
                .init(name: "Courses Header 3", state: .previewCourse3),
                .init(name: "Series Header 3", state: .previewSeries3),
            ]) { channel in
                ChannelHeaderView(
                    channel: ChannelUIM(
                        dataModel: channel
                    )
                )
                .background(Color.appTheme)
            }
    }
}
