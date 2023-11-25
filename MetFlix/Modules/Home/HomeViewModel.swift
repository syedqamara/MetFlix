//
//  HomeViewModel.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import Combine
import Dependencies

public protocol HomeViewModeling: ViewModeling {
    var error: Error? { get }
    var isLoading: Bool { get }
    var search: String { get set }
    var movies: [MovieUIM] { get set }
    
    func onAppear()
    func loadNextPage()
}

public final class HomeViewModel {
    @Published public var error: Error?
    @Published public var movies: [MovieUIM]
    @Published public var isLoading: Bool = false
    @Published public var search: String = ""
    private var cancellable: Set<AnyCancellable> = []
    private var isLoadingNextPage: Bool = false
    private var moviesResult: PaginatedResultUIM<MovieUIM>?
    private let searchQueue = DispatchQueue(label: "com.search.queue", qos: .background)
    @Dependency(\.movieService) var movieService
    public init(moviesResult: PaginatedResultUIM<MovieUIM>?) {
        self.moviesResult = moviesResult
        self.movies = moviesResult?.results ?? []
        $search
            .sink { searchText in
                self.search(name: searchText)
            }
            .store(in: &cancellable)
    }
    private func loadMovie(page: Int) async throws {
        let result = try await self.movieService.getPopular(query: .init())
        let newMovies: [MovieUIM] = result.results.map { .init(dataModel: $0) }
        if result.page == 1 {
            self.moviesResult = .init(dataModel: result)
            DispatchQueue.main.async {
                self.movies = newMovies
            }
        }
        else {
            self.moviesResult?.results.append(contentsOf: newMovies)
            self.moviesResult?.page = result.page
            self.moviesResult?.totalPages = result.totalPages
            self.moviesResult?.totalResults = result.totalResults
            DispatchQueue.main.async {
                self.movies.append(contentsOf: newMovies)
            }
        }
    }
}


extension HomeViewModel: HomeViewModeling {
    
    public func loadNextPage() {
        guard let previousResult = self.moviesResult,
        !isLoadingNextPage,
        (previousResult.page + 1) < previousResult.totalPages else { return }
        isLoadingNextPage = true
        Task {
            do {
                try await self.loadMovie(page: previousResult.page + 1)
                DispatchQueue.main.async {
                    self.isLoadingNextPage = false
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    self.isLoadingNextPage = false
                    self.error = error
                }
            }
        }
    }
    public func onAppear() {
        isLoading = true
        Task {
            do {
                try await self.loadMovie(page: 1)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = error
                }
            }
        }
    }
        
    public func search(name: String) {
        if let result = self.moviesResult {
            if name.isEmpty {
                self.movies = result.results
            } else {
                searchQueue.sync {
                    let filteredMovie = result.results.filter { $0.allow(search: name) }
                    DispatchQueue.main.async {
                        self.movies = filteredMovie
                    }
                }
            }
        }
    }
}
