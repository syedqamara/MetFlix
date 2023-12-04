//
//  MetFlixApp.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import SwiftUI
import Dependencies
import Debugger
import DebuggerUI
@main
struct MetFlixApp: App {
    @Dependency(\.viewFactory) var viewFactory
    @Dependency(\.networkDebugConnection) var networkDebugConnection
    @State var networkDebugAction: NetworkDebuggerActions? = nil
    @State var selectedCommand: ApplicationCommands = .application
    @State var selectedCommand: ApplicationDebugCommands = .breakpoint
    
    init() {
        launch()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack {
                    Color.appTheme
                        .edgesIgnoringSafeArea(.all)
                    switch selectedCommand {
                    case .breakpoint:
                        AnyView(
                            viewFactory.makeView(input: .breakpoint)
                        )
//                        .toolbar {
//                            ToolbarItem(placement: .principal) {
//                                HStack {
//                                    Text("Network Configuration")
//                                        .robotoFont(style: .bold(.title))
//                                        .multilineTextAlignment(.leading)
//                                        .foregroundColor(.white)
//                                        .shadow(color: .appThemeSecondary, radius: 3, x: 3, y: -3)
//                                        .fixedSize(horizontal: false, vertical: true)
//                                    Spacer()
//                                }
//                                .ignoresSafeArea(.all, edges: [.top, .bottom])
//                            }
//                        }
                    case .application:
                        AnyView(
                            viewFactory.makeView(
                                input: .home
                            )
                        )
                        .ignoresSafeArea(.all, edges: [.top, .bottom])
                    }
                }
            }
            .overlay(alignment: .top) {
                Color.appTheme
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
            .modifier(DebugShakeGestureModifier(selectedCommand: $selectedCommand))
        }
    }
    private func debugView(action: NetworkDebuggerActions) -> some View {
        AnyView(
            viewFactory.makeView(
                input: .debug(action)
            )
        )
        .environmentObject(networkDebugConnection)
    }
}
