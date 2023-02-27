//
//  BoardFunctions.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import Foundation
extension Board {
    func increaseMoveCount(row: Int, col: Int) {
        if let tappedCol = highlightSquare?.col, let tappedRow = highlightSquare?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
            piece.incrementMoveCounter()
        }
        
    }
    func setPossibleCoords() {
        guard let loc = highlightSquare, let piece = board[loc.row][loc.col]
        else {
            possibleLoc = []
            return
        }
        //        print("\(piece.getMoves())")
        possibleLoc = piece.getMoves()
    }
    func CoordIsValid(Coord: Coord) -> Bool {
        Coord.row >= 0 && Coord.row < rowMax && Coord.col >= 0 && Coord.col < colMax
    }
    func safeNum(c : Int)->Int{
        if c>colMax-1{
            //print("caught over shoot in col")
            return colMax-1
        }
        else if c<0 {
           // print("caught under shoot in col")
            return 0
        }
        return c
    }
    func safeNum(r : Int)->Int{
        if r>rowMax-1{
          //  print("caught over shoot in row")
            return rowMax-1
        }
        else if r<0 {
            //print("caught under shoot in row")
            return 0
        }
        return r
    }
    func isPossibleLoc(row: Int, col: Int) -> Bool {
        for loc in possibleLoc {
            if loc.row == row && loc.col == col {
                return true
            }
        }
        return false
    }
    func set(moveable: any Piece, Coord: Coord) {
        guard CoordIsValid(Coord: Coord) else { return }
        board[Coord.row][Coord.col] = moveable
        //findInRange()
    }
    func getCoord(of moveable: any Moveable) -> Coord? {
        
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if board[row][col]?.id == moveable.id {
                    //                    print(Coord(row: row, col: col))
                    return Coord(row: row, col: col)
                }
            }
        }
        
        return nil
    }
}
