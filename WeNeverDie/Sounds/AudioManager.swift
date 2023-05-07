//
//  AudioManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/6/23.
//

import Foundation
import AVFAudio
class AudioManager : ObservableObject{
    var musicPlayer: AVAudioPlayer?
    var songList = [String : URL]()
    var soundEffects = [String : URL]()
    var soundPlayers = [String: AVAudioPlayer]()
    @Published var sfxVolume: Float = 1.0
    @Published var musicVolume: Float = 1.0
    @Published var sfxMute: Bool = false
    @Published var musicMute: Bool = false

    init() {
        loadSFX()
        loadSongs()
    }
    func loadSFX(){
        soundEffects = [
            "Monster Noises": soundURL("Monster Noises"),
            "Long Growl": soundURL("Long Growl"),
            "Nom": soundURL("Nom"),
            "Stab": soundURL("stabTrimmed"),
            "Footsteps": soundURL("cleanFootsteps"),
            "Grabbing": soundURL("trimmedGrabbing"),
            "Empty": soundURL("EmptySearch", "mp3"),
            "Bad Result": soundURL("Wet Eating"),
            "Van Door": soundURL("Van DoorSFX", "mp3"),
            "Car Starting": soundURL("car startingSFX", "mp3"),
            "Leaving": soundURL("LeavingSFX", "mp3"),
        ]
        for (tag, url) in soundEffects {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                soundPlayers[tag] = player
            } catch {
                print("Error loading sound effect: \(tag)")
            }
        }
    }
    func loadSongs(){
        songList = [
            "Kurt": soundURL("Kurt - Cheel", "mp3"),
            "Death": soundURL("Shadows - Anno Domini Beats", "mp3"),
            "Victory": soundURL("The Dismal Hand - The Whole Other", "mp3")
        ]
    }
    func playSFX(_ tag: String) {
        guard let player = soundPlayers[tag], !sfxMute else {
            print("Error: Sound effect player not found for tag '\(tag)'")
            return
        }
        
        player.currentTime = 0
        player.volume = sfxVolume
        player.play()
    }
    func soundURL(_ name: String, _ ext: String? = nil) -> URL {
        let defaultExt = "m4a"
        let isSong = (name.contains(" - ") || name.contains(" -") || name.contains("- "))

        var finalExt = ext ?? (isSong ? "mp3" : defaultExt)
        finalExt = finalExt.lowercased()

        guard let url = Bundle.main.url(forResource: name, withExtension: finalExt) else {
            fatalError("Could not find sound file: \(name).\(finalExt)")
        }

        return url
    }
//    func soundURL(_ name: String, _ ext: String = "m4a") -> URL {
//        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
//            fatalError("Could not find sound file: \(name).\(ext)")
//        }
//        return url
//    }
 
    func playMusic(_ name: String) {
        if let url = songList[name], !musicMute {
            do {
                if musicPlayer == nil {
                    musicPlayer = try AVAudioPlayer(contentsOf: url)
                } else {
                    musicPlayer?.stop()
                    musicPlayer = try AVAudioPlayer(contentsOf: url)
                }
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.prepareToPlay()
                musicPlayer?.volume = musicVolume
                musicPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        } else {
            print("Error: unable to load music file.")
        }
    }

    func stopMusic() {
        musicPlayer?.stop()
        musicPlayer = nil
    }

}
