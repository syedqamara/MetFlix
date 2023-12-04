//
//  CategoriesView.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import core_architecture
import SwiftUI
import Dependencies

public struct CategoriesView<VM: CategoriesViewModeling>: SwiftUIView {
    public typealias ViewModelType = VM
    @ObservedObject var viewModel: VM
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack {
            if let categories = viewModel.categories?.data?.categories {
                TagView(dataModels: categories)
                SeparatorView()
            } else {
                AnimatedView(
                    animationFileName: Config.Lottie.loadingAnimation,
                    loopMode: .loop,
                    size: .init(width: 100, height: 100)
                )
                .scaleEffect(.init(width: 0.5, height: 0.5), anchor: .center)
            }
        }
    }
}
struct TagView: View {
    let dataModels: [CategoryUIM] // Replace DataModel with your actual data model type

    var dataModelChunkSize: CGFloat { CGFloat(dataModels.count / 2) }
    
    var body: some View {
        VStack(spacing: .spacing(.xSmall)) {
            GeometryReader { geometry in
                HStack(spacing: 10) {
                    tagList(
                        tags: dataModels.prefix(dataModels.count / 2),
                        color: .blue,
                        size: .init(
                            width: geometry.size.width / 2 - 5,
                            height: 70
                        )
                    )
                    
                    tagList(
                        tags: dataModels.suffix(dataModels.count / 2),
                        color: .blue,
                        size: .init(
                            width: geometry.size.width / 2 - 5,
                            height: 70
                        )
                    )
                }
            }
        }
        .frame(height: dataModelChunkSize * 80)
        .padding()
    }
    @ViewBuilder
    func tagList(tags: ArraySlice<CategoryUIM>, color: Color, size: CGSize) -> some View {
        VStack {
            ForEach(tags, id: \.id) { model in
                ZStack {
                    Color.categoriesTagColor
                        .cornerRadius(size.height / 2)
                        .frame(width: size.width, height: size.height)
                    if let name = model.name {
                        Text(name)
                            .robotoFont(style: .black(.small))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }
    }
}
struct CategoriesView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<CategoriesApiData> {
        Previewer(
            configurations: [
                .init(name: "Preview", state: CategoriesApiData.preview),
                .init(name: "Preview 2", state: CategoriesApiData.preview2),
                .init(name: "Preview 3", state: CategoriesApiData.preview3)
            ]) { state in
                AnyView(
                    viewFactory.makeView(
                        input: .categories(
                            .init(
                                dataModel: state
                            )
                        )
                    )
                )
                .background(Color.appTheme)
            }
    }
}
