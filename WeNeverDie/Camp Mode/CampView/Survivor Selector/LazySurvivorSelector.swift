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
    
    var body: some View {
        VStack{
            HStack{
                
                ForEach(0..<GameData.selectStatuses.count, id: \.self){ index in
                  
                        Button {
                            GameData.balance(index)
                        } label: {
                            Image(systemName: uiSettings.switchToLeft ?
                                  (index >= GameData.selectStatuses.count - GameData.stockpile.getSurvivorSent() ? "person.fill" : "person") :
                                    (index < GameData.stockpile.getSurvivorSent() ? "person.fill" : "person")) .resizable()
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

