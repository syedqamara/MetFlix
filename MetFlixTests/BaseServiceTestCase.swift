//
//  BaseServiceTestCase.swift
//  MetFlixTests
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import MetFlix
extension BaseTestCase {
    typealias ServiceDependency = (
        episodeService: MockMindValleyServiceProtocol,
        channelService: MockMindValleyServiceProtocol,
        categoryService: MockMindValleyServiceProtocol,
        imageService: MockMindValleyServiceProtocol
    )
}
