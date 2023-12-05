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
@available(iOS 14.0, *)
@main
struct MetFlixApp: App {
    @Dependency(\.viewFactory) var viewFactory
    @Dependency(\.networkDebugConnection) var networkDebugConnection
    @State var networkDebugAction: NetworkDebuggerActions? = nil
    @State var selectedCommand: ApplicationDebugCommands = .application
    @State var isDebugViewShowing: Bool = false
    
    init() {
        launch()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationUI {
                ZView {
                    Color.appTheme
                        .ignoreSafeAreaForAlliOSVersions()
                    switch selectedCommand {
                    case .breakpoint:
                        AnyView(
                            viewFactory.makeView(input: .breakpoint)
                        )
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Text("Network Configuration")
                                        .robotoFont(style: .bold(.normal))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                        .shadow(color: .appThemeSecondary, radius: 3, x: 3, y: -3)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                                .ignoresSafeArea(.all, edges: [.top, .bottom])
                            }
                        }
                    case .application:
                        AnyView(
                            viewFactory.makeView(
                                input: .home
                            )
                        )
                    }
                }
                .background(Color.appTheme)
            }
            .overlay(
                Color.appTheme
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 80)
                    .position(x: UIScreen.main.bounds.width/2, y: -33)
            )
            .overlay(
                Color.appTheme
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 80)
                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-53)
            )
            
            .modifier(DebugShakeGestureModifier(selectedCommand: $selectedCommand, isShowing: $isDebugViewShowing, networkDebugAction: $networkDebugAction))
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
