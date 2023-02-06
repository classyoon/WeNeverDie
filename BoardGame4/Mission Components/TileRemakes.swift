//
//  TileRemakes.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/6/23.
//

import SwiftUI

struct TileRemakes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
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
struct TileRemakes_Previews: PreviewProvider {
    static var previews: some View {
        TileRemakes()
    }
}
