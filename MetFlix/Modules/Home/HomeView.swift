//
//  HomeView.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import SwiftUI

public protocol HomeViewProtocol: SwiftUIView {
    
}

public struct HomeView<V: HomeViewModeling>: HomeViewProtocol {
    public typealias ViewModelType = V
    @ObservedObject var viewModel: V
    public init(viewModel: V) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("Welcome to Home Screen")
    }
    
}
