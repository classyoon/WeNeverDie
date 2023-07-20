//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    @ObservedObject var gameData : ResourcePool
    
    @ObservedObject var gameCon : GameCondition = GameCondition.shared
    @State var largeText = false
    var testBool  = true
    var body: some View {
        ScrollView {
            VStack{
                Button("Toggle Text Enlargement") {
                    largeText.toggle()
                }.buttonStyle(.bordered).font(.largeTitle)
                (!gameCon.checkViewedTutorial() && autoShowTutorial ? SkipTutorialButton(gameData: gameData) : nil)
//                introText()
//                HowToMove()
//                Spacer()
//                HowToAttack()
//                enemyView()
//                tileExplainView()
//                sendOff()
                TestingChatGPT()
                (!gameCon.checkViewedTutorial() && autoShowTutorial ? firstTutorialExit(gameData: gameData) : nil)
            }.textSelection(.enabled)
                .font(largeText ? .title2 : .body).padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(gameData: (ResourcePool()))
    }
}




