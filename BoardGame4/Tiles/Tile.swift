//
//  Tile.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI
var colorArray = [Color.green, Color.red, Color.brown]//UGH this is so crude but I can't figure it out.
struct FixedTile: View {
    var size : Double = 100.0
    var colored : Color = Color.green
    var difference = 10.0
    @State var isSelected = false
    var tileLocation : Coord
    var body: some View {
        ZStack{
            Rectangle().fill(isSelected ? Color.red : Color.black)
                .overlay(Rectangle().fill(colored).padding(difference))
        }.frame(width: size, height: size)
            .onTapGesture {isSelected.toggle()}
    }
}

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
            
        }//.frame(width: size, height: size)
    }
}

struct BetterTile: View {
    var size : Double//PRobably should be set to something, so that it universally changes all types of tiles
    var colored : Color
    var difference = 0.5
    @State var isSelected = false
    var tileLocation : Coord
    var body: some View {
        ZStack{
            
            VStack{
                Rectangle().fill()
                //.padding(4)
                    .overlay(
                        Rectangle()
                            .fill(Color.green).padding()
                        //                            .strokeBorder()
                            .foregroundColor(isSelected ? Color.red : Color.black)
                        
                    )
            }
            
        }//.frame(width: size, height: size)
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        // ForEach(0..<3, id: \.self) { row in
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
            //            VStack{
            //                ForEach(0..<3, id: \.self) { row in
            //                    HStack{
            //                        ForEach(0..<3, id: \.self) { col in
            //                            BetterTile(size: 100.0, colored: Color.green, tileLocation: Coord()).frame(width: 150.0, height: 150.0)
            //                        }
            //                    }
            //                }
            //            }
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
        //}
    }
}
