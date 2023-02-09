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
                wasTappedCoord = nil
            }
        }
    }
}
struct pieceDisplay: View{
    @State var piece : any Piece
    var nameSpace : Namespace.ID
    var body: some View {
        VStack{
            piece.getView().matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
            Text("H \(piece.health) S \(piece.stamina-piece.movementCount)").matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace).padding(1)
                .background(.white)
                .cornerRadius(10)
            Spacer()
        }//.padding(0.0)
    }
}
