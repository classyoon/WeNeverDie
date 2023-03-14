//
//  HowToMove.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct HowToMove: View {
    var body: some View {
  
            VStack{
                Text("Navigation In The Outside").font(.title2)
                Text("\n This is one of your people. Color may vary.")
                Image("SurvivorY").resizable().frame(width: 350, height: 200)
                Text("You tap to select them. The white circles will indicate where they can go. The instant you tap on one of these circles your person will advance to that tile at the cost of one stamina point.")
                Image("BoardExample").resizable().frame(width: 300, height: 300)
                Text("Below each survivor, the H stands for their health, and the S stands for their number of stamina points. \n\nStamina points dictate how many actions a survivor can perform per turn. Actions such as moving, searching, and attacking will expend their stamina points. \n\nThe only way your people may replenish stamina is to tap \"Next turn\" but be careful since that is when your enemies will move according to how many stamina points they have. Likewise below an enemy, you can see how many stamina points and health they have.")
            }
        
    }
}

struct HowToMove_Previews: PreviewProvider {
    static var previews: some View {
        HowToMove()
    }
}
