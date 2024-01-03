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
    @Published public var sections: [_UIM] = []
    private var defaultSections: [_UIM]
    
    public init(error: Error? = nil, isLoading: Bool = true, sections: [_UIM] = []) {
        self.error = error
        self.isLoading = isLoading
        self.sections = sections
        self.defaultSections = sections
    }
    private func update(section: _UIM) {
        if let index = indexOf(section) {
            DispatchQueue.main.async {
                self.sections[index] = section
            }
        }
    }
    private func replace(section: _UIM, with newSection: _UIM) {
        if let index = indexOf(section) {
            DispatchQueue.main.async {
                self.sections[index] = newSection
            }
        }
    }
    func indexOf(_ section: _UIM) -> Int? {
        for i in 0..<sections.count {
            let sect = sections[i]
            if sect.isSameSection(section) {
                return i
            }
        }
        return nil
    }
}

extension _ViewModel: _ViewModeling {
    public func onAppear() {
        loadData()
    }
    public func refresh() {
        self.sections = defaultSections
        loadData()
    }
}

extension _ViewModel {
    private func loadData() {
        
    }
}
