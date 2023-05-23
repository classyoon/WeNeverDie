//
//  TopButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct TopButtons: View {
    @ObservedObject var gameData: ResourcePool
    @State var initialLoad = true

    var body: some View {
        VStack(spacing: 15) {
            NavigationLink {
                TutorialView(gameData: gameData, seenTutorialBool: gameData.gameCon.checkViewedTutorial())
                    .foregroundColor(Color(.label))
            } label: {
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(0.6, contentMode: .fit)
                    .foregroundColor(Color(.white))
                    .shadow(radius: 5)
            }.frame(maxHeight: 50)
                .shadow(color: .black, radius: 5)
            NavigationLink {
                Settings(gameData: gameData, uiSettings: gameData.uiSetting, audio: gameData.audio).padding()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(Color(.white))
                    .shadow(radius: 5)
            }.frame(maxHeight: 50)
                .shadow(color: .black, radius: 5)
            //            Spacer()
        }
    }
}

struct TopButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopButtons(gameData: ResourcePool())
    }
}
