//
//  WeNeverDieApp.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI

@main
struct WeNeverDieApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var gameData = ResourcePool(surviors: 3, food: 10)
    @StateObject var board = Board(players: 0)
    
    var body: some Scene {
    
        WindowGroup {

            GameView(gameData: gameData, board: board)
            //DeviceRotationViewTest()
        }
    }
}
