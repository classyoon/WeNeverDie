//
//  PieceDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/24/23.
//

import SwiftUI

struct PieceDisplay: View {
    @State var piece : any Piece
    @State var id = UUID()
    //    var nameSpace : Namespace.ID
    var body: some View {
        VStack{
            
                
            piece.getView()
                .resizable()
                .scaledToFit()
                .padding()
      
//            Text("H \(piece.health) S \(piece.stamina-piece.movementCount)")
//                .padding(1)
//                .foregroundColor(.black)
//                .background(.white)
//                .cornerRadius(10)
            // Spacer()
        }//.padding(0.0)
        .overlay(PieceStatsDisplay(piece: piece))
    }
}

struct PieceDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PieceDisplay(piece: Zombie(board: Board()))
    }
}
