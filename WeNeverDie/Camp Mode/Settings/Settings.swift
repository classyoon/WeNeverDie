//
//  Settings.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var gameData: ResourcePool
    
    @State var musicIsPlaying = false
    var body: some View {
        VStack (alignment: gameData.switchToLeft ? .leading : .trailing){
//                        Text(devMode ? "Game Developer Mode on (go back to camp to update)":"Game Developer Mode off (go back to camp to update)").foregroundColor(Color.blue)
//                        Button("Developer Mode Toggle") {
//                            devMode.toggle()
//                            print("devMode \(devMode)")
//                        }.buttonStyle(.bordered)
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
                    .foregroundColor(musicIsPlaying ? Color(.green) : Color(.red).opacity(0.5))
                    .shadow(radius: 5)
            }.frame(maxHeight: 50)
            !gameData.isInMission ? nil : Text("Other settings unavailible during mission")
            !gameData.isInMission ? Button(gameData.visionAssist ? "Vision Assist Mode On" : "Vision Assist Mode Off"){
                gameData.toggleAssistMode()
            }.buttonStyle(.bordered) : nil
            !gameData.isInMission ? Button(gameData.switchToLeft ? "Left Hand Mode On" : "Left Hand Mode Off"){
                gameData.toggleLeftHandMode()
            }.buttonStyle(.bordered)  : nil
            !gameData.isInMission ?  ResetButtonView(gameData: gameData) : nil
            !gameData.isInMission ? HardModeResetButtonView(gameData: gameData) : nil
            //            .background(gameData.switchToLeft ? Color.b : Color.green)
            //
        }.padding()
        .onAppear {
            musicIsPlaying = musicPlayer?.isPlaying == true
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gameData: ResourcePool())
    }
}
