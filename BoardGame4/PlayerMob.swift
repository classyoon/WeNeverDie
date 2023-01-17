//
//  PlayerMob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    func handleTap(row: Int, col: Int) {
        if isTapped == false {
            tappedLoc = Coord(row: row, col: col)
            //board[row][col]?.isSelected = true
            selectedUnit = board[row][col]
            selectedUnit?.isSelected = true
        }
        else{
            
            if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
                if piece.getCanMove(){
                    if (!(board[row][col] != nil)){//Checks stamina and if a piece is already there
                        piece.incrementMoveCounter()//FOR SOME reason this function "piece.incrementMoveCounter()" works here.
                        board[row][col] = piece; board[tappedRow][tappedCol] = nil//Actual move process.
                        
                        if escapeCoord.row == row &&  escapeCoord.col == col {
                            survivorList.append(board[row][col] as! King)
                            board[row][col] = nil
                            print("Escape!")
                            selectedUnit?.isSelected = false
                        }
                    }
                    if (board[row][col]?.faction == "Z"){
                        board[row][col]?.health-=piece.damage
                        board[tappedRow][tappedCol]?.movementCount+=1//but not here.
                        print("Attack \(piece.movementCount)")
                        if board[row][col]?.health == 0 {board[row][col] = nil}
                    }
                }
                else{
                    selectedUnit = nil
                }
            }
            
            tappedLoc = nil
        }
        isTapped.toggle()
    }
    
    func applyConcealment(_ playerCoordPins : [Coord]){
        for each in 0..<playerCoordPins.count{
            var loc = playerCoordPins[each]
            if terrainBoard[loc.row][loc.col]=="t"{
                board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "E"; //print("HIDDEN")
            }
            else{board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "S"}
        }
    }
}
