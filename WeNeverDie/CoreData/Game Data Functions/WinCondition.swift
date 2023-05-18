//
//  WinCondition.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/18/23.
//

import Foundation

extension ResourcePool {
    func checkForDefeat() {
        print("Calc Defeat")
        if foodStored > starvationAmount {
            starving = false
            if progressToDeath > 0 {
                print("Regen")
                progressToDeath -= 1
                print("Checking for Defeat Results -> Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
            }
        } else {
            foodStored = starvationAmount //
            starving = true
            print("starving")
            progressToDeath += 1
            print("Checking for Defeat Results -> Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        }
        if progressToDeath > deathRequirement || survivorNumber<=0{
            death = true
            print("Death")
            print("Checking for Defeat Results -> Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
            audio.playMusic("Death")
        }
    }
    func calcWinProgress(){
        print("Making cure with \(survivorNumber-survivorSent) survivors")
        if survivorSent != survivorNumber {
            WinProgress+=(survivorNumber-survivorSent)
            print("Checking for Cure Results -> Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        }
        if WinProgress >= WinCondition && AlreadyWon == false {
            audio.playMusic("Victory")
            victory = true
            //AlreadyWon = true
            print("No longer making cure : Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        }
    }
}
