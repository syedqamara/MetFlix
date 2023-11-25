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
    
    init() {
        launch()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch selectedCommand {
                case .breakpoint:
                    AnyView(
                        viewFactory.makeView(
                            input: .breakpoint
                        )
                    )
                case .application:
                    AnyView(
                        viewFactory.makeView(
                            input: .home
                        )
                    )
                    .ignoresSafeArea(.all, edges: [.top, .bottom])
                }
            }
            .overlay(alignment: .top) {
                Color.black
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
            .onShakeGesture {
                switch selectedCommand {
                case .application:
                    selectedCommand = .breakpoint
                case .breakpoint:
                    selectedCommand = .application
                }
            }
            .sheet(item: $networkDebugAction, content: { action in
                self.debugView(action: action)
            })
            .onReceive(networkDebugConnection.$debuggingAction) { debuggingAction in
                guard let action: NetworkDebuggerActions = debuggingAction else { return }
                self.networkDebugAction = action
            }
        }
    }
    private func debugView(action: NetworkDebuggerActions) -> AnyView {
        AnyView(
            viewFactory.makeView(
                input: .debug(action)
            )
        )
    }
}
