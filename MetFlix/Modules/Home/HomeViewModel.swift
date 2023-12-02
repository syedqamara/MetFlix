//
//  HomeViewModel.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies


public class HomeViewModel: HomeViewModeling {
    @Published public var error: Error?
    @Published public var isLoading: Bool
    @Published public var search: String
    @Published public var sections: [HomeSectionUIM] = []
    @Dependency(\.mindValleyService) var mindValleyService
    
    public init(error: Error? = nil, isLoading: Bool = true, search: String = "", sections: [HomeSectionUIM] = []) {
        self.error = error
        self.isLoading = isLoading
        self.search = search
        self.sections = sections
    }
    private func update(section: HomeSectionUIM, at index: Int) {
        DispatchQueue.main.async {
            self.sections[index] = section
        }
    }
}

extension HomeViewModel {
    public func onAppear() {
        loadEpisodes()
        loadChannels()
        loadCategories()
    }
    private func loadEpisodes() {
        Task {
            do {
                let episodes = try await mindValleyService.episodes()
                let episodesUIM = EpisodesDataUIM(dataModel: episodes)
                self.update(section: .episodes(episodesUIM), at: 0)
            }
            catch let err {
                self.update(section: .error(err), at: 0)
            }
            
        }
    }
    private func loadChannels() {
        Task {
            do {
                let channels = try await mindValleyService.channels()
                let channelsUIM = ChannelsDataUIM(dataModel: channels)
                self.update(section: .channels(channelsUIM), at: 1)
            }
            catch let err {
                self.update(section: .error(err), at: 1)
            }
        }
    }
    private func loadCategories() {
        Task {
            do {
                let categories = try await mindValleyService.categories()
                let categoriesUIM = CategoriesDataUIM(dataModel: categories)
                self.update(section: .categories(categoriesUIM), at: 2)
            }
            catch let err {
                self.update(section: .error(err), at: 2)
            }
        }
    }
}
