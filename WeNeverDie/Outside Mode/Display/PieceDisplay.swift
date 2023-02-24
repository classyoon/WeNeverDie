//
//  PieceDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/24/23.
//

import SwiftUI

struct pieceDisplay: View {
    @State var piece : any Piece
    @State var id = UUID()
    var nameSpace : Namespace.ID
    var body: some View {
        VStack{
            piece.getView().matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
            Text("H \(piece.health) S \(piece.stamina-piece.movementCount)").matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace).padding(1)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(10)
                // Spacer()
        }//.padding(0.0)
    }
}

//struct PieceDisplay_Previews: PreviewProvider {
//    @Namespace var namespaceID : Namespace
//    static var previews: some View {
//        pieceDisplay(piece: Zombie(board: Board(players: 0)), nameSpace: namespaceID)
//    }
//}
