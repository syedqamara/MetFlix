//
//  MovieDetailView.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import SwiftUI
import PreviewSnapshots

public struct MovieDetailView<V: MovieDetailViewModeling>: MovieDetailViewProtocol {
    public typealias ViewModelType = V
    @ObservedObject var viewModel: V
    @Environment(\.dismiss) var dismiss
    public init(viewModel: V) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all, edges: [.top, .bottom])
            VStack {
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
                        mainView()
                            .ignoresSafeArea(.all, edges: [.top, .bottom])
                    }
                }
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                    Spacer()
                    if let detail = viewModel.movieDetail{
                        Text(detail.title)
                            .font(.title.bold())
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 5, x: 3, y: -3)
                            .padding(.trailing)
                    }
                }
                .onTapGesture {
                    dismiss.callAsFunction()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: [.top, .bottom])
        .onAppear() {
            viewModel.onAppear()
        }
    }
    @ViewBuilder
    private func mainView() -> some View {
        if let detail = viewModel.movieDetail {
            MovieDetailContentView(
                movieDetail: detail
            )
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .navigationTitle(detail.title)
        } else {
            EmptyView()
        }
    }
}









// MARK: - TagListView



// MARK: - TagView



// MARK: - ExpandableTextView


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: PreviewSnapshots<MovieDetail> {
        .init(
            configurations: [
                .init(name: "The Creator Preview", state: .preview)
            ]) { movieDetail in
                MovieDetailView<MovieDetailViewModel>(
                    viewModel: .init(
                        movieDetail: .init(dataModel: movieDetail),
                        movieId: 0
                    )
                )
                    .navigationTitle("AAA")
                    .background(.black)
                    .ignoresSafeArea(edges: .top)
                    .overlay(alignment: .top) {
                        Color.black
                            .ignoresSafeArea(edges: .top)
                            .frame(height: 0)
                    }
            }
    }
}
