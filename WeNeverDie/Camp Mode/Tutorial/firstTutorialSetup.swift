//
//  firstTutorialSetup.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/11/23.
//

import SwiftUI

struct firstTutorialSetup: View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        VStack{
//            Text("Hi, this is the tutorial. I'm assuming this is the first time you've logged on. You can skip this if you want. Tap the ? if you want to access it again. I reccomend that you don't though.")
            HStack{
                Button("Skip to game"){
                    gameData.hasViewedTutorial = true
                    save(items: ResourcePoolData(resourcePool: gameData), key: key)
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}

struct firstTutorialSetup_Previews: PreviewProvider {
    static var previews: some View {
        firstTutorialSetup(gameData: ResourcePool())
    }
}
