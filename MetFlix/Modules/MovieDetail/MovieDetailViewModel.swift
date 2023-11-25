//
//  MovieDetailViewModel.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Dependencies

public protocol MovieDetailViewModeling: ViewModeling {
    var movieId: Int { get set }
    var movieDetail: MovieDetailUIM? { get }
    var error: Error? { get }
    var isLoading: Bool { get }
    func onAppear()
}

public final class MovieDetailViewModel {
    @Published public var movieDetail: MovieDetailUIM?
    @Published public var error: Error? = nil
    @Published public var isLoading: Bool = false
    
    // Private Properties
    public var movieId: Int
    @Dependency(\.movieService) private var movieService
    
    public init(movieDetail: MovieDetailUIM?, movieId: Int) {
        self.movieDetail = movieDetail
        self.movieId = movieId
    }
}

extension MovieDetailViewModel: MovieDetailViewModeling {
    public func onAppear() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            [weak self] in
            guard let self else { return }
            do {
                let detail = try await movieService.get(by: "\(self.movieId)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.movieDetail = .init(dataModel: detail)
                }
            }
            catch let err {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = err
                }
            }
        }
    }
}
