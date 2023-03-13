//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    @ObservedObject var gameData : ResourcePool
    @AppStorage("viewedTutorial") var didViewTutorial: Bool = false
    var body: some View {
        ScrollView {
            VStack{
                (!didViewTutorial ? firstTutorialSetup(gameData: gameData) : nil)
                introText()
                HowToMove()
                HowToAttack()
                enemyView()
                tileExplainView()
                sendOff()
                (!didViewTutorial ? firstTutorialExit(gameData: gameData) : nil)
            }.padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(gameData: (ResourcePool()))
    }
}




