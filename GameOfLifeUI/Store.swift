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
    
    init(liveCells: Set<Point>, width: Int, height: Int) {
        self.cells = (0..<width).map{ x in
            (0..<height).map{ y in
                liveCells.contains(Point(x: x, y: y)) ? "X" : " "
            }
        }
    }
}
