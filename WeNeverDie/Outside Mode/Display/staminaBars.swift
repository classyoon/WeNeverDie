//
//  staminaBars.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/3/23.
//

import SwiftUI

struct staminaBars: View {
    @ObservedObject var gameData : ResourcePool
    @State var piece : any Piece
    var body: some View {
        HStack{
            ForEach(0..<piece.stamina-piece.movementCount, id: \.self) { row in
                ZStack{
                    Rectangle().frame(width: 10,height: 15) .foregroundColor((gameData.visionAssist ? Color.purple : Color.green))
                        .cornerRadius(5)
                    
                }
            }
       }
    }
}

struct staminaBars_Previews: PreviewProvider {
    static var previews: some View {
        staminaBars(gameData: ResourcePool(), piece: Zombie(board: Board()))
    }
}
