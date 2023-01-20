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
            piece.incrementMoveCounter()
            board[to.row][to.col] = piece; board[from.row][from.col] = nil
            wasTappedCoord = to
        }
        
        else{
            selectedUnit = nil
            wasTapped = false
            wasTappedCoord = nil
        }
        if piece.getCanMove()==false{
            selectedUnit = nil
            wasTapped = false
            wasTappedCoord = nil
        }
      
      
    }
    func attack(_ row: Int, _ col: Int){

    }
    
    
    func handleTap(tapRow: Int, tapCol: Int) {
        if wasTapped == false && (board[tapRow][tapCol]?.faction=="S"||board[tapRow][tapCol]?.faction=="E"){
            wasTappedCoord = Coord(row: tapRow, col: tapCol)
            selectedUnit = board[tapRow][tapCol]

            wasTapped = true
        }
        else if let newPiece = board[tapRow][tapCol] {
            if tapRow == wasTappedCoord?.row && tapCol == wasTappedCoord?.col {
                wasTapped = false
                selectedUnit = nil
                wasTappedCoord = nil
            }
            else if (newPiece.faction == "Z"){
                selectedUnit = newPiece
                wasTappedCoord = Coord(tapRow, tapCol)
            }
            else if ((newPiece.faction == "S"||newPiece.faction == "E")&&(newPiece.getCanMove())){
                selectedUnit = newPiece
                wasTappedCoord = Coord(tapRow, tapCol)
            }
        }
        else if ((board[tapRow][tapCol] == nil && isPossibleLoc(row: tapRow, col: tapCol) == false) || selectedUnit == nil){
            wasTapped.toggle()
            selectedUnit = nil
            wasTappedCoord = (wasTapped ? Coord(tapRow, tapCol):nil)
            print(wasTapped)
        }
        else{
           
            print("Is tapped \(wasTapped)")
            print("Saved \(String(describing: wasTappedCoord))")
            print("Tapped \(Coord(tapRow, tapCol))")
            
            if let wasTappedCol = wasTappedCoord?.col, let wasTappedRow = wasTappedCoord?.row, isPossibleLoc(row: tapRow, col: tapCol), var piece = board[wasTappedRow][wasTappedCol],  let currentLoc = wasTappedCoord{
               
                if piece.getCanMove(){
                    
                    move(&piece, from: currentLoc, to: Coord(tapRow, tapCol))
                    
                    if escapeCoord.row == tapRow &&  escapeCoord.col == tapCol {
                        survivorList.append(board[tapRow][tapCol] as! King)
                        board[tapRow][tapCol] = nil
                        wasTapped = false
                        selectedUnit = nil
                    }
                    
                    if (board[tapRow][tapCol]?.faction == "Z"){
                        board[tapRow][tapCol]?.health-=piece.damage
                        board[wasTappedRow][wasTappedCol]?.movementCount+=1//but not here.
                        print("Attack \(piece.movementCount)")
                        wasTapped = false
                        selectedUnit = nil
                        if board[tapRow][tapCol]?.health == 0 {board[tapRow][tapCol] = nil}
                    }
                }
                else{
                    selectedUnit = nil
                    wasTappedCoord = nil
                    wasTapped = false
                    print("no further")
                }
                
            }
            
            
            
            //isTapped.toggle()
        }
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
