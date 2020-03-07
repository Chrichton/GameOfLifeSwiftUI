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
    
    private let width: Int
    private let height: Int
    private let allPoints: Set<Point>
    private var liveCells: Set<Point>
    
    init(liveCells: Set<Point>, width: Int, height: Int) {
        self.width = width
        self.height = height
        self.allPoints = getAllPoints(width: width, height: height)
        self.liveCells = liveCells
        self.cells = Store.createCells(liveCells: liveCells, width: width, height: height)
    }
    
    private static func createCells(liveCells: Set<Point>, width: Int, height: Int) -> [[String]] {
        return (0..<width).map{ x in
            (0..<height).map{ y in
                liveCells.contains(Point(x: x, y: y)) ? "X" : " "
            }
        }
    }
    
    func nextGeneration() {
        liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
        cells = Store.createCells(liveCells: liveCells, width: width, height: height)
    }
}
