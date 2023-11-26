//
//  TagListView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import SwiftUI
import PreviewSnapshots

struct TagListView: View {
    let title: String
    var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle.bold())
                .foregroundColor(.red)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        TagView(tag: tag)
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 2)
            }
        }
    }
}

struct TagListView_Previews: PreviewProvider {
    struct PreviewState {
        let title: String
        var tags: [String]
        static var languageTags: Self {
            .init(
                title: "Languages",
                tags: [
                    "English",
                    "Urdu",
                    "Arabic"
                ]
            )
        }
    }
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: PreviewSnapshots<PreviewState> {
        .init(
            configurations: [
                .init(name: "Language Preview", state: .languageTags)
            ]) { state in
                TagListView(title: state.title, tags: state.tags)
            }
    }
}
