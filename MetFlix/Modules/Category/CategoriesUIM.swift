//
//  CategoriesUIM.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture
public struct CategoryUIM: UIModel {
    public typealias DataModelType = Category
    public var name: String? = nil

    public init(dataModel: Category) {
        if let name = dataModel.name {
            self.name = name
        }
    }
}

public struct CategoriesDataUIM: UIModel {
    public typealias DataModelType = CategoriesApiData
    public var data: CategoriesUIM? = nil

    public init(dataModel: CategoriesApiData) {
        if let data = dataModel.data {
            self.data = .init(dataModel: data)
        }
    }
}

public struct CategoriesUIM: UIModel {
    public typealias DataModelType = Categories
    public var categories: [CategoryUIM]? = nil

    public init(dataModel: Categories) {
        if let categories = dataModel.categories {
            self.categories = categories.map { CategoryUIM(dataModel: $0) }
        }
    }
}
