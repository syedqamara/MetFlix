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
    func isSameSection(_ section: HomeSectionUIM) -> Bool {
        switch self {
        case .episodes(_):
            if case .episodes(_) = section {
                return true
            }
        case .channels(_):
            if case .channels(_) = section {
                return true
            }
        case .categories(_):
            if case .categories(_) = section {
                return true
            }
        case .none:
            if case .none = section {
                return true
            }
        case .error(_):
            if case .error(_) = section {
                return true
            }
        }
        return false
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

