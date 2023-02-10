//
//  Tile.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI


struct Tile: View {
    var colored : Color
    var difference = 7.0
    var tileLocation : Coord
    @ViewBuilder
    var body: some View {
        ZStack{
            Rectangle().fill(colored)
                .padding(difference)
                .background(
                    Rectangle()
                )
            
        }
    }
}
struct Tile2: View {
    var image : String
    var difference = 7.0
    var tileLocation : Coord
    @ViewBuilder
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .padding(difference)
                .background(
                    Rectangle()
                )
            
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
                            Tile(colored: Color.green, tileLocation: Coord()).frame(width: 150.0, height: 150.0)
                        }
                    }
                }
            }
            VStack{
                ForEach(0..<3, id: \.self) { row in
                    HStack{
                        ForEach(0..<3, id: \.self) { col in
                            Tile2(image: "building", tileLocation: Coord()).frame(width: 100.0, height: 100.0).padding(0)
                        }
                    }
                }
            }
        }
    }
}
