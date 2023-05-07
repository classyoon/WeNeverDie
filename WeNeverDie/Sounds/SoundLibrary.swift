//
//  SoundLibrary.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/10/23.
//

import SwiftUI
import AVFAudio

let PlayerSFXArray = [grabSFX, knifeStabSFX, emptySFX, walkingSFX, vanSFX]
let MusicListArray = [victorySong, defeatSong, kurtSong]
let ZombieSFXArray = [eatingSFX, secondMonsterNoise, monsterAttack, eatingSFX]
let TransitionSFXArray = [leavingSFX, drivingSFX]

let SFXArrays = [PlayerSFXArray, ZombieSFXArray]
let MusicArrays = [MusicListArray, TransitionSFXArray]

var SFXPlayer = try? AVAudioPlayer(contentsOf: (SFXArrays[0][0]!))
var MusicSFXPlayer = try? AVAudioPlayer(contentsOf: (MusicArrays[0][0]!))

// Load the music file
var defeatPlayer = try? AVAudioPlayer(contentsOf: (defeatSong!))
var victoryPlayer = try? AVAudioPlayer(contentsOf: (victorySong!))
var musicPlayer = try? AVAudioPlayer(contentsOf: (kurtSong!))

var VanDoorSoundPlayer = try? AVAudioPlayer(contentsOf: (vanSFX!))
var StartingSoundPlayer = try? AVAudioPlayer(contentsOf: (drivingSFX!))
var eatingSoundPlayer = try? AVAudioPlayer(contentsOf: (eatingSFX!))
var leavingSoundPlayer = try? AVAudioPlayer(contentsOf: (leavingSFX!))


var soundPlayer = try? AVAudioPlayer(contentsOf: (monsterNoisesURL!))
var monsterSpawnSFXPlayer = try? AVAudioPlayer(contentsOf: (secondMonsterNoise!))

var playerSoundPlayer = try? AVAudioPlayer(contentsOf: (knifeStabSFX!))
var playerwalkSoundPlayer = try? AVAudioPlayer(contentsOf: (walkingSFX!))
var grabSoundPlayer = try? AVAudioPlayer(contentsOf: (grabSFX!))
var emptySoundPlayer = try? AVAudioPlayer(contentsOf: (emptySFX!))



let victorySong = Bundle.main.url(forResource: "The Dismal Hand - The Whole Other", withExtension: "mp3")
let defeatSong = Bundle.main.url(forResource: "Shadows - Anno Domini Beats", withExtension: "mp3")
let kurtSong = Bundle.main.url(forResource: "Kurt - Cheel", withExtension: "mp3")

var monsterNoisesURL = Bundle.main.url(forResource: "Monster Noises", withExtension: "m4a")
var secondMonsterNoise = Bundle.main.url(forResource: "Long Growl", withExtension: "m4a")
var monsterAttack = Bundle.main.url(forResource: "Nom", withExtension: "m4a")

var knifeStabSFX = Bundle.main.url(forResource: "stabTrimmed", withExtension: "m4a")
var walkingSFX = Bundle.main.url(forResource: "cleanFootsteps", withExtension: "m4a")
var grabSFX = Bundle.main.url(forResource: "trimmedGrabbing", withExtension: "m4a")
var emptySFX = Bundle.main.url(forResource: "EmptySearch", withExtension: "mp3")

var eatingSFX = Bundle.main.url(forResource: "Wet Eating", withExtension: "mp3")
var vanSFX = Bundle.main.url(forResource: "Van DoorSFX", withExtension: "mp3")
var drivingSFX = Bundle.main.url(forResource: "car startingSFX", withExtension: "mp3")
var leavingSFX = Bundle.main.url(forResource: "LeavingSFX", withExtension: "mp3")
func playSFX(SFXINDEX : Int, SFXARRAY : Int ){
  SFXPlayer = try? AVAudioPlayer(contentsOf: (SFXArrays[SFXARRAY][SFXINDEX]!))
}
func playSong(SFXINDEX : Int, SFXARRAY : Int ){
    MusicSFXPlayer = try? AVAudioPlayer(contentsOf: (SFXArrays[SFXARRAY][SFXINDEX]!))
}
struct SoundLibrary: View {
    var body: some View {
        HStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                
            } label: {
                Text("Play Sound")
            }
        }
    }
}

struct SoundLibrary_Previews: PreviewProvider {
    static var previews: some View {
        SoundLibrary()
    }
}
enum SoundEffect {
    case player(PlayerSFX)
    case zombie(ZombieSFX)
    
    enum PlayerSFX: CaseIterable {
        case grab, knifeStab, empty, walking, van
        var fileURL: URL {
            switch self {
            case .grab:
                return grabSFX!
            case .knifeStab:
                return knifeStabSFX!
            case .empty:
                return emptySFX!
            case .walking:
                return walkingSFX!
            case .van:
                return vanSFX!
            }
        }
    }
    
    enum ZombieSFX: CaseIterable {
        case eating, monsterSpawn, monsterChomp
        var fileURL: URL {
            switch self {
            case .eating:
                return eatingSFX!
            case .monsterSpawn:
                return monsterNoisesURL!
            case .monsterChomp:
                return monsterAttack!
            }
        }
    }
    
    var fileURL: URL {
        switch self {
        case .player(let sfx):
            return sfx.fileURL
        case .zombie(let sfx):
            return sfx.fileURL
        }
    }
}

enum Music {
    case song(MusicList)
    case transition(TransitionSFX)
    
    enum MusicList: CaseIterable {
        case victory, defeat, kurt
        var fileURL: URL {
            switch self {
            case .victory:
                return victorySong!
            case .defeat:
                return defeatSong!
            case .kurt:
                return kurtSong!
            }
        }
    }
    
    enum TransitionSFX: CaseIterable {
        case leaving, driving
        var fileURL: URL {
            switch self {
            case .leaving:
                return leavingSFX!
            case .driving:
                return drivingSFX!
            }
        }
    }
    
    var fileURL: URL {
        switch self {
        case .song(let music):
            return music.fileURL
        case .transition(let sfx):
            return sfx.fileURL
        }
    }
}

var sfxPlayer: AVAudioPlayer?
var songPlayer: AVAudioPlayer?

func playSFX(_ soundEffect: SoundEffect) {
    sfxPlayer = try? AVAudioPlayer(contentsOf: soundEffect.fileURL)
}

func playSong(_ music: Music) {
    songPlayer = try? AVAudioPlayer(contentsOf: music.fileURL)
}
