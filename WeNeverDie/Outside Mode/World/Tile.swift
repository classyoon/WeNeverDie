//
//  Tile.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI

struct TileType {
    var name = "g"
    var loot = 0
    var movementPenalty = 0
    var houseLoot = 4
    var waterPenalty = 1
    var rawMaterials = 0
    var rawMaterialsBonus = 2
    mutating func setTileBonuses(){
        switch name {
        case "h":
            loot += Int.random(in: houseLoot...houseLoot+2)
            rawMaterials += Int.random(in: 0...2)
        case "t" :
            rawMaterials+=rawMaterialsBonus
            loot += Int.random(in: 0...1)
            movementPenalty+=waterPenalty
        case "w":
            movementPenalty += waterPenalty
            loot += Int.random(in: 2...4)
        default :
            loot += Int.random(in: 0...1)
            _ = 0
        }
    }
    
}

struct Tile2: View {
    var image: String
    var difference = 1.0
    var tileLocation: Coord
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
        }
    }
}
struct Tile: View {
    var difference = 1.0
    var tileLocation: Coord
    var optionalColor = Color.clear
    @ViewBuilder
    var body: some View {
        ZStack{
            Rectangle()
                .fill(optionalColor)
                .border(Color.white, width: difference)
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
