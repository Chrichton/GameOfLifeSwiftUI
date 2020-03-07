//
//  Store.swift
//  GameOfLifeUI
//
//  Created by Heiko Goes on 07.03.20.
//  Copyright © 2020 Heiko Goes. All rights reserved.
//

import Foundation

class Store: ObservableObject {
    @Published var cells: [[String]]
    
    init(cells: [[String]] = [[]]) {
        self.cells = cells
    }
}
