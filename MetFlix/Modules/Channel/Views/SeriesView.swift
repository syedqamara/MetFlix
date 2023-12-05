//
//  SeriesView.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import SwiftUI

public struct SeriesView: View {
    @State var series: SeriesUIM
    private let width = UIScreen.main.bounds.width - 100
    public var body: some View {
        VView(alignment: .leading, spacing: .spacing(.small)) {
            if let url = series.coverAsset?.url {
                RemoteImage(
                    url: url,
                    lottiePlaceholder: "",
                    size: .zero,
                    scale: 0.5
                )
                .id(url)
                .frame(width: width)
                .frame(height: width / 1.89)
                .background(Color.categoriesTagColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VView(alignment: .leading, spacing: .spacing(.small)) {
                if let title = series.title {
                    Text(title)
                        .robotoFont(style: .bold(.small))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
public struct SeriesListView: View {
    @State var seriesList: [SeriesUIM]
    public var body: some View {
        ScrollView(.horizontal) {
            HView(alignment: .top, spacing: .spacing(.small)) {
                ForEach(seriesList) { series in
                    SeriesView(series: series)
                }
            }
        }
        
    }
}

public struct SeriesListView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<[Series]> {
        .init(
            configurations: [
                .init(name: "Preview", state: [
                    .preview,
                    .preview2
                ]),
                .init(name: "Preview 2", state: [
                    .preview3,
                    .preview4
                ]),
            ]) { seriesList in
                SeriesListView(
                    seriesList: seriesList.map { .init(dataModel: $0) }
                )
                .background(Color.appTheme)
            }
    }
}
