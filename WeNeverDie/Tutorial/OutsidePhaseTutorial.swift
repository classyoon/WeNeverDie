//
//  OutsidePhaseTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct OutsidePhaseTutorial: View {
    var body: some View {
        VStack{
            Navigating_the_Outside()
            Growing_Your_Numbers()
            Those_Who_Never_Die()
            Defending_Yourself()
            Map_Tiles_Explained()
        }
    }
    var defending = "Select your survivor by tapping on them. If your survivor has a stamina point you may attack your enemy at the cost of one stamina point. While your survivor is selected, you may attack by tapping on the enemy. You must be right next to an enemy to attack."
    
    var growing = "This is another survivor, who is not part of your group. You may encounter them outside your camp. You can recruit them by having your survivor approach and talk to them. You do this in the same fashion you command your survivors to attack."
    
    var survivorDescrip = "\nThis is one of your people. Color may vary."
    
    var moving = "You tap to select them. The white circles will indicate where they can go. The instant you tap on one of these circles your person will advance to that tile at the cost of one stamina point."
    
    var staminaAndHP = """
Below each survivor, the number stands for HP, and the green tick represents the stamina points a unit still has left on its turn.

Stamina points dictate how many actions a survivor can perform per turn. Actions such as moving, searching, and attacking will expend their stamina points.

The only way your people may replenish stamina is to tap \"Next turn,\" but be careful since that is when your enemies will move according to how many stamina points they have. Likewise, below an enemy, you can see how many stamina points and health they have.
"""
    
    var shambler = """
Above is a Shuffler. They are a common but very weak zombie. They have only one stamina point per turn, but they come in large numbers. Once they can see you, they will turn red and try to eat you. They cannot attack you or detect you while you are hidden. Like most zombies, shufflers are nocturnal; however, you may still see some wandering about during the day.

(They are currently the only zombie in the game, but in the future and if this game does well, there may be more.)
"""
    
    var grassfield = "This is a grass field."
    
    var forest = "This is a forest. It provides safety and absolute concealment from zombies."
    
    var searching = """
To search, select a survivor who has stamina left and hit the \"food\" button to search for food on the tile and hit the \"materials\" button to search the for building materials on the tile.

    The amount of food or materials you can find is roughly dependent on the type of tile.

Each tile will have a certain amount of resources in them that can be found. Currently the only way to check is to search until you hear the empty sound effect.
"""
    var buildingText = """
This is an abandoned building. It tends to be rich in food and have decent amounts of building materials.
"""
    
    var water = "This is water or any kind of difficult terrain. This terrain will take two stamina points rather than one to traverse. It tends to be rich in resources due to the fish.\n"
    
    var escape = "This is your means of returning to camp. You will typically find it at the bottom right of the board. Get your survivors to it once you are satisfied with your haul or if things get too dicey. If none of the survivors you sent are able to return, your camp will get nothing."
    
    func Defending_Yourself() -> some View {
        VStack {
            Text("Defending Yourself").font(.title)
            Text(defending)
            Image("SurvivorW")
        }
    }
    func Growing_Your_Numbers() -> some View {
        VStack {
            Text("Growing Your Numbers").font(.title)
            Text(growing)
        }
    }
    func Navigating_the_Outside() -> some View {
        VStack {
            Text("Navigating the Outside").font(.title)
            Text(survivorDescrip)
            Image("SurvivorY").resizable().frame(width: 350, height: 200)
            Text(moving)
            Text(staminaAndHP)
            Image("NewBoardExample").resizable().frame(width: 300, height: 300)
            Text("Scavenging").font(.title)
            Text(searching)
        }
    }

    func Those_Who_Never_Die() -> some View {
        VStack {
            Text("Those Who Never Die").font(.title)
            Text(shambler)
            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
        }
    }
    func Map_Tiles_Explained() -> some View {
        VStack {
            Text("Land").font(.title)
            Image("grass").resizable().frame(width: 300, height: 300).padding()
            Text(grassfield)
            Tile2(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
            Text(forest)
            Image("building").resizable().frame(width: 300, height: 300).padding()
            Text(buildingText)
            Image("water").resizable().frame(width: 300, height: 300).padding()
            Text(water)
            escapeTile()
        }
    }
    func escapeTile()-> some View {
        VStack{
            Tile2(image: "grass", tileLocation: Coord(), image2: "escape").frame(width: 300, height: 300).padding()
            Text(escape)
        }
    }
}

struct OutsidePhaseTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            OutsidePhaseTutorial()
        }
    }
}
