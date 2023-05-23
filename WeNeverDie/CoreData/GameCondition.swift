//
//  GameCondition.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation

class GameCondition : ObservableObject {
    @Published var stockpile : Stockpile
    @Published var data : GameConditionModel
    var starving : Bool {
        stockpile.stockpileData.foodStored<=0
    }
    
    init(_ stockpile : Stockpile, data : GameConditionModel){
        self.stockpile = stockpile
        self.data = data
    }
    func checkForDefeat() {
        if !starving {
            data.progressToDeath -= 1
        } else {
            data.progressToDeath += 1
        }
        if data.starvedToDeath() || stockpile.runOutOfPeople() {
            data.setDefeat()
        }
        
    }
    func getDeathCountdown()->Int{
        return data.deathRequirement-data.progressToDeath
    }
    func reset(){
        data.reset()
    }
    
}
struct GameConditionModel : Identifiable, Codable {
    var id = UUID()
    var AlreadyWon = false
    var shouldResetGame = false
    var hasViewedTutorial = false
    var death = false
    var victory = false
    var deathRequirement : Int = 3 
    var progressToDeath : Int = 0
    mutating func reset(){
        AlreadyWon = false
        shouldResetGame = false
        hasViewedTutorial = false
        death = false
        victory = false
        progressToDeath = 0
    }
    func starvedToDeath()->Bool{
        if progressToDeath > deathRequirement {
            return true
        }
        return false
    }
    mutating func setDefeat(){
        death = true
    }
}
