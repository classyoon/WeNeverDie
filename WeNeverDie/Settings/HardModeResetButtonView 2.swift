//
//  HardModeResetButtonView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct HardModeResetButtonView: View {
    @ObservedObject var gameData : ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    var body: some View {
        Button {
            gameData.hardmodeReset()

        } label: {
            Text("Want more of a challenge? This button will start you with one person and no food.")
                .font(.headline)
                .bold()
                .padding()
                .foregroundColor(uiSettings.visionAssist ? Color.purple : Color.red)
                .background(
                    Color.white
                ).overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(uiSettings.visionAssist ? Color.purple : Color.red, lineWidth: 5)
                ).clipShape(RoundedRectangle(cornerRadius: 50))
        }.shadow(color: uiSettings.visionAssist ? .purple : .red, radius: 5)
       
    }
}

struct HardModeResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HardModeResetButtonView(gameData: ResourcePool(), uiSettings: UserSettingsManager())
    }
}
