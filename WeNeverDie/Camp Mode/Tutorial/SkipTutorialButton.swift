//
//  SkipTutorialButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/11/23.
//

import SwiftUI

struct SkipTutorialButton: View {
    @ObservedObject var gameData : ResourcePool
    @AppStorage("viewedTutorial") var didViewTutorial: Bool = false
    var body: some View {
        VStack{
//            Text("Hi, this is the tutorial. I'm assuming this is the first time you've logged on. You can skip this if you want. Tap the ? if you want to access it again. I reccomend that you don't though.")
            HStack{
                Button("Skip to game"){
                    didViewTutorial = true
                    
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}

struct firstTutorialSetup_Previews: PreviewProvider {
    static var previews: some View {
        SkipTutorialButton(gameData: ResourcePool())
    }
}
