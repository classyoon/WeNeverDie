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
 

    var body: some Scene {
        
        WindowGroup {
            //SoundTests()
            GameView(gameData: gameData, board: board)
                .onAppear{
                    print("Loaded RESOURCE")
                    print("Has viewed tutorial = \(gameData.gameCon.checkViewedTutorial())")
                    returnedData = load(key: key) ?? ResourcePoolData()
                    gameData.setValue(resourcePoolData: returnedData)
                    gameData.audio.playMusic("Kurt")
                    
                }
            //DeviceRotationViewTest()
        }
    }
}
