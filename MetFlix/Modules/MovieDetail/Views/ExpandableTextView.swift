//
//  ExpandableTextView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import SwiftUI
import PreviewSnapshots

struct ExpandableTextView: View {
    @State private var expanded: Bool = false
    
    var text: String
    init(expanded: Bool = false, text: String) {
        self.expanded = expanded
        self.text = text
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.largeTitle.bold())
                .foregroundColor(.red)
            Text(text)
                .font(.headline.bold())
                .foregroundColor(.white)
                .lineLimit(expanded ? nil : 3)
                .overlay(
                    Button(action: {
                        withAnimation {
                            expanded.toggle()
                        }
                    }) {
                        Text(expanded ? "Read Less" : "Read More")
                            .font(.title3.bold())
                            .padding(.horizontal, 4)
                            .padding(.vertical, 0)
                            .foregroundColor(.red)
                            .background(.black)
                            
                    }
                    .padding(.top, 4),
                    alignment: .bottomTrailing
                )
        }
    }
}

struct ExpandableTextView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    struct PreviewState {
        let text: String
        let isExpanded: Bool
    }
    
    static var snapshots: PreviewSnapshots<PreviewState> {
        .init(
            configurations: [
                .init(name: "Language Preview Expanded", state: .init(text: languagePreviewState, isExpanded: true)),
                .init(name: "Language Preview Folded", state: .init(text: languagePreviewState, isExpanded: false))
            ]) { state in
                ExpandableTextView(expanded: state.isExpanded,text: state.text)
                    .background(.black)
            }
    }
    static var languagePreviewState: String {
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum euismod justo id efficitur commodo. Curabitur vel purus non enim dictum fermentum. Suspendisse potenti. Praesent ac sollicitudin orci. Nullam et diam nec odio eleifend suscipit. Vivamus sodales, odio eu tempor lacinia, orci turpis viverra dolor, vel sodales risus felis in turpis. Proin venenatis odio vel dolor feugiat, et efficitur libero cursus. Integer euismod dapibus massa, vel tincidunt purus cursus eu. Vivamus convallis, augue vel consectetur convallis, lacus velit sodales mauris, at fringilla turpis tortor id lacus.

        Sed consectetur, justo a suscipit tincidunt, neque orci vehicula justo, vel hendrerit enim elit ac leo. Maecenas finibus orci vel nisl faucibus bibendum. Aliquam sagittis tellus eu arcu luctus lacinia. Fusce ut mauris sed tellus consectetur aliquet. Duis bibendum odio et turpis dignissim bibendum. In hac habitasse platea dictumst. Vivamus eget imperdiet ex. Integer hendrerit quam euismod, euismod odio eu, auctor elit. Nullam bibendum augue eget velit sollicitudin, vitae egestas nulla malesuada.
        """
    }
}

