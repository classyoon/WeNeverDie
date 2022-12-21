//
//  Board.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import Foundation

protocol BoardProtocol {
    var rowMax: Int { get }
    var colMax: Int { get }
    func getLocation(of moveable: any Moveable) -> Location?
}

class Board : ObservableObject, BoardProtocol {
    @Published private(set) var board: [[(any Piece)?]] = [[]]
    @Published var isTapped = false
    @Published var tappedLoc : Location?{
        didSet{
            setPossibleLocations()
        }
    }
    @Published var possibleLoc: [Location] = []
    
    let rowMax: Int = 10
    let colMax: Int = 8

    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
//        set(moveable: Checker(board: self), location: Location(row: 1, col: 1))
//        set(moveable: Pawn(board: self), location: Location(row: 4, col: 4))
        set(moveable: King(board: self), location: Location(row: 0, col: 0))
//        set(moveable: Knight(board: self), location: Location(row: 5, col: 2))
    }
}

extension Board {
    // MARK: Not private
    
    func nextTurn(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[col][row] != nil) {
                    board[col][row]?.movementCount = 0
                }
            }
        }
    }
    
    func findStats()->String{
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[col][row] != nil)&&((board[col][row]?.isSelected) != nil) {
                    
                    return "\(String(describing: board[col][row]?.movementCount)) / \(String(describing: board[col][row]?.stamina))"
                }
            }
        }
        
        return ""
    }
    
    func isPossibleLoc(row: Int, col: Int) -> Bool {
        for loc in possibleLoc {
            if loc.row == row && loc.col == col {
                return true
            }
        }
        return false
    }

    func handleTap(row: Int, col: Int) {
        if isTapped == false { 
            tappedLoc = Location(row: row, col: col)
        }else{
            if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col) {
                if var piece = board[tappedCol][tappedRow] {//If taps pice
                    if piece.getCanMove() {
                        piece.incrementMoveCounter()
                        board[col][row] = piece
                        board[tappedCol][tappedRow] = nil
                    }
//                    if 
                }
            }
            
            tappedLoc = nil
        }
        isTapped.toggle()
    }
    
    func getLocation(of moveable: any Moveable) -> Location? {
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if board[col][row]?.id == moveable.id {
                    return Location(row: row, col: col)
                }
            }
        }
        return nil
    }
    
    func seek(target : any Piece, seeker : any Piece){
        var targetPlace = getLocation(of: target)
        var seekerPlace = getLocation(of: seeker)
        var rowD = targetPlace?.row - seekerPlace?.row
        var colD = targetPlace?.col - seekerPlace?.col
        if rowD <
    }
    
    func set(moveable: any Piece, location: Location) {
        guard locationIsValid(location: location) else { return }
        board[location.col][location.row] = moveable
    }
}
extension Board {
    // MARK: Private Functions
    private func setPossibleLocations() {
        guard let loc = tappedLoc, let piece = board[loc.col][loc.row]
        else {
            possibleLoc = []
            return
        }
        possibleLoc = piece.getMoves()
    }
    private func locationIsValid(location: Location) -> Bool {
        location.row >= 0 && location.row < rowMax && location.col >= 0 && location.col < colMax
    }
}


