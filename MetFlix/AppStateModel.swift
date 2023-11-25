//
//  AppStateModel.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import DebuggerUI
import Dependencies

class AppStateModel: ObservableObject {
    @Dependency(\.networkDebugConnection) var networkDebugConnection
}
