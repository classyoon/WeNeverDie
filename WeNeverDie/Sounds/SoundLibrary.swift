//
//  SoundLibrary.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/10/23.
//

import SwiftUI
import AVFAudio

struct SoundLibrary: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
/**
 var secondMonsterNoise = Bundle.main.url(forResource: "Long Growl", withExtension: "m4a")

 var monsterSpawnSFXPlayer = try? AVAudioPlayer(contentsOf: (secondMonsterNoise!))
 */

struct SoundLibrary_Previews: PreviewProvider {
    static var previews: some View {
        SoundLibrary()
    }
}

class AudioManager {
    var currentSFXClip: URL?
    var currentSongClip: URL?
    var songPlayer: AVAudioPlayer
    var soundPlayer: AVAudioPlayer
    var soundURLs: [String: URL] = [:]
    var songURLs: [String: URL] = [:]
    
    init(currentSFXClip: URL? = nil, currentSongClip: URL? = nil) {
        self.currentSFXClip = currentSFXClip
        self.currentSongClip = currentSongClip
        
        // Initialize the soundURLs dictionary
        let sounds = [("Monster Noises", "m4a"), ("Long Growl", "m4a"), ("Nom", "m4a"), ("stabTrimmed", "mp3")]
        let songs = [("Kurt", "m4a"), ("Shadows", "m4a"), ("Apoc", "m4a"), ("Surrender", "mp3")]
        for (name, ext) in sounds {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                soundURLs[name] = url
            }
        }
        for (name, ext) in songs {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                songURLs[name] = url
            }
        }
        soundPlayer = try! AVAudioPlayer(contentsOf: (currentSFXClip!))
        songPlayer = try! AVAudioPlayer(contentsOf: (currentSongClip!))
    }
    
    func setSoundFile(name: String){
        currentSFXClip = soundURLs[name]
    }
    func playSFX() {
        soundPlayer.play()
    }
    func playSFX(_ name : String) {
        setSoundFile(name: name)
        soundPlayer = try! AVAudioPlayer(contentsOf: (currentSFXClip!))
        soundPlayer.play()
    }
    
    func setSongFile(name: String) {
        currentSongClip = songURLs[name]
    }
    func playSong() {
        songPlayer.play()
    }
    func playSong(_ name : String) {
        setSongFile(name: name)
        soundPlayer = try! AVAudioPlayer(contentsOf: (currentSFXClip!))
        soundPlayer.play()
    }
}

