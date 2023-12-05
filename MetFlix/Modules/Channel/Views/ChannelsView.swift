//
//  ChannelsView.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import SwiftUI
import core_architecture
import Dependencies

public struct ChannelsView<VM: ChannelsViewModeling>: SwiftUIView {
    public typealias ViewModelType = VM
    @ObservedObject var viewModel: VM
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VView {
            if let channels = viewModel.channels?.data?.channels {
                ForEach(channels) { channel in
                    ChannelView(channel: channel)
                }
            } else {
                AnimatedView(
                    animationFileName: Config.Lottie.loadingAnimation,
                    loopMode: .loop,
                    size: .init(width: 100, height: 100)
                )
                .scaleEffect(.init(width: 0.5, height: 0.5), anchor: .center)
            }
        }
        .padding(.horizontal)
    }
}

public struct ChannelView: View {
    @State var channel: ChannelUIM
    public var body: some View {
        VView(alignment: .leading, spacing: .spacing(.small)) {
            ChannelHeaderView(channel: channel)
                .padding(.top)
            if channel.isSeries, let series = channel.series {
                SeriesListView(seriesList: series)
            } else if let courses = channel.latestMedia {
                CourseListView(courseList: courses)
            }
            SeparatorView()
        }
        .background(Color.appTheme)
    }
}



public struct ChannelsView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<ChannelsApiData> {
        .init(
            configurations: [
                .init(name: "Preview", state: .preview),
                .init(name: "Preview 2", state: .preview),
                .init(name: "Preview 3", state: .preview)
            ]) { state in
                ScrollView(content: {
                    AnyView(
                        viewFactory.makeView(
                            input: .channels(
                                .init(
                                    dataModel: state
                                )
                            )
                        )
                    )
                })
                .background(Color.appTheme)
            }
    }
}
