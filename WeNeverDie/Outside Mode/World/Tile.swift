//
//  Tile.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI

struct TileType {
    var name = "g"
    var foodScraps = Int.random(in: 0...1)
    var movementPenalty = 0
    var rawMaterials = 0
    
    mutating func setTileBonuses(){
        var pantryItems = Int.random(in: 2...4)
        var thickWater = 1
        var thickBrambles = 1
        var lumber = 3
        var fish = Int.random(in: 3...5)
        var loosePlanks = Int.random(in: 0...2)
        
        switch name {
        case "h"://Building
            foodScraps += pantryItems
            rawMaterials += loosePlanks
        case "t" ://Forest
            rawMaterials+=lumber
            movementPenalty += thickBrambles
        case "w"://Water
            movementPenalty += thickWater
            foodScraps += fish
        default ://Default
            _ = 0
        }
    }
}

struct Tile2: View {
    var image: String
    var difference = 1.0
    var tileLocation: Coord
    var image2: String = ""
    var optionalColor = Color.clear
    @ViewBuilder
    var body: some View {
        ZStack{
            Rectangle()
                .fill(optionalColor)
                .border(Color.white, width: difference)
            Image(image)
                .resizable()
                .padding(difference)
            image2 != nil ? Image(image2).resizable() : nil
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
                            Tile2(image: "building", tileLocation: Coord()).frame(width: 100.0, height: 100.0).padding(0)
                        }
                    }
                }
            }
        }
    }
}
