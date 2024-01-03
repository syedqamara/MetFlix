//
//  _View.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI
import DebuggerUI

struct _View<VM: _ViewModeling>: SwiftUIView {
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
        if #available(iOS 15.0, *) {
            content
                .refreshable {
                    viewModel.refresh()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        navigationTitleView()
                    }
                }
        } else {
            content
                .navigationBarItems(leading: navigationTitleView())
        }
    }
    func navigationTitleView() -> some View {
        HView {
            Text("Channels")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Spacer()
        }
    }
    var content: some View {
        ScrollView {
            VView {
                ForEach(viewModel.sections) { section in
                    switch section {
                    case .error(let error):
                        PlaceholderView(
                            placeholder: .error(error.localizedDescription)
                        )
                        .background(Color.appTheme)
                    default:
                        HView{}
                    }
                }
            }
            .background(Color.appTheme)
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct _View_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: Previewer<[_UIM]> {
        .init(
            configurations: [
                .init(name: "Empty", state: []),
                .init(name: "Static", state: []),
                .init(name: "Live", state: []),
                .init(name: "Error", state: [
                    _UIM.error(NSError(domain: "com", code: 1, userInfo: [
                        NSLocalizedDescriptionKey:  """
This is a mock error message, containing dummy representation of an error scenario.
"""
                    ]))
                ]),
                .init(name: "Static Episode", state: []),
                .init(name: "Static Channels", state: []),
                .init(name: "Static Categories", state: [])
            ]) { (sections: [_UIM]) in
                NavigationUI {
                    ZView {
                        Color.appTheme.ignoreSafeAreaForAlliOSVersions()
                        _View(
                            viewModel: _ViewModel(
                                sections: sections
                            )
                        )
                        .background(Color.appTheme)
                    }
                }
                .ignoreSafeAreaForAlliOSVersions()
                .overlay(Color.appTheme)
            }
    }
}

