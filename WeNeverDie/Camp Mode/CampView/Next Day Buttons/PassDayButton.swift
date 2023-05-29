//
//  PassDayButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct PassDayButton: View {
    @ObservedObject var stockpile : Stockpile = Stockpile.shared
   
    @Binding var surivorsSentOnMission: Int
    @ObservedObject var gameData : ResourcePool
   
    @Binding var showBoard: Bool
    func shouldShowMap() -> Bool {
        if Stockpile.shared.getSurvivorSent() > 0 {
            return true
        }
        return false
    }
    func campPassDay() {
        showBoard = shouldShowMap()
        gameData.passDay()
      
        Stockpile.shared.stockpileData.survivorSent = surivorsSentOnMission
        gameData.buildingMan.saveAll()
        save(items: ResourcePoolData(resourcePool: gameData), key: key)
    }
    var body: some View {
        Button {
            campPassDay()
            if shouldShowMap() {
               showBoard = true
            }
        } label: {
            VStack {
                Image(systemName: "bed.double.circle.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(.white)
                Text("We should try to Sleep. Zombies can wait.")
            }
        }.padding()
            .frame(maxHeight: 100)
    }
}


struct PassDayButton_Previews: PreviewProvider {
    static var previews: some View {
        PassDayButton(surivorsSentOnMission: .constant(4), gameData: ResourcePool(), showBoard: .constant(false))
    }
}
