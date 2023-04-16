//
//  handleTapFunctions.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/15/23.
//

import Foundation
extension Board {
    func handleTap(tapRow: Int, tapCol: Int) {
        !unitWasSelected ? handleTapWithoutSelectedUnit(tapRow: tapRow, tapCol: tapCol) : handleTapWithSelectedPiece(tapRow: tapRow, tapCol: tapCol)
    }
    
    func handleTapWithSelectedPiece(tapRow: Int, tapCol: Int) {
        if var piece = selectedUnit, let startPoint = highlightSquare {
            if board[tapRow][tapCol] != nil{
                handleTapOnSecondPiece(tapRow: tapRow, tapCol: tapCol, startPoint : startPoint)
            }
            else if isPossibleLoc(row: tapRow, col: tapCol) {
                movePlayerUnit(tapRow: tapRow, tapCol: tapCol, startPoint: startPoint, piece: &piece)
            }
            else {
                deselectUnit()
            }
        }
    }
    
    func handleTapOnSecondPiece(tapRow: Int, tapCol : Int, startPoint : Coord){
        if let piece = selectedUnit, let startPoint = highlightSquare, let secondPiece = board[tapRow][tapCol]{
            if secondPiece.isAttackable && isPossibleLoc(row: tapRow, col: tapCol) {
                handleAttackWithUnit(secondPiece: secondPiece, piece: piece, tapRow: tapRow, tapCol: tapCol, startPoint: startPoint)
            }
            else if secondPiece.isRecruitable {
                handleRecruitWithUnit(secondPiece: secondPiece, piece: piece, tapRow: tapRow, tapCol: tapCol, startPoint: startPoint)
            }
            else if secondPiece.getCanMove() && secondPiece.isPlayerUnit {
                handleSwitchingUnit(tapRow: tapRow, tapCol: tapCol)
            }
            
        }
    }
    func handleTapWithoutSelectedUnit(tapRow: Int, tapCol: Int) {
        if board[tapRow][tapCol]?.getCanMove() == true && (board[tapRow][tapCol]?.isPlayerUnit==true) {
            SelectUnitOn(tapRow, tapCol)
        }
        else if highlightSquare == Coord(tapRow, tapCol) {
            highlightSquare = nil
        }
        else {
            highlightSquare = Coord(tapRow, tapCol)
        }
    }
    func handleSwitchingUnit(tapRow: Int, tapCol : Int){
        highlightSquare == Coord(tapRow, tapCol) ? deselectUnit() : SelectUnitOn(tapRow, tapCol)
    }
    
    func SelectUnitOn(_ tapRow: Int, _ tapCol: Int){
        selectedUnit = board[tapRow][tapCol]
        highlightSquare = Coord(tapRow, tapCol)
    }
    
    func deselectUnit(){
        selectedUnit = nil
        highlightSquare = nil
        canAnyoneMove = isAnyoneStillActive()
    }
}
