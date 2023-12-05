//
//  HomeSnapshotTest.swift
//  MetFlixTests
//
//  Created by Apple on 05/12/2023.
//

import Foundation
@testable import MetFlix
import XCTest
import Dependencies
import Combine
import SwiftUI

final class HomeSnapshotTest: BaseTestCase<BaseTestCase.ServiceDependency> {
    var homeViewModel: HomeViewModel?
    private func loadAllServiceSection() {
        homeViewModel = HomeViewModel(sections: [
            .episodes(nil),
            .channels(nil),
            .categories(nil)
        ])
    }
    private func setup(episode: MockMindValleyServiceProtocol.Returned, category: MockMindValleyServiceProtocol.Returned, channel: MockMindValleyServiceProtocol.Returned) {
        guard let dependency else { return }
        let mockVoid = MockFunctionArgument(argumentLastValue: "mock")
        
        dependency.episodeService.parameter = .none(mockVoid)
        dependency.episodeService.returned = episode
        
        dependency.channelService.parameter = .none(mockVoid)
        dependency.channelService.returned = channel
        
        dependency.categoryService.parameter = .none(mockVoid)
        dependency.categoryService.returned = category
    }
    
    override func setUp() async throws {
        prepare {
            @Dependency(\.episodeService) var episodeService
            @Dependency(\.channelService) var channelService
            @Dependency(\.categoryService) var categoryService
            @Dependency(\.imageService) var imageService
            
            let arg = (
                episodeService: episodeService as! MockMindValleyServiceProtocol,
                channelService: channelService as! MockMindValleyServiceProtocol,
                categoryService: categoryService as! MockMindValleyServiceProtocol,
                imageService: imageService as! MockMindValleyServiceProtocol
            )
            
            
            
            return arg
        }
    }
    func setupVoidMockings() {
        let mockVoid = MockFunctionArgument(argumentLastValue: "mock")
        
        setup(
            episode: .none(mockVoid),
            category: .none(mockVoid),
            channel: .none(mockVoid)
        )
    }
}

extension HomeSnapshotTest {
    func testSnapshots_iPhone13() {
        HomeView_Previews.snapshots.assertSnapshots(as: .image(layout: .device(config: .iPhone13)))
    }
}
