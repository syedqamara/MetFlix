//
//  ChannelsViewModel.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import core_architecture




public class ChannelsViewModel: ChannelsViewModeling {
    @Published public var channels: ChannelsDataUIM?
    public init(channels: ChannelsDataUIM? = nil) {
        self.channels = channels
    }
}
