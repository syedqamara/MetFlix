//
//  EpisodesViewModel.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture

public protocol EpisodesViewModeling: ViewModeling {
    var episodes: EpisodesDataUIM? { get }
}

public class EpisodesViewModel: EpisodesViewModeling {
    @Published public var episodes: EpisodesDataUIM?
    public init(episodes: EpisodesDataUIM? = nil) {
        self.episodes = episodes
    }
}
