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
    func handleAttackWithUnit(secondPiece : any Piece, piece : any Piece, tapRow : Int, tapCol : Int, startPoint : Coord){
        board[tapRow][tapCol]?.health -= piece.damage
        board[startPoint.row][startPoint.col]?.incrementMoveCounter()
        deselectUnit()
        playerSoundPlayer?.prepareToPlay()
        playerSoundPlayer?.play()
        turn = UUID()
        if board[tapRow][tapCol]!.health <= 0 {
            board[tapRow][tapCol] = nil
        }
    }
    func handleRecruitWithUnit(secondPiece : any Piece, piece : any Piece, tapRow : Int, tapCol : Int, startPoint : Coord){
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
    func movePlayerUnit(tapRow: Int, tapCol: Int, startPoint : Coord, piece : inout any Piece){
        playerwalkSoundPlayer?.prepareToPlay()
        move(&piece, from: startPoint, to: Coord(row: tapRow, col: tapCol))
        playerwalkSoundPlayer?.play()
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
    func searchLocationVM(){
        if unitWasSelected, var selected = selectedUnit, let piece = getCoord(of: selected){ //?? nil
            if selected.getCanMove(){
                board[piece.row][piece.col]?.movementCount+=1//Upfront stamina cost.
                selected.movementCount+=1
                
                if terrainBoard[piece.row][piece.col].loot>0{
                    foodNew+=1
                    terrainBoard[piece.row][piece.col].loot-=1
                    grabSoundPlayer?.prepareToPlay()
                    grabSoundPlayer?.play()
                }
                else {
                    emptySoundPlayer?.prepareToPlay()
                    emptySoundPlayer?.play()
                }
            }
            selectedUnit = selected
        }
        canAnyoneMove = isAnyoneStillActive()
        turn = UUID()
        if !(selectedUnit?.getCanMove() ?? true) {
            deselectUnit()
        }
    }
}

