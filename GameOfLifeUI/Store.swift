//
//  Store.swift
//  GameOfLifeUI
//
//  Created by Heiko Goes on 07.03.20.
//  Copyright © 2020 Heiko Goes. All rights reserved.
//

import Foundation

typealias ViewModel = [[Character]]

//typealias ViewModel = [String]

class Store: ObservableObject {
    @Published var cells: ViewModel
    
    private let size: Size
    private let allPoints: [Point]
    private var liveCells: Set<Point>
    
    init(liveCells: Set<Point>, size: Size) {
        self.size = size
        self.allPoints = getAllPointsFlat(size)
        self.liveCells = liveCells
        self.cells = Store.createCells(liveCells: liveCells, size: size)
    }
    
    private static func createCells(liveCells: Set<Point>, size: Size) -> ViewModel {
        return getAllPoints(size).map{ rows in
            (rows).map{ point in
                liveCells.contains(point) ? "X" : " "
            }
        }
    }
    
    func nextGeneration() {
        liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
        cells = Store.createCells(liveCells: liveCells, size: size)
    }
}
