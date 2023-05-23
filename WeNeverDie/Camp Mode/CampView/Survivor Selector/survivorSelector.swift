//
//  survivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct survivorSelector : View {
    @ObservedObject var gameData : ResourcePool

    var body: some View {
        VStack(alignment: .trailing) {
            Text("People to send scavenging: \(gameData.survivorSent)")
                .font(.footnote)
            LazySurvivorSelector(GameData: gameData, uiSettings: gameData.uiSetting)
        }.padding()
        .background(.brown.opacity(0.7))
    }
}


struct survivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        survivorSelector(gameData: ResourcePool())
    }
}
