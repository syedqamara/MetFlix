//
//  Debugger+Extensions.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import Debugger
extension NetworkDebuggerActions: Identifiable {
    public var id: String {
        self.configID + self.debugID
    }
}
