//
//  _ViewModel.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies


public class _ViewModel {
    @Published public var error: Error?
    @Published public var isLoading: Bool
    @Published public var search: String
    @Published public var sections: [HomeSectionUIM] = []
    private var defaultSections: [HomeSectionUIM]
    @Dependency(\.episodeService) var episodeService
    @Dependency(\.channelService) var channelService
    @Dependency(\.categoryService) var categoryService
    
    public init(error: Error? = nil, isLoading: Bool = true, search: String = "", sections: [_UIM] = []) {
        self.error = error
        self.isLoading = isLoading
        self.search = search
        self.sections = sections
        self.defaultSections = sections
    }
    private func update(section: HomeSectionUIM) {
        if let index = indexOf(section) {
            DispatchQueue.main.async {
                self.sections[index] = section
            }
        }
    }
    private func replace(section: HomeSectionUIM, with newSection: HomeSectionUIM) {
        if let index = indexOf(section) {
            DispatchQueue.main.async {
                self.sections[index] = newSection
            }
        }
    }
    func indexOf(_ section: HomeSectionUIM) -> Int? {
        for i in 0..<sections.count {
            let sect = sections[i]
            if sect.isSameSection(section) {
                return i
            }
        }
        return nil
    }
}
protocol _ViewModeling: ViewModeling {
    
}
extension HomeViewModel: _ViewModeling {
    public func onAppear() {
        loadData()
    }
    public func refresh() {
        self.sections = defaultSections
        loadData()
    }
}

extension HomeViewModel {
    private func loadData() {
        loadEpisodes()
        loadChannels()
        loadCategories()
    }
    private func loadEpisodes() {
        let episodeSection = sections.filter { section in
            if case .episodes(let episode) = section {
               return episode == nil
            }
            return false
        }
        guard episodeSection.isNotEmpty else { return }
        
        
        Task {
            do {
                let episodes = try await episodeService.episodes()
                let episodesUIM = EpisodesDataUIM(dataModel: episodes)
                self.update(section: .episodes(episodesUIM))
            }
            catch let err {
                self.replace(section: .episodes(nil), with: .error(err))
            }
            
        }
    }
    private func loadChannels() {
        let channelsSection = sections.filter { section in
            if case .channels(let channel) = section {
               return channel == nil
            }
            return false
        }
        guard channelsSection.isNotEmpty else { return }
        Task {
            do {
                let channels = try await channelService.channels()
                let channelsUIM = ChannelsDataUIM(dataModel: channels)
                self.update(section: .channels(channelsUIM))
            }
            catch let err {
                self.replace(section: .channels(nil), with: .error(err))
            }
        }
    }
    private func loadCategories() {
        let categoriesSection = sections.filter { section in
            if case .categories(let category) = section {
               return category == nil
            }
            return false
        }
        guard categoriesSection.isNotEmpty else {
            return
        }
        Task {
            do {
                let categories = try await categoryService.categories()
                let categoriesUIM = CategoriesDataUIM(dataModel: categories)
                self.update(section: .categories(categoriesUIM))
            }
            catch let err {
                self.replace(section: .categories(nil), with: .error(err))
            }
        }
    }
}
