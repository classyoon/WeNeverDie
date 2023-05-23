//
//  ResourceData.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
struct ResourcePoolData : Codable & Identifiable {
    var id = UUID()
    
    //Sent Variables
    var survivorSent : Int = 0
    //Game Condition
 
    var death = false
    var victory = false
    //Victory Conditions
    var lastTappedIndex: Int?
    var selectStatuses : [Bool] = Array(repeating: false, count: 3)
    
    var days = 0
    var gameConData : GameConditionModel
    var stockpileData : StockpileModel
    var buildData : BuildingManagerModel

    init(resourcePool : ResourcePool){
        
        self.survivorSent = resourcePool.survivorSent
        self.days = resourcePool.days
        self.selectStatuses = resourcePool.selectStatuses
        self.gameConData = resourcePool.gameConData
        self.stockpileData = resourcePool.stockpileData
        self.buildData = resourcePool.buildData
        
    }
   
//    init(foodStored: Int, survivorNumber: Int, starving: Bool = false, survivorSent: Int, AlreadyWon: Bool = false, shouldResetGame: Bool = false, death: Bool = false, victory: Bool = false, WinCondition: Int = 30, progressToDeath: Int, WinProgress: Int = 0, days: Int = 0) {
//        self.foodStored = foodStored
//        self.survivorNumber = survivorNumber
//        self.starving = starving
//        self.survivorSent = survivorSent
//        self.AlreadyWon = AlreadyWon
//        self.shouldResetGame = shouldResetGame
//        self.death = death
//        self.victory = victory
//        self.WinCondition = WinCondition
//        self.progressToDeath = progressToDeath
//        self.WinProgress = WinProgress
//        self.days = days
//        self.selectStatuses = Array(repeating: false, count: survivorNumber)
//        
//    
//    }
    
}
