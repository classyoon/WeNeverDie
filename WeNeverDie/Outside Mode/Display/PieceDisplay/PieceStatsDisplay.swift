//
//  PieceStatsDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct PieceStatsDisplay: View {
    @ObservedObject var gameData : ResourcePool
    @State var piece : any Piece
    var body: some View {
        
        VStack{
            DefaultStatDisplay(gameData : gameData, piece : piece)
        }
    }
}

struct PieceStatsDisplay_Previews: PreviewProvider {
    static var previews: some View {
//        ZStack{
        PieceStatsDisplay(gameData: ResourcePool(), piece: playerUnit(name: "JOHN", board: Board()))
//            PieceDisplay(piece: playerUnit(name: "JOHN", board: Board()))
//            Tile2(image: "grass", tileLocation: Coord())
//        }
    }
}
