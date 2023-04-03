//
//  PieceDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/24/23.
//

import SwiftUI

struct PieceDisplay: View {
    @ObservedObject var gameData : ResourcePool
    @State var piece : any Piece
    @State var id = UUID()
    //    var nameSpace : Namespace.ID
    var body: some View {
        VStack{
            
                
            piece.getView()
                .resizable()
                .scaledToFit()
                .padding()
            // Spacer()
        }//.padding(0.0)
        .overlay(PieceStatsDisplay(gameData: gameData, piece: piece))
    }
}

struct PieceDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PieceDisplay(gameData: ResourcePool(), piece: Zombie(board: Board()))
    }
}

