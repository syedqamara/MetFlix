//
//  MockViewModel.swift
//  MetFlix
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import core_architecture

class MockHomeViewModel: Mocking<MockHomeViewModel.Parameter, MockHomeViewModel.Returned> ,HomeViewModeling {
    enum Parameter {
        case sections(MockFunctionArgument<[HomeSectionUIM]>)
        case none(MockFunctionArgument<String>)
        var rawValue: String {
            switch self {
            case .sections(_):
                return "sections"
            case .none(_):
                return "none"
            }
        }
    }
    enum Returned {
        case sections(MockFunctionArgument<[HomeSectionUIM]>)
        case none(MockFunctionArgument<String>)
        var rawValue: String {
            switch self {
            case .sections(_):
                return "sections"
            case .none(_):
                return "none"
            }
        }
    }
    
    var sections: [HomeSectionUIM] {
        get {
            if case .sections(let arg) = returned {
                if let value = arg.argumentLastValue {
                    arg.invoked(by: value)
                    return value
                }
            }
            return []
        }
        set {
            if case .sections(let arg) = parameter {
                arg.invoked(by: newValue)
            }
        }
    }
    
    func onAppear() {
        if case .none(let arg) = parameter {
            arg.invoked(by: UUID().uuidString)
        }
        if case .none(let arg)  = returned {
            arg.invoked(by: nil)
        }
    }
    
    func refresh() {
        if case .none(let arg) = parameter {
            arg.invoked(by: UUID().uuidString)
        }
        if case .none(let arg)  = returned {
            arg.invoked(by: nil)
        }
    }
}

