//
//  ResetButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/8/23.
//

import SwiftUI

struct ResetButtons: View {
    @ObservedObject var gameData : ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    var body: some View {
        VStack(alignment: uiSettings.switchToLeft ? .leading : .trailing){
            ResetButtonView(gameData: gameData, uiSettings: gameData.uiSetting)
            HardModeResetButtonView(gameData: gameData, uiSettings: gameData.uiSetting)
        }
    }
}

struct ResetButtons_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtons(gameData: ResourcePool(), uiSettings: UserSettingsManager())
    }
}
