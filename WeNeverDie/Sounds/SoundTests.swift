//
//  SoundTests.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/13/23.
//

import SwiftUI
import AVFAudio


import AVFoundation


import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    private var soundEffects: [String: URL] = [
        "kurtSong": Bundle.main.url(forResource: "Kurt - Cheel", withExtension: "mp3")!,
        "monsterNoises": Bundle.main.url(forResource: "Monster Noises", withExtension: "m4a")!,
        "secondMonsterNoise": Bundle.main.url(forResource: "Nom", withExtension: "m4a")!
    ]
    
    func playSoundEffect(named name: String) {
        guard let soundURL = soundEffects[name] else {
            print("Sound effect '\(name)' not found.")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch let error {
            print("Error playing sound effect: \(error.localizedDescription)")
        }
    }
    
    func stopAllSounds() {
        player?.stop()
        player = nil
    }
    
}


struct SoundTests: View {
    var body: some View {
        Button("Play Sound"){
            SoundManager.shared.playSoundEffect(named: "monsterNoises")
           
        }
    }
}

struct SoundTests_Previews: PreviewProvider {
    static var previews: some View {
        SoundTests()
    }
}
