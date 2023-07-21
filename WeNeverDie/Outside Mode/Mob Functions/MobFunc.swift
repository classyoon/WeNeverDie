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
    //   MARK: Move Function
    func move(_ piece: inout any Piece, from : Coord, to: Coord){
        let moveCost = terrainBoard[to.row][to.col].movementPenalty+1
        if  canMovePiece(piece: piece, from: from, to: to, moveCost: moveCost){
            updateBoard(piece: &piece, from: from, to: to, moveCost: moveCost)
            followPlayerUnit(piece: piece, to: to)
        }
        else if piece.getCanMove()==false{
            handlePieceCannotMove(piece: piece)
        }
        canAnyoneMove = isAnyoneStillActive()
    }
    func handlePieceCannotMove(piece: any Piece) {
        if piece.isPlayerUnit {
            deselectUnit()
            highlightSquare = nil
        }
    }
    func updateBoard(piece: inout any Piece, from: Coord, to: Coord, moveCost: Int) {
        board[to.row][to.col] = piece
        board[to.row][to.col]?.movementCount += moveCost
        piece.movementCount += moveCost
        board[from.row][from.col] = nil
    }
    func followPlayerUnit(piece: any Piece, to: Coord) {
        if piece.isPlayerUnit && piece.getCanMove() {
            highlightSquare = to
            selectedUnit = piece
        } else if piece.isPlayerUnit {
            canAnyoneMove = isAnyoneStillActive()
            deselectUnit()
        }
    }
    func canMovePiece(piece: any Piece, from: Coord, to: Coord, moveCost: Int) -> Bool {
        return board[to.row][to.col] == nil && piece.movementCount + moveCost <= piece.stamina && to != from
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

