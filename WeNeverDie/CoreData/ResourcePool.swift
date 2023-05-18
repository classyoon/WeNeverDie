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
  @Published var audio : AudioManager = AudioManager()
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
    @Published var lastTappedIndex: Int?
    
    
    //UI
    @Published var selectStatuses : [Bool] = Array(repeating: false, count: 3)
    let starvationAmount = 0
    @Published var uiSetting = UserSettingsManager()
    
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
        self.selectStatuses = resourcePoolData.selectStatuses
    }
    func generateMap() -> Board{
        return Board(players: survivorSent, audio, uiSetting)
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
        audio.resumeMusic()
        survivorNumber+=vm.UnitsRecruited
        
        survivorSent = 0
        print("Subtracting Deaths -> Survivors : \(survivorNumber)")
        survivorNumber-=vm.UnitsDied
        selectStatuses = Array(repeating: false, count: survivorNumber)
        print("Result -> Survivors : \(survivorNumber)")
        
        print("Saving Data -> Food : \(foodStored) Survivors : \(survivorNumber) Cure Progress : \(WinProgress) Death Progress : \(progressToDeath)")
        isInMission = false
        print("is in mission = \(isInMission)")
        save(items: ResourcePoolData(resourcePool: self), key: key)
    }
}

