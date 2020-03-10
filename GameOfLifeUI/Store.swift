//
//  Store.swift
//  GameOfLifeUI
//
//  Created by Heiko Goes on 07.03.20.
//  Copyright © 2020 Heiko Goes. All rights reserved.
//

import Foundation

typealias ViewModel = [String]

class Store: ObservableObject {
    @Published var rows: ViewModel
    
    private let size: Size
    private let allPoints: [Point]
    private var liveCells: Set<Point>
    
    init(liveCells: Set<Point>, size: Size) {
        self.size = size
        self.allPoints = getAllPointsFlat(size)
        self.liveCells = liveCells
        self.rows = Store.createCells(liveCells: liveCells, size: size)
    }
    
    private static func createCells(liveCells: Set<Point>, size: Size) -> ViewModel {
        getAllPoints(size).map{ row in
            row.reduce(into: ""){ accu, current in
                accu.append(liveCells.contains(current) ? "X" : " ")
            }
        }
    }
    
    func nextGeneration() {
        liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
        rows = Store.createCells(liveCells: liveCells, size: size)
    }
}
