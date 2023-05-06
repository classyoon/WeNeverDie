//
//  WeNeverDieApp.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI

@main

struct WeNeverDieApp: App {
    @StateObject var gameData = ResourcePool(surviors: 1, food: 0)
    @StateObject var board = Board()
    @State var returnedData = ResourcePoolData()
    
    var body: some Scene {
        
        WindowGroup {
            //SoundTests()
            GameView(gameData: gameData, board: board)
                .onAppear{
                    returnedData = load(key: key) ?? ResourcePoolData()
                    gameData.setValue(resourcePoolData: returnedData)
                    gameData.audio.playMusic("Kurt")
//                    musicPlayer?.prepareToPlay()
//                    musicPlayer?.volume = 0.1
//                    soundPlayer?.volume = 1.5
                }
            //DeviceRotationViewTest()
        }
    }
}
