//
//  AudioManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/6/23.
//

import Foundation
import AVFoundation
let kurtSong = Bundle.main.url(forResource: "Kurt - Cheel", withExtension: "mp3")
var musicPlayer = try? AVAudioPlayer(contentsOf: (kurtSong!))
class AudioManager : ObservableObject{
    enum SFXTag: String, CaseIterable{
        case monsterNoises = "Monster Noises"
        case longGrowl = "Long Growl"
        case nom = "Nom"
        case stab = "stabTrimmed"
        case footsteps = "cleanFootsteps"
        case grabbing = "trimmedGrabbing"
        case empty = "EmptySearch.mp3"
        case badResult = "Wet Eating"
        case vanDoor = "Van DoorSFX.mp3"
        case carStarting = "car startingSFX.mp3"
        case leaving = "LeavingSFX.mp3"
    }
    var musicPlayer: AVAudioPlayer?
    var songList = [String : URL]()
    var soundEffects = [SFXTag : URL]()
    var soundPlayers = [String: AVAudioPlayer]()
    @Published var sfxVolume: Float = 4.0 {
        didSet {
            for player in soundPlayers.values {
                player.volume = sfxMute ? 0 : (sfxVolume * masterVolume)
            }
        }
    }
    @Published var musicVolume: Float = 0.5{
        didSet {
            musicPlayer?.volume = musicMute ? 0 : (musicVolume * masterVolume)
        }
    }
    
    
    @Published var masterVolume: Float = 1.0 {
        didSet {
            // Update volume of sound effects
            for player in soundPlayers.values {
                player.volume = sfxMute ? 0 : (sfxVolume * masterVolume)
            }
            
            // Update volume of music
            if let player = musicPlayer {
                player.volume = musicMute ? 0 : (musicVolume * masterVolume)
            }
        }
    }

    @Published var sfxMute: Bool = false
    @Published var musicMute: Bool = false
    
    init() {
        loadSFX()
        loadSongs()
    }
    func loadSFX(){
        for sound in SFXTag.allCases {
            let url = soundURL(sound.rawValue)
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                soundPlayers[sound.rawValue] = player
            } catch {
                print("Error loading sound effect: \(sound.rawValue)")
            }
        }
    }
    func loadSongs(){
        songList = [
            "Kurt": soundURL("Kurt - Cheel"),
            "Death": soundURL("Shadows - Anno Domini Beats"),
            "Victory": soundURL("The Dismal Hand - The Whole Other")
        ]
    }
    func playSFX(_ tag: SFXTag) {
        guard let player = soundPlayers[tag.rawValue] else {
            print("Error: Sound effect player not found for tag '\(tag)'")
            return
        }
        
        player.volume =  sfxMute ? 0 : (sfxVolume * masterVolume)
        
        player.currentTime = 0
        player.play()
    }
    
    func playMusic(_ name: String) {
        if let url = songList[name] {
            print("Playing music: \(name)")
            print("URL: \(url)")
            do {
                if musicPlayer == nil {
                    musicPlayer = try AVAudioPlayer(contentsOf: url)
                } else {
                    musicPlayer?.stop()
                    musicPlayer = try AVAudioPlayer(contentsOf: url)
                }
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.prepareToPlay()
                musicPlayer?.volume = musicMute ? 0 : (musicVolume * masterVolume)
                musicPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        } else {
            print("Error: unable to load music file.")
        }
    }
    func pauseMusic(){
        musicPlayer?.pause()
    }
    func resumeMusic(){
        musicPlayer?.play()
    }
    func soundURL(_ name: String) -> URL {
        let defaultExt = "m4a"
        let isSong = (name.contains(" - ") || name.contains(" -") || name.contains("- "))
        
        var finalExt = defaultExt
        var components = name.components(separatedBy: ".")
        if components.count > 1, let ext = components.popLast()?.lowercased() {
            finalExt = ext
        } else if isSong {
            finalExt = "mp3"
        }
        
        let fileName = components.joined(separator: ".")
        guard let url = Bundle.main.url(forResource: fileName, withExtension: finalExt) else {
            fatalError("Could not find sound file: \(fileName).\(finalExt)")
        }
        
        return url
    }
    
    func toggleMusicMute() {
        musicMute.toggle()
        if let player = musicPlayer {
            player.volume = musicMute ? 0 : musicVolume
        }
    }
    
    func toggleSFXMute() {
        sfxMute.toggle()
        for player in soundPlayers.values {
            player.volume = sfxMute ? 0 : sfxVolume
        }
    }
}
