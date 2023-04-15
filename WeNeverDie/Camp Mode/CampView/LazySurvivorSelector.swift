//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct LazySurvivorSelector: View {

    @ObservedObject var GameData : ResourcePool
    
    var body: some View {
        VStack{
            HStack{
                
                ForEach(0..<GameData.selectStatuses.count, id: \.self){ index in
                    VStack{
                        Button {
                            GameData.balance(index)
                        } label: {
                            Image(systemName: GameData.switchToLeft ?
                                                           (index >= GameData.selectStatuses.count - GameData.survivorSent ? "person.fill" : "person") :
                                                           (index < GameData.survivorSent ? "person.fill" : "person")) .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                
            }.frame(maxHeight: 50)
        }
    }
}

struct LazySurvivorSelector_Previews: PreviewProvider {
    static var previews: some View {
    LazySurvivorSelector(GameData: ResourcePool())
    }
}

