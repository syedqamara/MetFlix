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
                            viewFactory.makeView(input: .episodes(nil))
                        )
                    default:
                        AnyView(
                            viewFactory.makeView(input: .episodes(nil))
                        )
                    }
                }
            }
        }
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
        NavigationStack {
            ZStack {
                Color.appTheme.edgesIgnoringSafeArea(.all)
                HomeView(
                    viewModel: HomeViewModel(
                        sections: [
                            .episodes(nil),
                            .channels(nil),
                            .categories(nil),
                        ]
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
