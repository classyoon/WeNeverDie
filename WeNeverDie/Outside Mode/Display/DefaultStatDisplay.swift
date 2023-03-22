//
//  DefaultStatDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/22/23.
//

import SwiftUI

struct DefaultStatDisplay: View {
    @ObservedObject var gameData : ResourcePool
    @State var piece : any Piece
    var body: some View {
        VStack{
            HStack{
                
                Text(!piece.isRecruitable ? "\(piece.health)" : "T \(piece.trust)")
                    .padding(2)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(10)
                Spacer()
                
            }.padding(0.5)
            Spacer()
            HStack{
                ForEach(0..<piece.stamina-piece.movementCount, id: \.self) { row in
                    Rectangle().frame(width: 10,height: 15) .foregroundColor(Color.green)
                        .cornerRadius(5)
                }
            }
        }
    }
}

struct DefaultStatDisplay_Previews: PreviewProvider {
    static var previews: some View {
        DefaultStatDisplay(gameData: ResourcePool(), piece: Zombie(board: Board()))
    }
}
