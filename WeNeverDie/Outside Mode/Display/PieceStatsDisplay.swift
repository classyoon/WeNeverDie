//
//  PieceStatsDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct PieceStatsDisplay: View {
    @State var piece : any Piece
    var body: some View {
        VStack{
//            HStack{
//                ForEach(0..<piece.health, id: \.self) { row in
//                    Rectangle()
//                        .foregroundColor(Color.red)
//                        .frame(width: 10,height: 10)
//
//                }
//                Spacer()
//            }//.padding()
            HStack{
                
                Text("\(piece.health)")
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
            }//.padding()
        }
    }
}

struct PieceStatsDisplay_Previews: PreviewProvider {
    static var previews: some View {
//        ZStack{
            PieceStatsDisplay(piece: playerUnit(name: "JOHN", board: Board()))
//            PieceDisplay(piece: playerUnit(name: "JOHN", board: Board()))
//            Tile2(image: "grass", tileLocation: Coord())
//        }
    }
}
