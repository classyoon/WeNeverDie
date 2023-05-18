//
//  ResetFuncs.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/18/23.
//

import Foundation

extension ResourcePool {
    func hardmodeReset(){
        reset()
        survivorNumber = 1
        foodStored = 0
        selectStatuses = Array(repeating: false, count: survivorNumber)
    }
    func reset() {
        foodStored = 10
        survivorNumber = survivorDefaultNumber
        starving = false
        //        roster = generateSurvivors(survivorNumber)
        selectStatuses = Array(repeating: false, count: survivorNumber)
      
        survivorSent = 0
        
        death = false
        victory = false
        AlreadyWon = false
        shouldResetGame = false
        WinProgress = 0
        progressToDeath = 0
        audio.playMusic("Kurt")
       
        days = 0
    }
    
}
