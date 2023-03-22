//
//  PassDayButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct PassDayButton: View {
    var canSendMission: Bool {
        surivorsSentOnMission != 0
    }
    @Binding var surivorsSentOnMission: Int
    @ObservedObject var gameData : ResourcePool
    @Binding var showBoard: Bool
    func shouldShowMap() -> Bool {
        if surivorsSentOnMission > 0 {
            return true
        }
        return false
    }
    func campPassDay() {
        showBoard = shouldShowMap()
        gameData.passDay()
        
        print("Showing board = \(showBoard)")
        print("Sending \(gameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        gameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(gameData.survivorSent)")
        save(items: ResourcePoolData(resourcePool: gameData), key: key)
    }
    var body: some View {
        Button {
            campPassDay()
            if canSendMission {
                leavingSoundPlayer?.prepareToPlay()
                leavingSoundPlayer?.play()
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
