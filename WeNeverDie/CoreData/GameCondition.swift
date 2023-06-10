//
//  GameCondition.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation

class GameCondition : ObservableObject {
    @Published var data : GameConditionModel
    @Published var stockpile : Stockpile = Stockpile.shared
    var starving : Bool {
        stockpile.stockpileData.foodStored<=0
    }
    static let shared = GameCondition(data: GameConditionModel())
    private init(data: GameConditionModel) {
            self.data = data
        }
    
    func checkForDefeat() {
        print("check for defeat starting at \(data.progressToDeath)")
        if !starving && data.progressToDeath>0{
            data.progressToDeath -= 1
            print("Regen")
        } else {
            data.loseHealth()
            print("Dying \(data.progressToDeath)")
        }
        if data.starvedToDeath() || stockpile.runOutOfPeople() {
            data.setDefeat()
            
            print("Starved to death")
        }
        
    }
    func getDeathCountdown()->Int{
        return data.deathRequirement-data.progressToDeath
    }
    func getDeath()-> Bool {
        return data.death
    }
    func checkHaveWon()-> Bool {
        return data.AlreadyWon
    }
    func checkVictory()-> Bool {
        return data.victory
    }
    func checkViewedTutorial()-> Bool {
        return data.hasViewedTutorial
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
    var isOnHardmode = false
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
    mutating func loseHealth(){
        progressToDeath+=1
    }
    mutating func setDefeat(){
        death = true
    }
}
