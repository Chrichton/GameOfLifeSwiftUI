//
//  GameOfLife.swift
//  GameOfLifeUI
//
//  Created by Heiko Goes on 07.03.20.
//  Copyright © 2020 Heiko Goes. All rights reserved.
//

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
}

extension Point: CustomStringConvertible {
    var description: String {
        return "\(x),\(y)"
    }
}

func getAllPoints(width: Int, height: Int) -> Set<Point> {
    Set((0..<width).flatMap{ x in
        (0..<height).map{ y in
            Point(x: x, y: y)
        }
    })
}

func getAllNeighbors(_ point: Point) -> Set<Point> {
    Set((point.x-1...point.x+1).flatMap{ x in
        (point.y-1...point.y+1).map{ y in
            Point(x: x, y: y)
        }
    }
    .filter{ !($0.x == point.x && $0.y == point.y) })
}

func getNeighbors(_ point: Point, allPoints: Set<Point>) -> Set<Point> {
    getAllNeighbors(point)
        .intersection(allPoints)
}

func isLiveCell(_ point: Point, liveCells: Set<Point>, allPoints: Set<Point>) -> Bool {
    let livingNeigborsCount = getNeighbors(point, allPoints: allPoints)
        .filter{ liveCells.contains($0) }
        .count
    
    return liveCells.contains(point)
        ? 2...3 ~= livingNeigborsCount
        : 3 == livingNeigborsCount
}

func getNextGeneration(liveCells: Set<Point>, allPoints: Set<Point>) -> Set<Point> {
    allPoints.reduce(into: Set<Point>()){ accu, current in
        if isLiveCell(current, liveCells: liveCells, allPoints: allPoints) {
            accu.insert(current)
        }
    }
}

func printGeneration(liveCells: Set<Point>, width: Int, height: Int) {
    for y in 0..<height {
        for x in 0..<width {
            if liveCells.contains(Point(x: x, y: y)) {
                print("X", terminator:"")
            } else {
                print(" ", terminator:"")
            }
        }
        print("")
    }
}

let blinker = Set([Point(x: 5,y: 4), Point(x: 5,y: 5), Point(x: 5,y: 6)])
let glider  = Set([Point(x: 1,y: 0), Point(x: 2,y: 1), Point(x: 0,y: 2), Point(x: 1, y: 2), Point(x: 2, y: 2)])

//let allPoints = getAllPoints(width: 20, height: 20)
//var liveCells = Set([Point(x: 5,y: 4), Point(x: 5,y: 5), Point(x: 5,y: 6)])
////var liveCells = Set([Point(x: 1,y: 0), Point(x: 2,y: 1), Point(x: 0,y: 2), Point(x: 1, y: 2), Point(x: 2, y: 2)])
//
//repeat {
//    printGeneration(liveCells: liveCells, width: 20, height: 20)
//    liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
//    usleep(20000)
//}  while liveCells.count > 0

