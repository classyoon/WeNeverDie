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
        audio.playSFX(.stab)
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
        canAnyoneMove = isAnyoneStillActive()
        if secondPiece.trust >= 5 {
            set(moveable: playerUnit(name: "Jones", board: self), Coord: Coord(tapRow, tapCol))
            UnitsRecruited+=1
            print("Joined!")
            turn = UUID()
            
            
        }
    }
    func handleUnitEscape(survivor: Coord) {
        if let survivorOnCoord = board[survivor.row][survivor.col] {
            survivorList.append(survivorOnCoord)
            board[survivor.row][survivor.col] = nil
            audio.playSFX(.vanDoor)
            
            if survivorOnCoord.id == selectedUnit?.id {
                selectedUnit = nil
                audio.playSFX(.vanDoor)
            }
        }
    }


    func movePlayerUnit(tapRow: Int, tapCol: Int, startPoint : Coord, piece : inout any Piece){
        
        move(&piece, from: startPoint, to: Coord(row: tapRow, col: tapCol))
        if terrainBoard[tapRow][tapCol].name == "X" {
            audio.playSFX(.vanDoor)
        }else {
            audio.playSFX(.footsteps)
        }
        
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
    private func applyConcealment(_ coord: Coord) {
        if board[coord.row][coord.col] != nil {
            board[coord.row][coord.col]?.isHidden = (terrainBoard[coord.row][coord.col].name=="t" ? true : false)
        }
    }
    
    func applyTileStatuses(_ playerCoordPins : [Coord]){
        for coord in playerCoordPins {
            applyConcealment(coord)
        }
    }
    func searchLocationVM(){
        if unitWasSelected, var selected = selectedUnit, let piece = getCoord(of: selected){ //?? nil
            if selected.getCanMove(){
                board[piece.row][piece.col]?.movementCount+=1//Upfront stamina cost.
                selected.movementCount+=1
                
                if terrainBoard[piece.row][piece.col].foodScraps>0{
                    foodNew+=1
                    terrainBoard[piece.row][piece.col].foodScraps-=1
                    audio.playSFX(.grabbing)
                }
                else {
                    audio.playSFX(.empty)
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
    func secondSearch(){
        if unitWasSelected, var selected = selectedUnit, let piece = getCoord(of: selected){ //?? nil
            if selected.getCanMove(){
                board[piece.row][piece.col]?.movementCount+=1//Upfront stamina cost.
                selected.movementCount+=1
                
                if terrainBoard[piece.row][piece.col].rawMaterials>0{
                    materialNew+=1
                    terrainBoard[piece.row][piece.col].rawMaterials-=1
                    audio.playSFX(.wood)
                }
                else {
                    audio.playSFX(.empty)
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

