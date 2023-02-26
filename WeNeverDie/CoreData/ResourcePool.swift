//
//  ResourcePool.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/19/23.
//

import Foundation

class ResourcePool : ObservableObject {
    @Published var foodResource : Int
    @Published var survivorNumber : Int    
    @Published var survivorSent : Int = 0 {
          didSet {
              if survivorSent > 0 {
                  sent = true
                  //musicPlayer?.play()
              } else {
                  sent = false
              }
          }
      }
    @Published var AlreadyWon = false
    @Published var ResetGame = false
    @Published var sent = false
    @Published var deathRequirement : Int = 2 /// AMOUNT OF DAYS PLAYER HAS TO GET FOOD IF THEY ARE STARVING, BEFORE THEY DIE
    @Published var progressToDeath : Int = 0
    @Published var starving = false
    @Published var death = false
    @Published var WinCondition = 30
    @Published var victory = false
    @Published var WinProgress = 0
    @Published var days = 0
    let starvationAmount = 0
    init(surviors : Int, food : Int) {
        foodResource = food
        survivorNumber = surviors
    }
    func reset() {
        WinProgress = 0
        days = 0
        survivorSent = 0
        foodResource = 10
        survivorNumber = 3
        progressToDeath = 0
        death = false
        starving = false
        victory = false
        AlreadyWon = false
        ResetGame = false
    }
    func generateMap() -> Board{
       return Board(players: survivorSent)
    }
    
    func checkForDefeat() {
        if foodResource > starvationAmount {
            starving = false
            if progressToDeath > 0 {
                progressToDeath -= 1
            }
        } else {
            foodResource = starvationAmount //
            starving = true
            print("starving")
            progressToDeath += 1
        }
        if progressToDeath > deathRequirement {
            death = true
            print("Death")
        }
    }
    func calcWinProgress(){
        if survivorSent != survivorNumber {
            WinProgress+=(survivorNumber-survivorSent)
        }
//        else{
//            WinProgress-=1
//        }
        if WinProgress >= WinCondition && AlreadyWon == false {
            victory = true
        }
    }
    
    func passDay(){
       print("Food \(foodResource)")
        days+=1
        print("Survivors sent \(survivorSent)")
        if survivorSent > 0 {
            sent = true
            print("Perform mission first")
        }else {
            print("Perform calc first")
            print("New Food \(foodResource)")
            foodResource-=survivorNumber
            calcWinProgress()
            checkForDefeat()
        }
    }
}
