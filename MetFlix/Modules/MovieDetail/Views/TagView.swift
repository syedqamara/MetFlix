//
//  TagView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import SwiftUI
import PreviewSnapshots

struct TagView: View {
    var tag: String
    
    var body: some View {
        Text(tag)
            .lineLimit(1)
            .fixedSize()
            .font(.title3.bold())
            .tagViewStyle()
    }
}
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: PreviewSnapshots<String> {
        .init(
            configurations: [
                .init(name: "Language Preview", state: "English")
            ]) { state in
                TagView(tag: state)
            }
    }
}
