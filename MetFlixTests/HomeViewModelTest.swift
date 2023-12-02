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

final class HomeViewModelTest: XCTestCase {
    var anyCancellable: Set<AnyCancellable> = []
    func testonAppear() {
        let expectation = XCTestExpectation(description: "Network Test Call")
//        withDependencies { dep in
//            if let service = dep.movieService as? MockMovieServiceProtocol {
//                service.getPopularReturn.argumentLastValue = .preview
//            }
//        } operation: {
//            @Dependency(\.movieService) var movieService
//            
//            @ObservedObject var viewModel = HomeViewModel(moviesResult: nil)
//            
//            
//            XCTAssertTrue(viewModel.movies.isEmpty, "Movies should be empty before api call starts")
//            viewModel.onAppear()
//            XCTAssertTrue(viewModel.isLoading, "Is Loading should be true as soon as on Appear Calls")
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                if let movieService = movieService as? MockMovieServiceProtocol, movieService.getPopularQuery.isArgumentRecieved {
//                    XCTAssertTrue(viewModel.movies.isNotEmpty, "Movies List should not be empty")
//                    XCTAssert(movieService.getPopularQuery.isArgumentRecieved, "OnAppear invoked the getPopularMethod with Query parameter")
//                    if let serviceParameter = movieService.getPopularQuery.argumentLastValue {
//                        XCTAssert(serviceParameter.page == 1, "On Appear the page 1 should be fetch")
//                    }
//                }
//                expectation.fulfill()
//            }
//            
//        }
        wait(for: [expectation], timeout: .init(10))
    }
}
