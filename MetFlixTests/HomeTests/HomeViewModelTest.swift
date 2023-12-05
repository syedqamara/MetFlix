//
//  HomeViewModelTest.swift
//  MetFlixTests
//
//  Created by Apple on 27/11/2023.
//

import Foundation
@testable import MetFlix
import XCTest
import Dependencies
import Combine
import SwiftUI




final class HomeViewModelTest: BaseTestCase<BaseTestCase.ServiceDependency> {
    var homeViewModel: HomeViewModel?
    
    private func loadAllServiceSection() {
        homeViewModel = HomeViewModel(sections: [
            .episodes(nil),
            .channels(nil),
            .categories(nil)
        ])
    }
    private func loadWithoutServiceSection() {
        homeViewModel = HomeViewModel(sections: [])
    }
    private func loadEpisodeServiceSection() {
        homeViewModel = HomeViewModel(sections: [
            .episodes(nil)
        ])
    }
    private func loadChannelServiceSection() {
        homeViewModel = HomeViewModel(sections: [
            .channels(nil)
        ])
    }
    private func loadCategoryServiceSection() {
        homeViewModel = HomeViewModel(sections: [
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

// MARK: - OnAppear

extension HomeViewModelTest {
    
    func testOnAppearInvokedAllService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadAllServiceSection()
        homeViewModel?.onAppear()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.channelService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            if let service = self.dependency?.episodeService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            if let service = self.dependency?.categoryService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    func testOnAppearInvokedNoService() {
        setupVoidMockings()
        loadWithoutServiceSection()
        homeViewModel?.onAppear()
        if let service = self.dependency?.channelService {
            if case .none(let arg) = service.parameter {
                XCTAssertFalse(arg.isArgumentRecieved)
            }
        }
        if let service = self.dependency?.episodeService {
            if case .none(let arg) = service.parameter {
                XCTAssertFalse(arg.isArgumentRecieved)
            }
        }
        if let service = self.dependency?.categoryService {
            if case .none(let arg) = service.parameter {
                XCTAssertFalse(arg.isArgumentRecieved)
            }
        }
    }
    func testOnAppearInvokedChannelService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadChannelServiceSection()
        homeViewModel?.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.channelService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    func testOnAppearDidNotInvokedChannelService() {
        setupVoidMockings()
        loadWithoutServiceSection()
        homeViewModel?.onAppear()
        
        if let service = self.dependency?.channelService {
            if case .none(let arg) = service.parameter {
                XCTAssertFalse(arg.isArgumentRecieved)
            }
        }
    }
    func testOnAppearInvokedEpisodeService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadEpisodeServiceSection()
        homeViewModel?.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.episodeService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    func testOnAppearInvokedCategoryService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadCategoryServiceSection()
        homeViewModel?.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.categoryService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
}


// MARK: - Refresh

extension HomeViewModelTest {
    func testRefreshInvokedAllChannelService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadAllServiceSection()
        homeViewModel?.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.channelService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            if let service = self.dependency?.episodeService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            if let service = self.dependency?.categoryService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    
    func testRefreshInvokedChannelService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadChannelServiceSection()
        homeViewModel?.refresh()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.channelService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    func testRefreshInvokedEpisodeService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadEpisodeServiceSection()
        homeViewModel?.refresh()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.episodeService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
    func testRefreshInvokedCategoryService() {
        let expectation = XCTestExpectation(description: "")
        setupVoidMockings()
        loadCategoryServiceSection()
        homeViewModel?.refresh()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if let service = self.dependency?.categoryService {
                if case .none(let arg) = service.parameter {
                    XCTAssertTrue(arg.isArgumentRecieved)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: .init(5))
    }
}

// MARK: - Sections

extension HomeViewModelTest {
    
}

