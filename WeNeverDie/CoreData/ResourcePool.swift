//
//  ResourcePool.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/19/23.
//

import Foundation

class ResourcePool : ObservableObject {
    //Resources
    @Published var foodResource : Int
    @Published var survivorNumber : Int
    @Published var starving = false
    @Published var roster = [any Piece]()
    //Sent Variables
    @Published var survivorSent : Int = 0
    //Game Condition
    @Published var AlreadyWon = false
    @Published var ResetGame = false
    @Published var death = false
    @Published var victory = false
    //Victory Conditions
    @Published var deathRequirement : Int = 2 /// AMOUNT OF DAYS PLAYER HAS TO GET FOOD IF THEY ARE STARVING, BEFORE THEY DIE
    @Published var progressToDeath : Int = 0
    @Published var WinProgress = 0
    @Published var WinCondition = 30
    
    let starvationAmount = 0
 
    @Published var days = 0


    init(surviors : Int, food : Int) {
        foodResource = food
        survivorNumber = surviors
    }
    func reset() {
        foodResource = 10
        survivorNumber = 3
        starving = false
        roster = generateSurvivors(survivorNumber)
        
        survivorSent = 0
        
        death = false
        victory = false
        AlreadyWon = false
        ResetGame = false
        
        WinProgress = 0
        progressToDeath = 0
       
        days = 0
    }
    func generateSurvivors(_ number : Int)->[any Piece] {
        let firstNames = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Heidi", "Ivan", "Jack", "Kate", "Liam", "Mia", "Noah", "Olivia", "Peter", "Quinn", "Rachel", "Sarah", "Tom", "Ursula", "Victoria", "Wendy", "Xander", "Yara", "Zoe"]
        let lastNames = ["Anderson", "Brown", "Clark", "Davis", "Evans", "Ford", "Garcia", "Hill", "Ingram", "Jackson", "Kim", "Lee", "Miller", "Nguyen", "Olsen", "Perez", "Quinn", "Reed", "Smith", "Taylor", "Upton", "Vargas", "Walker", "Xu", "Young", "Zhang"]
        var generatedRoster = [any Piece]()
        for _ in 0..<number {
                let randomFirstName = firstNames.randomElement()!
                let randomLastName = lastNames.randomElement()!
                let fullName = "\(randomFirstName) \(randomLastName)"
            generatedRoster.append(playerUnit(name: fullName, board: Board(players: number)))
        }
        return generatedRoster
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
        if WinProgress >= WinCondition && AlreadyWon == false {
            victory = true
        }
    }
    
    func passDay(){
       print("Food \(foodResource)")
        days+=1
        print("Survivors sent \(survivorSent)")
        foodResource-=survivorNumber
        calcWinProgress()
    }
}
