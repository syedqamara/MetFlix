//
//  ContentView.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import SwiftUI

enum ApplicationCommands: String, CustomStringConvertible, CaseIterable {
case application, breakpoint
    var description: String {
        switch self {
        case .application:
            return "Application"
        case .breakpoint:
            return "Breakpoint"
        }
    }
    var shortcut: String {
        switch self {
        case .application:
            return "A"
        case .breakpoint:
            return "B"
        }
    }
}
