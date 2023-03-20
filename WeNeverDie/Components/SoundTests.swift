//
//  SoundTests.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/13/23.
//

import SwiftUI
import AVFAudio


import AVFoundation


// Load the music file
let victorySong = Bundle.main.url(forResource: "The Dismal Hand - The Whole Other", withExtension: "mp3")
let defeatSong = Bundle.main.url(forResource: "Shadows - Anno Domini Beats", withExtension: "mp3")
let kurtSong = Bundle.main.url(forResource: "Kurt - Cheel", withExtension: "mp3")
var monsterNoisesURL = Bundle.main.url(forResource: "Monster Noises", withExtension: "m4a")
var secondMonsterNoise = Bundle.main.url(forResource: "Long Growl", withExtension: "m4a")
var monsterAttack = Bundle.main.url(forResource: "Nom", withExtension: "m4a")
var knifeStabSFX = Bundle.main.url(forResource: "stabTrimmed", withExtension: "m4a")
var leavingSFX = Bundle.main.url(forResource: "LeavingSFX", withExtension: "mp3")
var walkingSFX = Bundle.main.url(forResource: "cleanFootsteps", withExtension: "m4a")
var grabSFX = Bundle.main.url(forResource: "trimmedGrabbing", withExtension: "m4a")
var emptySFX = Bundle.main.url(forResource: "EmptySearch", withExtension: "mp3")
var vanSFX = Bundle.main.url(forResource: "Van DoorSFX", withExtension: "mp3")
var drivingSFX = Bundle.main.url(forResource: "car startingSFX", withExtension: "mp3")
var eatingSFX = Bundle.main.url(forResource: "Wet Eating", withExtension: "mp3")

var defeatPlayer = try? AVAudioPlayer(contentsOf: (defeatSong!))
var victoryPlayer = try? AVAudioPlayer(contentsOf: (victorySong!))
var musicPlayer = try? AVAudioPlayer(contentsOf: (kurtSong!))
var soundPlayer = try? AVAudioPlayer(contentsOf: (monsterNoisesURL!))
var monsterSpawnSFXPlayer = try? AVAudioPlayer(contentsOf: (secondMonsterNoise!))
var playerSoundPlayer = try? AVAudioPlayer(contentsOf: (knifeStabSFX!))
var leavingSoundPlayer = try? AVAudioPlayer(contentsOf: (leavingSFX!))
var playerwalkSoundPlayer = try? AVAudioPlayer(contentsOf: (walkingSFX!))
var grabSoundPlayer = try? AVAudioPlayer(contentsOf: (grabSFX!))
var emptySoundPlayer = try? AVAudioPlayer(contentsOf: (emptySFX!))
var VanDoorSoundPlayer = try? AVAudioPlayer(contentsOf: (vanSFX!))
var StartingSoundPlayer = try? AVAudioPlayer(contentsOf: (drivingSFX!))
var eatingSoundPlayer = try? AVAudioPlayer(contentsOf: (eatingSFX!))



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
