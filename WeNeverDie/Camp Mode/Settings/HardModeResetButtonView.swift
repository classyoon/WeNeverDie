//
//  HardModeResetButtonView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct HardModeResetButtonView: View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        Button {
            
                gameData.reset()
                gameData.survivorNumber = 1
                gameData.foodStored = 0
            
        } label: {
            Text("Want more of a challenge? This button will start you with one person and no food.")
                .font(.headline)
                .bold()
                .padding()
                .foregroundColor(gameData.visionAssist ? Color.purple : Color.red)
                .background(
                    Color.white
                ).overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(gameData.visionAssist ? Color.purple : Color.red, lineWidth: 5)
                ).clipShape(RoundedRectangle(cornerRadius: 50))
        }.shadow(color: gameData.visionAssist ? .purple : .red, radius: 5)
       
    }
}

struct HardModeResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HardModeResetButtonView(gameData: ResourcePool())
    }
}
