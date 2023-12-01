//
//  Categories.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation
import core_architecture

protocol Previewable: DataModel {
    static var preview: Self { get }
}

public struct Category: DataModel {
    public let name: String
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    public init(name: String) {
        self.name = name
    }
}

public struct CategoriesApiData: DataModel {
    public let data: Categories
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(Categories.self, forKey: .data)
    }
    public init(data: Categories) {
        self.data = data
    }
    
}

public struct Categories: DataModel {
    public let categories: [Category]
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categories = try container.decode([Category].self, forKey: .categories)
    }
    public init(categories: [Category]) {
        self.categories = categories
    }
}
