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
    
    func toggleLeftHandMode(){
        switchToLeft.toggle()
    }
    func toggleAssistMode(){
        visionAssist.toggle()
    }
}

struct Settings: View {
    @ObservedObject var gameData: ResourcePool
    static var musicVolume: Float = 1.0
    static var sfxVolume: Float = 1.0
    @State var musicIsPlaying = false
    @ObservedObject var uiSettings : UserSettingsManager
    var body: some View {
        VStack (alignment: uiSettings.switchToLeft ? .leading : .trailing){
            Button {
                if musicIsPlaying {
                    guard (musicPlayer?.pause()) != nil else {
                        fatalError("Unable to pause music")
                    }
                    musicIsPlaying = musicPlayer?.isPlaying == true
                } else {
                    guard (musicPlayer?.play()) != nil else {
                        fatalError("Unable to start music")
                    }
                    musicIsPlaying = musicPlayer?.isPlaying == true
                }
            } label: {
                Image(systemName: musicIsPlaying ? "speaker.wave.2.circle.fill" : "speaker.slash.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(uiSettings.visionAssist ? (musicIsPlaying ? Color(.yellow) : Color(.purple).opacity(0.5)) : (musicIsPlaying ? Color(.green) : Color(.red).opacity(0.5)))
                    .shadow(radius: 5)
            }.frame(maxHeight: 50)
            Button(uiSettings.visionAssist ? "Alternative Vision" : "Common Vision"){
                uiSettings.toggleAssistMode()
            }.buttonStyle(.bordered)
            Button(uiSettings.switchToLeft ? "Left Hand" : "Right Hand"){
                uiSettings.toggleLeftHandMode()
            }.buttonStyle(.bordered)
            
            !gameData.isInMission ? nil : Text("Reset unavailable during mission")
            !gameData.isInMission ?  ResetButtonView(gameData: gameData, uiSettings: gameData.uiSetting) : nil
            !gameData.isInMission ? HardModeResetButtonView(gameData: gameData, uiSettings: gameData.uiSetting) : nil
            //            .background(uiSettings.switchToLeft ? Color.b : Color.green)
            //
        }.padding()
        .onAppear {
            musicIsPlaying = musicPlayer?.isPlaying == true
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gameData: ResourcePool(), uiSettings: UserSettingsManager())
    }
}
