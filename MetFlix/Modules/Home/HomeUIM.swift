//
//  HomeUIM.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture


public enum HomeSectionUIM: UIModel {
    public struct DataModelType {
        public var episodes: EpisodesApiData?
        public var channels: ChannelsApiData?
        public var categories: CategoriesApiData?
        public var error: Error?
    }
    
case episodes(EpisodesDataUIM?), channels(ChannelsDataUIM?), categories(CategoriesDataUIM?), none, error(Error)
    
    public init(dataModel: DataModelType) {
        if let episodes = dataModel.episodes {
            self = .episodes(.init(dataModel: episodes))
        }
        else if let channels = dataModel.channels {
            self = .channels(.init(dataModel: channels))
        }
        else if let categories = dataModel.categories {
            self = .categories(.init(dataModel: categories))
        }
        else if let error = dataModel.error {
            self = .error(error)
        }
        else {
            self = .none
        }
    }
}

extension HomeSectionUIM: Identifiable {
    public var id: String {
        switch self {
        case .episodes(_):
            return "episodes"
        case .channels(_):
            return "channels"
        case .categories(_):
            return "categories"
        case .none:
            return "none"
        case .error(_):
            return "error"
        }
    }
}

