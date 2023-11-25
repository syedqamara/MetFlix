//
//  HomeView.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import SwiftUI
import Dependencies

public protocol HomeViewProtocol: SwiftUIView {
    
}

public struct HomeView<V: HomeViewModeling>: HomeViewProtocol {
    public typealias ViewModelType = V
    @ObservedObject var viewModel: V
    @Dependency(\.viewFactory) var viewFactory
    public init(viewModel: V) {
        self.viewModel = viewModel
        
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .red
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    }
    
    public var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea(.all, edges: [.top, .bottom])
                ScrollView(content: {
                    VStack {
                        TextField(text: $viewModel.search) {
                            Text("Search by movie title...")
                                .foregroundColor(.red.opacity(0.85))
                                .font(.title)
                        }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red.opacity(0.85), lineWidth: 2)
                            )
                            .textFieldStyle(.plain)
                            .font(.title)
                            .foregroundColor(.red)
                            .background(Color.black)
                            .padding(.horizontal)
                        Spacer(minLength: 20)
                        if viewModel.isLoading {
                            AnimatedView(
                                animationFileName: Config.Lottie.loadingAnimation,
                                loopMode: .loop,
                                size: .init(
                                    width: 100,
                                    height: 100
                                )
                            )
                            .frame(height: 100)
                            Spacer()
                        } else {
                            if let err = viewModel.error {
                                PlaceholderView(placeholder: .error(err.localizedDescription))
                            } else {
                                if viewModel.search.isEmpty {
                                    mainView()
                                } else {
                                    if viewModel.movies.isEmpty {
                                        PlaceholderView(placeholder: .noResult("No Movies found for '\(viewModel.search)'"))
                                    } else {
                                        mainView()
                                    }
                                }
                            }
                        }
                    }
                    .onAppear() {
                        viewModel.onAppear()
                    }
                })
                .refreshable {
                    viewModel.onAppear()
                }
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Metflix Movies")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .shadow(color: .red, radius: 3, x: 3, y: -3)
                        Spacer()
                    }
                    .ignoresSafeArea(.all, edges: [.top, .bottom])
                }
            }
        }
        .ignoresSafeArea(.all, edges: [.top, .bottom])
        
    }
    
    @ViewBuilder
    private func mainView() -> some View {
        ForEach($viewModel.movies) { movie in
            NavigationLink {
                AnyView(
                    viewFactory.makeView(input: .movie(movie.id))
                )
            } label: {
                MovieCardView(movie: movie)
                    .padding(.horizontal)
                    .frame(height: 500)
                    
            }
            .id(movie.id)
        }
    }
    
}
