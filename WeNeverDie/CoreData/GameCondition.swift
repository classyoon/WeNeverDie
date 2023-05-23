//
//  GameCondition.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation

class GameCondition : ObservableObject, Codable {
    @Published var stockpile : Stockpile
    //Game Condition
    @Published var AlreadyWon = false
    @Published var shouldResetGame = false
    @Published var hasViewedTutorial = false
    @Published var death = false
    @Published var victory = false
    //Victory Conditions
    @Published var deathRequirement : Int = 3 /// AMOUNT OF DAYS PLAYER HAS TO GET FOOD IF THEY
    @Published var progressToDeath : Int = 0
    init(_ stockpile : Stockpile){
        self.stockpile = stockpile
    }
    func checkForDefeat() {
        if !stockpile.starving {
            if progressToDeath > 0 {
                progressToDeath -= 1
            }
        } else {
            progressToDeath += 1
        }
        if progressToDeath > deathRequirement || stockpile.survivorNumber<=0{
            death = true
        }
    }
    func reset(){
        AlreadyWon = false
        shouldResetGame = false
        hasViewedTutorial = false
        death = false
        victory = false
        progressToDeath = 0
    }
}
