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
    private let allPoints: Set<Point>
    private var liveCells: Set<Point>
    
    init(liveCells: Set<Point>, size: Size) {
        self.size = size
        self.allPoints = getAllPoints(size)
        self.liveCells = liveCells
        self.cells = Store.createCells(liveCells: liveCells, size: size)
    }
    
    private static func createCells(liveCells: Set<Point>, size: Size) -> ViewModel {
        return (0..<size.width).map{ x in
            (0..<size.height).map{ y in
                liveCells.contains(Point(x: x, y: y)) ? "X" : " "
            }
        }
    }
    
//    private static func createCells(liveCells: Set<Point>, size: Size) -> ViewModel {
//        partition
//    }
    
    func nextGeneration() {
        liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
        cells = Store.createCells(liveCells: liveCells, size: size)
    }
}
