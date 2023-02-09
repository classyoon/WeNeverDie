//
//  PlayerMob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    ///
    /// This reacts to each tap on the screen.
    ///
    func handleTap(tapRow: Int, tapCol: Int) {
        if unitWasSelected == false {
            if board[tapRow][tapCol]?.getCanMove() == true && (board[tapRow][tapCol]?.faction == "S"||board[tapRow][tapCol]?.faction == "E"){//If the piece selected can moved and is a player unit
                selectedUnit = board[tapRow][tapCol]
                wasTappedCoord =  Coord(tapRow, tapCol)//Lights up square as blue.
            }
            else if wasTappedCoord == Coord(tapRow, tapCol)  {//If tap same square twice, deselect
                wasTappedCoord = nil
            }
            else {//Selects square
                wasTappedCoord = Coord(tapRow, tapCol)
            }
        }
        else if var piece = selectedUnit, let startPoint = wasTappedCoord {
            if let second = board[tapRow][tapCol]{//If the tap is on another piece
                if second.faction == "Z"&&isPossibleLoc(row: tapRow, col: tapCol){
                    board[tapRow][tapCol]?.health-=piece.damage
                    board[startPoint.row][startPoint.col]?.incrementMoveCounter()
                    selectedUnit = nil
                    
                    if board[tapRow][tapCol]!.health <= 0 {board[tapRow][tapCol] = nil}//Erase dead enemy
                    
                }else if second.getCanMove() && (board[tapRow][tapCol]?.faction == "S"||board[tapRow][tapCol]?.faction == "E") {//If the piece can still move after it has moved.
                    if wasTappedCoord == Coord(tapRow, tapCol) {//If tap same square twice, deselect
                        selectedUnit = nil
                        wasTappedCoord = nil
                        selectedLoc = nil
                    }
                    else {//Switches units
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
            }
        }
        
    }
    
    ///
    ///This applies all the tile statuses to the player units.
    func applyTileStatuses(_ playerCoordPins : [Coord]){
        for coord in playerCoordPins {
            if terrainBoard[coord.row][coord.col].name=="t"{
                board[coord.row][coord.col]?.faction = "E"; //print("HIDDEN")
            } else{
                board[coord.row][coord.col]?.faction = "S"//Reveal
            }
        
//            if terrainBoard[coord.row][coord.col].name=="X"{//Exit
//                if let survivorOnCoord = board[coord.row][coord.col] {
//                    survivorList.append(survivorOnCoord)
//                    board[coord.row][coord.col]=nil
//                    if survivorOnCoord.id  == selectedUnit?.id {
//                        selectedUnit = nil
//                    }
//                }
//            }
        }
    }
}
