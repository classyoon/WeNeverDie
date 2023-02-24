//
//  Piece.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import Foundation
import SwiftUI

struct Coord: Equatable, Hashable {
    var row: Int = 0
    var col: Int = 0
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    init(row: Int) {
        self.row = row
        self.col = 0
    }
    init(col: Int) {
        self.row = 0
        self.col = col
    }
    init() {
        self.row = 0
        self.col = 0
    }
}

protocol Piece: Moveable & Displayable {
    var id : UUID {set get}
}

protocol Moveable: Identifiable  {
    var isPlayerUnit : Bool {get}
    var isHidden : Bool {set get}
    var alert : Bool {set get}
    var isSelected: Bool {set get}
    var health: Int {set get}
    var damage: Int {set get}
    var id: UUID { set get }
    var board: BoardProtocol { set get }
    var vectors: [Vector] { set get }
    var facing: Direction { set get }
    var stamina: Int { get }
    var movementCount: Int { set get }
    var faction: String {set get}
    mutating func incrementMoveCounter()
    func getMoves()->[Coord]
    func getCanMove()->Bool
    
}
extension Moveable {
    mutating func incrementMoveCounter() {
        movementCount = (movementCount + 1)
    }
    func getCanMove()->Bool {
        true
    }
    func getMoves()->[Coord] {
        guard let currentLoc = board.getCoord(of: self) else { return [] }
        
        var locs = [Coord]()
        for vector in vectors {
            locs.append(combine(vector: vector, Coord: currentLoc))
        }
        return locs
    }
    
    func combine(vector: Vector, Coord: Coord) -> Coord {
        var row = vector.row
        var col = vector.col
        
        switch facing {
        case .up:
            row = -row
        case .down:
            break
        case .left:
            col = -col
        case .right:
            break
        }
        return Vector(row: row, col: col) + Coord
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount)")
    }

}

protocol Displayable {
    func getView()-> AnyView
}

typealias Vector = Coord
enum Direction {
    case up, down, left, right
}
func +(lhs: Coord, rhs: Coord) -> Coord {
    let r = lhs.row + rhs.row
    let c = lhs.col + rhs.col
    return Coord(row: r, col: c)
}
