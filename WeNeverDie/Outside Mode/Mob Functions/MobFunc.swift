//
//  Mob.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/26/23.
//

import Foundation
import SwiftUI

extension Board {
    /// This moves pieces.
    /// - Parameters:
    ///   - piece: Piece that will be moved.
    ///   - from: original spot the piece was at.
    ///   - to: new spot piece will be at.
    func move(_ piece: inout any Piece, from : Coord, to: Coord){
        let moveCost = terrainBoard[to.row][to.col].movementPenalty+1
        
        //If the moving piece has energy and square is unoccupied
        if board[to.row][to.col]==nil &&
            piece.movementCount+moveCost<=piece.stamina && to != from{
            board[to.row][to.col] = piece
            board[to.row][to.col]?.movementCount+=moveCost// This may look redundent, but I have no idea why but these do not work if you get rid of one.
            piece.movementCount+=moveCost//
            board[from.row][from.col] = nil
            
            //Follows player unit
            if (piece.isPlayerUnit) && piece.getCanMove(){
                highlightSquare = to
                selectedUnit = piece
                
            }
            else if (piece.isPlayerUnit) {
                canAnyoneMove = isAnyoneStillActive()
                //print("exhaust")
                deselectUnit()
            }
        }
        
        else if piece.getCanMove()==false{
            if piece.isPlayerUnit {
                deselectUnit()
                highlightSquare = nil
            }
        }
    }
}

//struct pieceDisplay: View, Identifiable {
//    @State var piece: any Piece
//    @State var id = UUID()
//    var nameSpace: Namespace.ID
//
//    let paddingRatio: CGFloat = 0.02
//    let fontRatio: CGFloat = 0.04
//    let sizeRatio: CGFloat = 0.1
//
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                piece.getView()
//                    .matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
//
//                Text("H \(piece.health) S \(piece.stamina-piece.movementCount)")
//                    .matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace)
//                    .font(.system(size: geo.size.width * fontRatio))
//                    .padding(geo.size.width * paddingRatio)
//                    .foregroundColor(.black)
//                    .background(.white)
//                    .cornerRadius(geo.size.width * paddingRatio * 5)
//            }
//            .frame(width: geo.size.width * sizeRatio, height: geo.size.width * sizeRatio)
//        }
//    }
//}

