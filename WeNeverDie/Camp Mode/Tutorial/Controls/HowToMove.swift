//
//  HowToMove.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct HowToMove: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("How to move").font(.title2)
                Text("\n This is one of your people. Color may vary.")
                Image("SurvivorY").resizable().frame(width: 350, height: 200)
                Text("You tap to select them. The white circles will indicate where they can go. The instant you tap on one of these circles your person will advance to that tile at the cost of 1 stamina point.")
                Image("BoardExample").resizable().frame(width: 300, height: 300)
                Text("Below each unit, the H stands for their health, and the S stands for their stamina. \n\nStamina is how many actions a unit can perform per turn. Actions such as moving, searching, and attacking will expend their stamina. \n\nThe only way your people may replenish stamina is to tap \"Next turn\" but be careful that is when your enemies will move according to how much stamina they have.")
            }
        }
    }
}

struct HowToMove_Previews: PreviewProvider {
    static var previews: some View {
        HowToMove()
    }
}
