//
//  PlayerMob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    
    func move(_ piece: inout any Piece, from : Coord, to: Coord){
        
        if board[to.row][to.col]==nil && piece.getCanMove() && to != from{
            
            board[to.row][to.col] = piece
            board[to.row][to.col]?.movementCount+=1// This may look redundent, but I have no idea why but these do not work if you get rid of one.
            piece.movementCount+=1//
            board[from.row][from.col] = nil
            wasTappedCoord = to
            selectedUnit = piece
            
        }
        else if piece.getCanMove()==false{
            selectedUnit = nil
            unitWasSelected = false
            wasTappedCoord = nil
        }
        
        
    }
    
    func handleTap(tapRow: Int, tapCol: Int) {
        if unitWasSelected == false {
            if board[tapRow][tapCol]?.getCanMove() == true && (board[tapRow][tapCol]?.faction == "S"||board[tapRow][tapCol]?.faction == "E"){
                selectedUnit = board[tapRow][tapCol]
                wasTappedCoord =  Coord(tapRow, tapCol)
                unitWasSelected = true
            }
            else if wasTappedCoord == Coord(tapRow, tapCol)  {//If tap same square twice, deselect
                wasTappedCoord = nil
            }
            else {
                wasTappedCoord = Coord(tapRow, tapCol)
            }
        }else if var piece = selectedUnit, let startPoint = wasTappedCoord {
            if var second = board[tapRow][tapCol]{//If the tap is on another piece
                if second.faction == "Z"&&isPossibleLoc(row: tapRow, col: tapCol){
                    board[tapRow][tapCol]?.health-=piece.damage
                    board[startPoint.row][startPoint.col]?.incrementMoveCounter()
                    unitWasSelected = false
                    
                    if board[tapRow][tapCol]!.health <= 0 {board[tapRow][tapCol] = nil}//Erase dead enemy
                    
                }else if second.getCanMove() && (board[tapRow][tapCol]?.faction == "S"||board[tapRow][tapCol]?.faction == "E") {
                    if wasTappedCoord == Coord(tapRow, tapCol) {//If tap same square twice, deselect
                        unitWasSelected = false
                        selectedUnit = nil
                        wasTappedCoord = nil
                        selectedLoc = nil
                    }
                    else {
                        wasTappedCoord = Coord(tapRow, tapCol)
                        selectedUnit = second
                    }
                }
                
            }
            else if  isPossibleLoc(row: tapRow, col: tapCol) {
                move(&piece, from: startPoint, to: Coord(row: tapRow, col: tapCol))
            }
            else{
                selectedUnit = nil
                wasTappedCoord = nil
                unitWasSelected = false
              
            }
        }
        
        
        
        //        else if let newPiece = board[tapRow][tapCol] {
        //            if tapRow == wasTappedCoord?.row && tapCol == wasTappedCoord?.col {
        //                unitWasSelected = false
        //                selectedUnit = nil
        //                wasTappedCoord = nil
        //            }
        //            else if (newPiece.faction == "Z"){
        //                selectedUnit = newPiece
        //                wasTappedCoord = Coord(tapRow, tapCol)
        //            }
        //            else if ((newPiece.faction == "S"||newPiece.faction == "E")&&(newPiece.getCanMove())){
        //                selectedUnit = newPiece
        //                wasTappedCoord = Coord(tapRow, tapCol)
        //            }
        //        }
        //        else if ((board[tapRow][tapCol] == nil && isPossibleLoc(row: tapRow, col: tapCol) == false) || selectedUnit == nil){
        //            unitWasSelected.toggle()
        //            selectedUnit = nil
        //            wasTappedCoord = (unitWasSelected ? Coord(tapRow, tapCol):nil)
        //            print(unitWasSelected)
        //        }
        //        else{
        //
        //            print("Is tapped \(unitWasSelected)")
        //            print("Saved \(String(describing: wasTappedCoord))")
        //            print("Tapped \(Coord(tapRow, tapCol))")
        //
        //            if let wasTappedCol = wasTappedCoord?.col, let wasTappedRow = wasTappedCoord?.row, isPossibleLoc(row: tapRow, col: tapCol), var piece = board[wasTappedRow][wasTappedCol],  let currentLoc = wasTappedCoord{
        //
        //                if piece.getCanMove(){
        //
        //                    move(&piece, from: currentLoc, to: Coord(tapRow, tapCol))
        //
        //                    if terrainBoard[tapRow][tapCol].0 == "X" {
        //                        survivorList.append(board[tapRow][tapCol] as! King)
        //                        board[tapRow][tapCol] = nil
        //                        unitWasSelected = false
        //                        selectedUnit = nil
        //                    }
        //
        //                    if (board[tapRow][tapCol]?.faction == "Z"){
        //                        board[tapRow][tapCol]?.health-=piece.damage
        //                        board[wasTappedRow][wasTappedCol]?.movementCount+=1//but not here.
        //                        print("Attack \(piece.movementCount)")
        //                        unitWasSelected = false
        //                        selectedUnit = nil
        //                        if board[tapRow][tapCol]?.health == 0 {board[tapRow][tapCol] = nil}
        //                    }
        //                }
        //                else{
        //                    selectedUnit = nil
        //                    wasTappedCoord = nil
        //                    unitWasSelected = false
        //                    print("no further")
        //                }
        //
        //            }
        //
        //
        //
        //            //isTapped.toggle()
        //        }
    }
    
    func applyTileStatuses(_ playerCoordPins : [Coord]){
        for each in 0..<playerCoordPins.count{
            var loc = playerCoordPins[each]
            if terrainBoard[loc.row][loc.col].0=="t"{
                board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "E"; //print("HIDDEN")
            }
            else{board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "S"}
        
            if terrainBoard[loc.row][loc.col].0=="X"{
                survivorList.append(board[playerCoordPins[each].row][playerCoordPins[each].col] as! King)
                board[playerCoordPins[each].row][playerCoordPins[each].col]=nil
                unitWasSelected = false
                selectedUnit = nil
                
            }
        }
    }
}
