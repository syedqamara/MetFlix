//
//  CategoriesViewModel.swift
//  MetFlix
//
//  Created by Apple on 03/12/2023.
//

import Foundation
import core_architecture
import Dependencies



final public class CategoriesViewModel: CategoriesViewModeling {
    @Published public var categories: CategoriesDataUIM?
    public init(categories: CategoriesDataUIM? = nil) {
        self.categories = categories
    }
}
