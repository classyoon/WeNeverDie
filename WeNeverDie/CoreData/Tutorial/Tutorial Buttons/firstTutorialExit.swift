//
//  firstTutorialExit.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct firstTutorialExit: View {
    @ObservedObject var gameData : ResourcePool
    @AppStorage("viewedTutorial") var didViewTutorial: Bool = false
    var body: some View {
        Button("Begin Game"){
            didViewTutorial = true
        }.buttonStyle(.bordered)
            .padding()
    }
}

struct firstTutorialExit_Previews: PreviewProvider {
    static var previews: some View {
        firstTutorialExit(gameData: ResourcePool())
    }
}
