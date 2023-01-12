//
//  Piece.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import Foundation
import SwiftUI

struct Location: Equatable, Hashable {
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

protocol Piece: Moveable & Displayable {}

protocol Moveable: Identifiable  {
    var isSelected: Bool {set get}
    var isNPC: Bool {get}
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
    func getMoves()->[Location]
    func getCanMove()->Bool
    
}
extension Moveable {
    mutating func incrementMoveCounter() {
        movementCount = (movementCount + 1)
    }
    func getCanMove()->Bool {
        true
    }
    func getMoves()->[Location] {
        guard let currentLoc = board.getLocation(of: self) else { return [] }
        
        var locs = [Location]()
        for vector in vectors {
            locs.append(combine(vector: vector, location: currentLoc))
        }
        return locs
    }
    
    func combine(vector: Vector, location: Location) -> Location {
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
        return Vector(row: row, col: col) + location
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount)")
    }

}

protocol Displayable {
    func getView()-> AnyView
}

typealias Vector = Location
enum Direction {
    case up, down, left, right
}
func +(lhs: Location, rhs: Location) -> Location {
    let r = lhs.row + rhs.row
    let c = lhs.col + rhs.col
    return Location(row: r, col: c)
}
