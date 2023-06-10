//
//  Tile.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI

struct TileType {
    var name = "g"
    var loot = Int.random(in: 0...1)
    var rawMaterials = Int.random(in: 0...2) == 0 ? 1 : 0//1/3 chance for raw materials
    var movementPenalty = 0
    var concealingTerrain = false
    
    var jackpotBonus = 3
    var farmFoodBonus =  Int.random(in: 2...3)
    var looseBoards = Int.random(in: 1...3)
    var treeLogs = 3
    var forestFood = Int.random(in: 0...2)
    var fish = Int.random(in: 5...6)
    var difficultTerrainPenalty = 1

    mutating func setTileBonuses(){
        switch name {
        case "h":
            loot = jackpotBonus+farmFoodBonus
            rawMaterials = looseBoards
        case "t" :
            rawMaterials = treeLogs
            loot = forestFood
            movementPenalty = difficultTerrainPenalty
            concealingTerrain = true
        case "w":
            loot = jackpotBonus+fish
            movementPenalty = difficultTerrainPenalty
        default :
       
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
