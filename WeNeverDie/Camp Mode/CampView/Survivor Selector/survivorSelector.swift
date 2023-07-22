//
//  survivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct survivorSelector : View {
    @ObservedObject var gameData : ResourcePool
    var stockpile : Stockpile = Stockpile.shared
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("People going outside: \(stockpile.getSurvivorSent()), People in camp: \(stockpile.getNumOfPeople()-stockpile.getSurvivorSent())")
                .font(.footnote)
            
                LazySurvivorSelector(GameData: gameData)
            
        }.padding()
        .background(.brown.opacity(0.7))
    }
}


struct survivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        survivorSelector(gameData: ResourcePool())
    }
}
