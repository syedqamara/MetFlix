//
//  HomeViewModel.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
import Dependencies


public class HomeViewModel {
    @Published public var error: Error?
    @Published public var isLoading: Bool
    @Published public var search: String
    @Published public var sections: [HomeSectionUIM] = []
    private var defaultSections: [HomeSectionUIM]
    @Dependency(\.episodeService) var episodeService
    @Dependency(\.channelService) var channelService
    @Dependency(\.categoryService) var categoryService
    
    public init(error: Error? = nil, isLoading: Bool = true, search: String = "", sections: [HomeSectionUIM] = []) {
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

extension HomeViewModel: HomeViewModeling {
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
        
    }
}
