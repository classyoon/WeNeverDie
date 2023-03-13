//
//  PlayerMob.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    ///
    /// This reacts to each tap on the screen.
    ///
    // This function handles user input when a player taps on a tile on the game board.
    func handleTap(tapRow: Int, tapCol: Int) {
        
        // Check if any unit is currently selected
        if unitWasSelected == false {
            // If no unit is selected, check if the tapped tile contains a player unit that can move
            if board[tapRow][tapCol]?.getCanMove() == true && (board[tapRow][tapCol]?.isPlayerUnit==true) {
                // If a player unit can move and is present on the tapped tile, select the unit and highlight the tile as blue
                SelectUnitOn(tapRow, tapCol)
            }
            else if highlightSquare == Coord(tapRow, tapCol) {
                highlightSquare = nil
            }
            else {
                highlightSquare = Coord(tapRow, tapCol)//Select Tile
            }
        }
        else if var piece = selectedUnit, let startPoint = highlightSquare {
            /**
             If the second tap is on on a second piece
             */
            if let secondPiece = board[tapRow][tapCol]{
                if secondPiece.isAttackable && isPossibleLoc(row: tapRow, col: tapCol) {
                    board[tapRow][tapCol]?.health -= piece.damage
                    board[startPoint.row][startPoint.col]?.incrementMoveCounter()
                    deselectUnit()
                    turn = UUID()
                    
                    if board[tapRow][tapCol]!.health <= 0 {
                        board[tapRow][tapCol] = nil
                    }
                }
                else if secondPiece.isRecruitable {
                    board[tapRow][tapCol]?.trust+=piece.damage
                    deselectUnit()
                    board[startPoint.row][startPoint.col]?.incrementMoveCounter()
                    turn = UUID()
                    if secondPiece.trust >= 5 {
                        set(moveable: playerUnit(name: "Jones", board: self), Coord: Coord(tapRow, tapCol))
                        UnitsRecruited+=1
                        turn = UUID()
                   
                    }
                }
                else if secondPiece.getCanMove() && secondPiece.isPlayerUnit {
                    if highlightSquare == Coord(tapRow, tapCol) {
                        // If the same tile is tapped twice, deselect the unit
                        deselectUnit()
                    }
                    else {
                        // If another player unit is tapped, switch the selected unit to the new unit
                        SelectUnitOn(tapRow, tapCol)
                    }
                }
                
            }
            else if isPossibleLoc(row: tapRow, col: tapCol) {
                // If an empty tile is tapped and it is a possible location for the selected unit to move, move the unit to the new tile
                move(&piece, from: startPoint, to: Coord(row: tapRow, col: tapCol))
            }
            else {
                // If the tapped tile is not a possible location for the selected unit to move, deselect the unit
                deselectUnit()
            }
        }
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
    func isAnyoneStillActive()->Bool{
        let playerList = createLists().playerCoords
        for coord in playerList {
            if let piece = board[coord.row][coord.col] {
                if piece.getCanMove() {
                    return true
                }
            }
        }
        return false
    }
    
    ///
    ///This applies all the tile statuses to the player units.
    func applyTileStatuses(_ playerCoordPins : [Coord]){
        for coord in playerCoordPins {
            if board[coord.row][coord.col] != nil {
                if terrainBoard[coord.row][coord.col].name=="t"{
                    board[coord.row][coord.col]?.isHidden = true
                } else{
                    board[coord.row][coord.col]?.isHidden = false //Reveal
                }
            }
        }
    }
}
