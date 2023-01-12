//
//  Tile.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI
//struct Loc: Equatable, Identifiable {
//    var id = UUID()
//    var row : Int
//    var col : Int
//    init() {
//        row = 0
//        col = 0
//    }
//    init(row : Int, col : Int) {
//        self.row = row
//        self.col = col
//    }
//}

struct Tile: View {
    var size : Double//PRobably should be set to something, so that it universally changes all types of tiles
    var colored : Color
    var difference = 0.5
    @State var isSelected = false
    var tileLocation : Coord
    var body: some View {
        ZStack{

            VStack{
                Rectangle().fill(colored)
                    .padding(4)
                    .overlay(
                        Rectangle()
                            .strokeBorder()
                            .foregroundColor(isSelected ? Color.red : Color.black)
                    
                    )
            }
            
        }
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(size: 100.0, colored: Color.green, tileLocation: Coord())
    }
}
