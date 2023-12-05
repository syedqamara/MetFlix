//
//  MetFlixTests.swift
//  MetFlixTests
//
//  Created by Apple on 22/11/2023.
//

import XCTest
@testable import MetFlix
import Dependencies

class BaseTestCase<S>: XCTestCase {
    var dependency: S?
    
    public func prepare(completion: () -> S) {
        self.dependency = completion()
    }
}
