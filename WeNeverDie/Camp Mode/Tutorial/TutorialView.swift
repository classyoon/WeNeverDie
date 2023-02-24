//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    var body: some View {
        ScrollView {
            VStack{
                introText()
                HowToMove()
                enemyView()
                tileExplainView()
            }.padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

struct HowToMove: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("How to move").font(.title2)
                Text("\n This is one of your people.")
                Image("SurvivorW").resizable().frame(width: 200, height: 200)
                Text("You tap to select them. The white circles will indicate where you can tell your person to go. The instant you tap on one of these circles you will send your person there at the cost of one stamina point. (Which will be explained shortly)")
                Image("BoardExample").resizable().frame(width: 300, height: 300)
                Text("Below the unit, the H stands for how much health they have, and the S stands for how much stamina they have. \n\nStamina is how many actions a unit can perform per turn. Actions such as : moving, scavenging, and attacking will expend stamina. \n\nThe only way to replenish a unit’s stamina is to hit ‘Next turn”, but be careful that is when your enemies will move.")
            }
        }
        
    }
}

struct introText: View {
    var body: some View {
        Text("Hello, survivor, and welcome to the tutorial. Society is gone. You’re still alive though and two others. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow upon, may thy ventures be successful.\n")
    }
}
