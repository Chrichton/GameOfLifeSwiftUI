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

struct Size {
    let height: Int
    let width: Int
}

extension Point: CustomStringConvertible {
    var description: String {
        return "\(x),\(y)"
    }
}

func getAllPoints(_ size: Size) -> [[Point]] {
    (0..<size.width).map{ x in
        (0..<size.height).map{ y in
            Point(x: x, y: y)
        }
    }
}

func getAllPointsFlat(_ size: Size) -> [Point] {
    getAllPoints(size).flatMap{ $0 }
}

func isPointInNeighborhood(_ point: Point, ofPoint: Point) -> Bool {
    return !(point.x == ofPoint.x && point.y == ofPoint.y) && point.x >= 0 && point.y >= 0
}

func getNeighbors(_ point: Point) -> Set<Point> {
    Set((point.x-1...point.x+1).flatMap{ x in
        (point.y-1...point.y+1).map{ y in
            Point(x: x, y: y)
        }
    })
    .filter{ isPointInNeighborhood($0, ofPoint: point)}
}

func isLiveCell(_ point: Point, liveCells: Set<Point>) -> Bool {
    let livingNeigborsCount = getNeighbors(point)
        .filter{ liveCells.contains($0) }
        .count
    
    let isLivingCell = liveCells.contains(point)
    return isLivingCell
        ? 2...3 ~= livingNeigborsCount
        : 3 == livingNeigborsCount
}

func getNextGeneration(liveCells: Set<Point>, allPoints: [Point]) -> Set<Point> {
    Set(allPoints.filter{ isLiveCell($0, liveCells: liveCells) })
}


func printGeneration(liveCells: Set<Point>, size: Size) {
    for y in 0..<size.height {
        for x in 0..<size.width {
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

//let allPoints = getAllPointsFlat(Size(height: 20, width: 20))
//var liveCells = blinker
//
//repeat {
//    printGeneration(liveCells: liveCells, size: Size(height: 20, width: 20))
//    liveCells = getNextGeneration(liveCells: liveCells, allPoints: allPoints)
//    usleep(20000)
//}  while liveCells.count > 0

