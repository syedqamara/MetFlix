//
//  _Abstracts.swift
//  MetFlix
//
//  Created by Apple on 04/01/2024.
//

import Foundation
import core_architecture
protocol _ViewModeling: ViewModeling {
    var sections: [_UIM] { get set }
    func onAppear()
    func refresh()
}
