//
//  AssistStatDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/22/23.
//

import SwiftUI

struct AssistStatDisplay: View {
    @State var piece : any Piece
    @ObservedObject var gameData : ResourcePool
   
    var body: some View {
        Text(!piece.isRecruitable ? "H \(piece.health) S \(piece.stamina-piece.movementCount)" : "T \(piece.trust) S \(piece.stamina-piece.movementCount)")
            .padding(1)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(10)
    }
}


struct AssistStatDisplay_Previews: PreviewProvider {
    static var previews: some View {
        AssistStatDisplay(piece : Zombie(board: Board()), gameData: ResourcePool())
    }
}
