//
//  WeNeverDieApp.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI

@main

struct WeNeverDieApp: App {
    @StateObject var gameData = ResourcePool()
    @StateObject var board = Board()
    @State var returnedData = ResourcePoolData()
    @StateObject var buildMan = BuildingManager()

    var body: some Scene {
        
        WindowGroup {
            //SoundTests()
            GameView(gameData: gameData, board: board, buildMan: buildMan)
                .onAppear{
                    returnedData = load(key: key) ?? ResourcePoolData()
                    gameData.setValue(resourcePoolData: returnedData)
                    gameData.audio.playMusic("Kurt")
                    
                }
            //DeviceRotationViewTest()
        }
    }
}
