//
//  CourseView.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import SwiftUI

public struct CourseView: View {
    @State var course: CourseUIM
    let width = UIScreen.main.bounds.size.width / 2
    public var body: some View {
        VView(alignment: .leading, spacing: .spacing(.medium)) {
            if let url = course.coverAsset?.url {
                RemoteImage(
                    url: url,
                    lottiePlaceholder: "",
                    size: .init(
                        width: width,
                        height: width * 1.5
                    ),
                    scale: 0.5
                )
                .id(url)
                .frame(
                    width: width,
                    height: width * 1.5
                )
                .background(Color.categoriesTagColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            VView(alignment: .leading, spacing: .spacing(.small)) {
                if let title = course.title {
                    Text(title)
                        .robotoFont(style: .medium(.small))
                        .foregroundColor(.white)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: width)
    }
}
public struct CourseListView: View {
    @State var courseList: [CourseUIM]
    public var body: some View {
        ScrollView(.horizontal) {
            HView(alignment: .top, spacing: .spacing(.small)) {
                ForEach(courseList) { course in
                    CourseView(course: course)
                }
            }
            
        }
    }
}
public struct CourseListView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<[Course]> {
        .init(
            configurations: [
                .init(name: "Preview", state: [
                    .preview3,
                    .preview4,
                    .preview,
                    .preview2
                ]),
                .init(name: "Preview 2", state: [
                    .preview,
                    .preview2,
                    .preview3,
                    .preview4
                ]),
            ]) { courseList in
                CourseListView(
                    courseList: courseList.map { .init(dataModel: $0) }
                )
                .background(Color.appTheme)
            }
    }
}
