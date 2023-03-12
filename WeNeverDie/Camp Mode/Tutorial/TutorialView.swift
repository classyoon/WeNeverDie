//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        ScrollView {
            VStack{
                (!gameData.hasViewedTutorial ? firstTutorialSetup(gameData: gameData) : nil)
                introText()
                HowToMove()
                HowToAttack()
                enemyView()
                tileExplainView()
                sendOff()
                (!gameData.hasViewedTutorial ? firstTutorialExit(gameData: gameData) : nil)
            }.padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(gameData: (ResourcePool()))
    }
}




