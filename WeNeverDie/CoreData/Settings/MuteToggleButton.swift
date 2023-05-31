//
//  MuteToggleButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/8/23.
//

import SwiftUI

struct MuteToggleButton: View {
    @State var name : String
    @ObservedObject var audio : AudioManager
    @ObservedObject var uiSettings : UserSettingsManager
   
    let soundSet: SoundSet
    
    var body: some View {
        HStack{
            if uiSettings.switchToLeft {
                MuteButton(audio: audio, uiSettings: uiSettings)
            }
            if !uiSettings.switchToLeft {
                Text(name)
            }
            // Music volume slider
            TappableSlider(value: soundSet == .music ? $audio.musicVolume : $audio.sfxVolume,range: 0...1, step: 0.01, isLeftHanded: uiSettings.switchToLeft)//For some reason this code will do
            if uiSettings.switchToLeft {
                Text(name)
            }
            if !uiSettings.switchToLeft {
                MuteButton(audio: audio, uiSettings: uiSettings)
            }
        }
    }
    
    private func MuteButton(audio: AudioManager, uiSettings: UserSettingsManager) -> some View {
        Button {
            if soundSet == .music {
                audio.toggleMusicMute()
            } else {
                audio.toggleSFXMute()
            }
        } label: {
            Image(systemName: (soundSet == .music ? !audio.musicMute : !audio.sfxMute) ? "speaker.wave.2.circle.fill" : "speaker.slash.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(uiSettings.visionAssist ? ((soundSet == .music ? !audio.musicMute : !audio.sfxMute) ? Color(.yellow) : Color(.purple).opacity(0.5)) : ((soundSet == .music ? !audio.musicMute : !audio.sfxMute) ? Color(.green) : Color(.red).opacity(0.5)))
                .shadow(radius: 5)
        }.frame(maxHeight: 50)
    }
}

enum SoundSet {
    case music
    case sfx
}

struct MuteToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        MuteToggleButton(name: "Test", audio: AudioManager(), uiSettings: UserSettingsManager(), soundSet: .sfx)
    }
}
