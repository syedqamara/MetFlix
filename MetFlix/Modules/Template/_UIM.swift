//
//  _UIM.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import core_architecture


public enum _UIM: UIModel {
    public struct DataModelType {
        public var error: Error?
    }
    
case none, error(Error)
    
    public init(dataModel: DataModelType) {
        if let error = dataModel.error {
            self = .error(error)
        }
        else {
            self = .none
        }
    }
    func isSameSection(_ section: _UIM) -> Bool {
        switch self {
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

extension _UIM: Identifiable {
    public var id: String {
        switch self {
        case .none:
            return "none"
        case .error(_):
            return "error"
        }
    }
}

