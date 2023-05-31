//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct LazySurvivorSelector: View {
    
    @ObservedObject var GameData: ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    @ObservedObject var stock = Stockpile.shared
    var buildMan : BuildingManager = BuildingManager.shared
//    func checkBuilders()->Int{
//        Stockpile.shared.setBuilders(buildMan.buildings.reduce(0) { $0 + $1.workers })
//        return Stockpile.shared.getBuilders()
//    }
    var body: some View {
        VStack{
            HStack{
                ForEach(0..<stock.getNumOfPeople()-stock.getBuilders(), id: \.self){ index in
                        Button {
                            
                                GameData.balance(index)
                            
                            GameData.audio.playSFX(.enterDoor)
                        } label: {
                            Image(systemName: uiSettings.switchToLeft ?
                                  (index >= GameData.selectStatuses.count -  Stockpile.shared.getSurvivorSent() ? "person.fill" : "person") :
                                    (index < Stockpile.shared.getSurvivorSent() ? "person.fill" : "person")) .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    
                }
            }.frame(maxHeight: 50)
        }
    }
}

struct LazySurvivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        LazySurvivorSelector(GameData: ResourcePool(), uiSettings: UserSettingsManager())
    }
}

