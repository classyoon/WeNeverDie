//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct LazySurvivorSelector: View {
    
    @ObservedObject var GameData: ResourcePool
    @ObservedObject var stock = Stockpile.shared
    var body: some View {
        HStack{
            ForEach(0..<stock.getNumOfPeople()-stock.getBuilders(), id: \.self){ index in
               SurvivorButtonGroup(GameData: GameData, index: index)
                
            }
        }
        
    }
}
struct LazySurvivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        LazySurvivorSelector(GameData: ResourcePool())
    }
}

