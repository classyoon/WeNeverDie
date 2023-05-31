//
//  Settings.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



//Text(devMode ? "Game Developer Mode on (go back to camp to update)":"Game Developer Mode off (go back to camp to update)").foregroundColor(Color.blue)
//                        Button("Developer Mode Toggle") {
//                            devMode.toggle()
//                            print("devMode \(devMode)")
//                        }.buttonStyle(.bordered)
class UserSettingsManager : ObservableObject {
    @Published var switchToLeft = false
    @Published var visionAssist = false
    @Published var isAutoPauseMusic = true
    
    func toggleLeftHandMode(){
        switchToLeft.toggle()
    }
    
    func toggleAssistMode(){
        visionAssist.toggle()
    }
    func autoPauseMusic(){
        isAutoPauseMusic.toggle()
    }
}

struct Settings: View {
    @ObservedObject var gameData: ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    @ObservedObject var audio : AudioManager
    var body: some View {
        
        VStack (alignment: uiSettings.switchToLeft ? .leading : .trailing){
            
            MuteToggleButton(name: "Music", audio: audio, uiSettings: uiSettings,  soundSet: .music)
            
            MuteToggleButton(name: "Sound FX", audio: audio, uiSettings: uiSettings, soundSet: .sfx)
            
            Button(uiSettings.visionAssist ? "Alternative Vision" : "Common Vision"){
                uiSettings.toggleAssistMode()
            }.buttonStyle(.bordered)
            Button(uiSettings.switchToLeft ? "Left Hand" : "Right Hand"){
                uiSettings.toggleLeftHandMode()
            }.buttonStyle(.bordered)
            !gameData.isInMission ? nil : Text("Reset unavailable during mission")
            !gameData.isInMission ? ResetButtons(gameData: gameData, uiSettings: uiSettings) : nil
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gameData: ResourcePool(), uiSettings: UserSettingsManager(), audio: AudioManager())
    }
}

