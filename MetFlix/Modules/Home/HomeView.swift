//
//  HomeView.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI
import SkeletonUI

struct HomeView<VM: HomeViewModeling>: SwiftUIView {
    typealias ViewModelType = VM
    @ObservedObject var viewModel: VM
    @Dependency(\.viewFactory) var viewFactory
    private let background: Color = .appTheme
    init(viewModel: VM) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = .appThemeUI
        UINavigationBar.appearance().barTintColor = .appThemeUI
        UINavigationBar.appearance().tintColor = .red
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    }
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.sections) { section in
                    switch section {
                    case .episodes(let episodes):
                        AnyView(
                            viewFactory.makeView(input: .episodes(episodes))
                        )
                    case .categories(let categories):
                        AnyView(
                            viewFactory.makeView(input: .categories(categories))
                        )
                    case .channels(let channels):
                        AnyView(
                            viewFactory.makeView(input: .channels(channels))
                        )
                    case .error(let error):
                        PlaceholderView(
                            placeholder: .error(error.localizedDescription)
                        )
                    default:
                        HStack{}
                    }
                }
            }
        }
        .refreshable {
            
        }
        .scrollContentBackground(.hidden)
        .onAppear() {
            viewModel.onAppear()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Channels")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: [.top])
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<[HomeSectionUIM]> {
        .init(
            configurations: [
                .init(name: "Empty", state: []),
                .init(name: "Static", state: [
                    HomeSectionUIM.episodes(.init(dataModel: EpisodesApiData.preview)),
                    HomeSectionUIM.channels(.init(dataModel: ChannelsApiData.preview)),
                    HomeSectionUIM.categories(.init(dataModel: CategoriesApiData.preview))
                ]),
                .init(name: "Live", state: [
                    HomeSectionUIM.episodes(nil),
                    HomeSectionUIM.channels(nil),
                    HomeSectionUIM.categories(nil)
                ]),
                .init(name: "Error", state: [
                    HomeSectionUIM.error(NSError(domain: "com", code: 1, userInfo: [
                        NSLocalizedDescriptionKey:  """
This is a mock error message, containing dummy representation of an error scenario.
"""
                    ]))
                ]),
                .init(name: "Static Episode", state: [
                    HomeSectionUIM.episodes(.init(dataModel: EpisodesApiData.preview))
                ]),
                .init(name: "Static Channels", state: [
                    HomeSectionUIM.channels(.init(dataModel: ChannelsApiData.preview))
                ]),
                .init(name: "Static Categories", state: [
                    HomeSectionUIM.categories(.init(dataModel: CategoriesApiData.preview))
                ])
            ]) { (sections: [HomeSectionUIM]) in
                NavigationStack {
                    ZStack {
                        Color.appTheme.edgesIgnoringSafeArea(.all)
                        HomeView(
                            viewModel: HomeViewModel(
                                sections: sections
                            )
                        )
                        .background(Color.appTheme)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .top) {
                    Color.appTheme
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 0)
                }
            }
    }
}

