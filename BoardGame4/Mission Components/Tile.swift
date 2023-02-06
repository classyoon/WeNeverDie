//
//  Tile.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI


struct Tile: View {
    var size : Double//PRobably should be set to something, so that it universally changes all types of tiles
    var colored : Color
    var difference = 0.5
    @State var isSelected = false
    var tileLocation : Coord
    @ViewBuilder
    var body: some View {
        ZStack{
            
            VStack{
                Rectangle().fill(colored)
                    .padding(5)
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
        VStack{
            VStack{
                ForEach(0..<3, id: \.self) { row in
                    HStack{
                        ForEach(0..<3, id: \.self) { col in
                            Tile(size: 100.0, colored: Color.green, tileLocation: Coord()).frame(width: 150.0, height: 150.0)
                        }
                    }
                }
            }
            VStack{
                ForEach(0..<3, id: \.self) { row in
                    HStack{
                        ForEach(0..<3, id: \.self) { col in
                            FixedTile(tileLocation: Coord())
                        }
                    }
                }
            }
        }
    }
}
