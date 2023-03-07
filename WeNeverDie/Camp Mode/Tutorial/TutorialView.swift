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
                HowToAttack()
                enemyView()
                tileExplainView()
            }.padding().navigationTitle("Tutorial")
        }
    }
}
struct HowToAttack : View {
    var body: some View {
        VStack{
            Text("How to attack").font(.title2)
            Text("Select your unit and tap to attack.")
            Text("How to recruit").font(.title2)
            Image("SurvivorW")
            Text("You may see these people in blue shirts. You can recruit them. Select you unit and tap on them. You will need to try two times.")
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
                Text("\n This is one of your people. Color may vary.")
                Image("SurvivorY").resizable().frame(width: 350, height: 200)
                Text("You tap to select them. The white circles will indicate where they can go. The instant you tap on one of these circles your person will advance to that tile at the cost of 1 stamina point.")
                Image("BoardExample").resizable().frame(width: 300, height: 300)
                Text("Below each unit, the H stands for their health, and the S stands for their stamina. \n\nStamina is how many actions a unit can perform per turn. Actions such as moving, searching, and attacking will expend their stamina. \n\nThe only way your people may replenish stamina is to tap \"Next turn\" but be careful that is when your enemies will move according to how much stamina they have.")
            }
        }
    }
}
struct enemyView : View {
    var body: some View {
        VStack{
            Text("The enemy").font(.title2)
            Image("SZombie").resizable().frame(width: 350, height: 200)
            Text("Above is a Shuffler. They are a common but very weak zombie. They have only one stamina per turn, but they come in large numbers. Once they can see you, they will turn red and try to eat you.")
            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
            Text("\n Boo!")
        }
    }
}
struct introText: View {
    var body: some View {
        Text("Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive and two others. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n")
    }
}
