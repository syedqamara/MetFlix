//
//  Categories+Preview.swift
//  MetFlix
//
//  Created by Apple on 01/12/2023.
//

import Foundation

public extension Category {
    static var preview: Category {
        return Category(name: "Preview Category")
    }
}

public extension CategoriesApiData {
    static var preview: CategoriesApiData {
        let previewCategories = Categories.preview
        return CategoriesApiData(data: previewCategories)
    }
    static var preview2: CategoriesApiData {
        let previewCategories = Categories.preview2
        return CategoriesApiData(data: previewCategories)
    }
    static var preview3: CategoriesApiData {
        let previewCategories = Categories.preview3
        return CategoriesApiData(data: previewCategories)
    }
}

public extension Categories {
    static var preview: Categories {
        let previewCategory1 = Category(name: "Preview")
        let previewCategory2 = Category(name: "Preview Category 2")
        return Categories(categories: [previewCategory1, previewCategory2])
    }
    static var preview2: Categories {
        let previewCategory1 = Category(name: "Preview 2")
        let previewCategory2 = Category(name: "Preview 2 Category 2")
        return Categories(categories: [previewCategory1, previewCategory2])
    }
    static var preview3: Categories {
        let previewCategory1 = Category(name: "Preview 3")
        let previewCategory2 = Category(name: "Preview 3 Category 2")
        return Categories(categories: [previewCategory1, previewCategory2])
    }
}
