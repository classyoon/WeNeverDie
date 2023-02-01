//
//  Mob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/26/23.
//

import Foundation
import SwiftUI

extension Board {
    ///This moves pieces.
    func move(_ piece: inout any Piece, from : Coord, to: Coord){
        let moveCost = terrainBoard[to.row][to.col].movementPenalty+1
        
        if board[to.row][to.col]==nil &&
            piece.movementCount+moveCost<=piece.stamina && to != from{
            //            print("Successful Move")
            board[to.row][to.col] = piece
            board[to.row][to.col]?.movementCount+=moveCost// This may look redundent, but I have no idea why but these do not work if you get rid of one.
            piece.movementCount+=moveCost//
            board[from.row][from.col] = nil
            
            if (piece.faction == "S"||piece.faction == "E") {
                wasTappedCoord = to
                selectedUnit = piece
            }
            
        }
        else if piece.getCanMove()==false{
            if (piece.faction == "S"||piece.faction == "E") {
                selectedUnit = nil
                unitWasSelected = false
                wasTappedCoord = nil
            }
        }
    }
}
struct TileAndPiece: View {
    var row: Int
    var col: Int
    var vm: Board
    var nameSpace: Namespace.ID
    
    func getTile() -> some View {
        switch vm.terrainBoard[row][col].name{
        case "h":
            return Tile(size: 100, colored: Color.red, tileLocation: Coord(row, col))//House
            //                Image("Mountains").resizable()
        case "t":
           return  Tile(size: 100, colored: Color.brown, tileLocation: Coord(row, col))//Forest
        case "w":
            return Tile(size: 100, colored: Color.blue, tileLocation: Coord(row, col))//Forest
        case "X":
            return Tile(size: 100, colored: Color.purple, tileLocation: Coord(row, col))//exit
        default:
            return Tile(size: 100, colored: Color.green, tileLocation: Coord(row, col))
            //                Image("Grass_Grid_Center").resizable()
        }
    }
    
    var body: some View {
        ZStack{
            getTile()
            if let piece = vm.board[row][col] {
                VStack{
                    piece.getView().matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
                    Text("H \(piece.health) S \(piece.stamina-piece.movementCount)").matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace)
                    Spacer()
                }
            }
        }
        .onTapGesture {withAnimation{vm.handleTap(tapRow: row, tapCol: col)}}
        .background(
            Group{
                if let loc = vm.wasTappedCoord, loc.col == col && loc.row == row {
                    RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.8))
                }
                if vm.isPossibleLoc(row: row, col: col) && vm.unitWasSelected{
                    RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.8))
                }
            }
        )
    }
}
