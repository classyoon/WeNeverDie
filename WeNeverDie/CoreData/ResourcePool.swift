//
//  ResourcePool.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/19/23.
//

import Foundation
var devMode = false
var outsideTesting = false
var printZombieThoughts = false
//var campStats = true
struct ResourcePoolData : Codable & Identifiable {
    var id = UUID()
    //Resources
    var foodStored : Int = 10
    var survivorNumber : Int = 3
    var starving = false
    
    //Sent Variables
    var survivorSent : Int = 0
    //Game Condition
    var hasViewedTutorial = false
    var AlreadyWon = false
    var shouldResetGame = false
    var death = false
    var victory = false
    //Victory Conditions
    var WinCondition = devMode ? 6 : 30
    var lastTappedIndex: Int?
    var selectStatuses : [Bool] = Array(repeating: false, count: 3)
    var progressToDeath : Int = 0
    var WinProgress = 0
    var days = 0
    init(resourcePool : ResourcePool){
        
        self.foodStored = resourcePool.foodStored
        self.survivorNumber = resourcePool.survivorNumber
        self.starving = resourcePool.starving
        self.survivorSent = resourcePool.survivorSent
        self.AlreadyWon = resourcePool.AlreadyWon
        self.shouldResetGame = resourcePool.shouldResetGame
        self.death = resourcePool.death
        self.victory = resourcePool.victory
        self.WinCondition = resourcePool.WinCondition
        self.progressToDeath = resourcePool.progressToDeath
        self.WinProgress = resourcePool.WinProgress
        self.days = resourcePool.days
        self.hasViewedTutorial = resourcePool.hasViewedTutorial
        self.selectStatuses = resourcePool.selectStatuses
    }
    init(){
        
    }
    init(foodStored: Int, survivorNumber: Int, starving: Bool = false, survivorSent: Int, AlreadyWon: Bool = false, shouldResetGame: Bool = false, death: Bool = false, victory: Bool = false, WinCondition: Int = 30, progressToDeath: Int, WinProgress: Int = 0, days: Int = 0) {
        self.foodStored = foodStored
        self.survivorNumber = survivorNumber
        self.starving = starving
        self.survivorSent = survivorSent
        self.AlreadyWon = AlreadyWon
        self.shouldResetGame = shouldResetGame
        self.death = death
        self.victory = victory
        self.WinCondition = WinCondition
        self.progressToDeath = progressToDeath
        self.WinProgress = WinProgress
        self.days = days
        self.selectStatuses = Array(repeating: false, count: survivorNumber)
    }
    
}


class ResourcePool : ObservableObject {
    //Resources
    @Published var foodStored : Int = 10
    @Published var survivorNumber : Int = 3
    @Published var survivorDefaultNumber : Int = 3
    @Published var starving = false
    //    @Published var roster = [any Piece]()//unused
    //Sent Variables
    @Published var survivorSent : Int = 0
    //Game Condition
    @Published var AlreadyWon = false
    @Published var shouldResetGame = false
    @Published var hasViewedTutorial = false
    @Published var death = false
    @Published var victory = false
    @Published var isInMission = false
    //Victory Conditions
    @Published var deathRequirement : Int = 3 /// AMOUNT OF DAYS PLAYER HAS TO GET FOOD IF THEY
    @Published var WinCondition = 30
    @Published var progressToDeath : Int = 0
    @Published var WinProgress = 0
    
    //Setting
    @Published var switchToLeft = false
    @Published var visionAssist = false
    @Published var lastTappedIndex: Int?
    
    
    //UI
    @Published var selectStatuses : [Bool] = Array(repeating: false, count: 3)
    let starvationAmount = 0
    
    @Published var days = 0
    init() {
        foodStored = 0
        survivorNumber = 3
        //selectStatuses = Array(repeating: false, count: 3)
    }
    
    init(surviors : Int, food : Int) {
        foodStored = food
        survivorNumber = surviors
        //print("Intializing : Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        
    }
    func setValue(resourcePoolData: ResourcePoolData){
        self.foodStored = resourcePoolData.foodStored
        self.survivorNumber = resourcePoolData.survivorNumber
        self.starving = resourcePoolData.starving
        self.survivorSent = resourcePoolData.survivorSent
        self.AlreadyWon = resourcePoolData.AlreadyWon
        self.shouldResetGame = resourcePoolData.shouldResetGame
        self.death = resourcePoolData.death
        self.victory = resourcePoolData.victory
        self.WinCondition = resourcePoolData.WinCondition
        self.progressToDeath = resourcePoolData.progressToDeath
        self.WinProgress = resourcePoolData.WinProgress
        self.days = resourcePoolData.days
    }
    
    /// Resets game
    func reset() {
        
        victoryPlayer?.stop()
        foodStored = 10
        survivorNumber = survivorDefaultNumber
        starving = false
        //        roster = generateSurvivors(survivorNumber)
        
        survivorSent = 0
        
        death = false
        victory = false
        AlreadyWon = false
        shouldResetGame = false
        WinProgress = 0
        progressToDeath = 0
        victoryPlayer?.stop()
        defeatPlayer?.stop()
        days = 0
    }
    func toggleLeftHandMode(){
        switchToLeft.toggle()
    }
    func toggleAssistMode(){
        visionAssist.toggle()
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
            //            musicPlayer?.stop()
            //            victoryPlayer?.play()
            defeatPlayer?.play()
            musicPlayer?.stop()
        }
    }
    func calcWinProgress(){
        print("Making cure with \(survivorNumber-survivorSent) survivors")
        if survivorSent != survivorNumber {
            WinProgress+=(survivorNumber-survivorSent)
            print("Checking for Cure Results -> Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        }
        if WinProgress >= WinCondition && AlreadyWon == false {
            musicPlayer?.stop()
            victoryPlayer?.play()
            musicPlayer?.stop()
            victory = true
            //AlreadyWon = true
            print("No longer making cure : Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        }
    }
    
    func passDay(){
        print("Food \(foodStored)")
        days+=1
        print("Survivors sent \(survivorSent)")
        foodStored-=survivorNumber
        calcWinProgress()
        print("Passing Day Results - Day : \(days)\nFood : \(foodStored) \nSurvivors : \(survivorNumber) \nCure Progress : \(WinProgress) \nDeath Progress : \(progressToDeath)")
        checkForDefeat()
    }
    func transferResourcesToResourcePool(vm : Board){
        print("Adding -> Food : \(foodStored)")
        foodStored += vm.foodNew
        print("Result -> Food : \(foodStored)")
        
        survivorNumber+=vm.UnitsRecruited
        
        survivorSent = 0
        
        
        print("Subtracting Deaths -> Survivors : \(survivorNumber)")
        survivorNumber-=vm.UnitsDied
        print("Result -> Survivors : \(survivorNumber)")
        
        print("Saving Data -> Food : \(foodStored) Survivors : \(survivorNumber) Cure Progress : \(WinProgress) Death Progress : \(progressToDeath)")
        isInMission = false
        print("is in mission = \(isInMission)")
        save(items: ResourcePoolData(resourcePool: self), key: key)
    }
    
    
    func balance(_ index : Int){
        
        if lastTappedIndex == index {
            // Tapped the same button twice, set all buttons to the left to false
            for i in 0...index {
                selectStatuses[i] = false
            }
            survivorSent = 0
            lastTappedIndex = nil
        } else {
            // Tapped a different button, update the selection
            survivorSent = index+1
            if switchToLeft {
                       for x in stride(from: selectStatuses.count - 1, through: 0, by: -1) {
                           if x >= survivorSent {
                               selectStatuses[x] = true
                           } else {
                               selectStatuses[x] = false
                           }
                       }
                   } else {
                       for x in 0..<selectStatuses.count {
                           if x <= survivorSent {
                               selectStatuses[x] = true
                           } else {
                               selectStatuses[x] = false
                           }
                       }
                   }
            lastTappedIndex = index
        }
    }

}
