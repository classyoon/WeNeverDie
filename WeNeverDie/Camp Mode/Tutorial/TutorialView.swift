//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    @ObservedObject var gameData : ResourcePool
    @State var seenTutorialBool : Bool
    @State var largeText = false
    var testBool  = true
    var body: some View {
        ScrollView {
            VStack{
                Button("Toggle Text Enlargement") {
                    largeText.toggle()
                }.buttonStyle(.bordered).font(.largeTitle)
                (!seenTutorialBool ? SkipTutorialButton(gameData: gameData) : nil)
//                (!gameData.hasViewedTutorial ? SkipTutorialButton(gameData: gameData) : nil)
                introText()
                HowToMove()
                Spacer()
                HowToAttack()
                enemyView()
                tileExplainView()
                sendOff()
                (!seenTutorialBool ? firstTutorialExit(gameData: gameData) : nil)
            }.textSelection(.enabled)
                .font(largeText ? .title2 : .body).padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(gameData: (ResourcePool()), seenTutorialBool: false)
    }
}




