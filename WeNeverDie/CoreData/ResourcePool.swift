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
class ResourcePool : ObservableObject {
    @Published var buildVm : BuildingsViewModel = BuildingsViewModel()
    @Published var stockpileData : StockpileModel = StockpileModel()
    @Published var gameConData : GameConditionModel = GameConditionModel()
    @Published var buildData : BuildingManagerModel = BuildingManagerModel()
    @Published var audio : AudioManager = AudioManager()
    @Published var stockpile : Stockpile = Stockpile(StockpileModel())
    var buildingMan : BuildingManager {
        BuildingManager(stock: stockpile)
    }
    var gameCon : GameCondition {
        GameCondition(self.stockpile, data: gameConData)
    }
   
    @Published var isInMission = false
    
    
    @Published var lastTappedIndex: Int?
    @Published var selectStatuses : [Bool] = Array(repeating: false, count: 3)
    @Published var uiSetting = UserSettingsManager()
    @Published var days = 0
    
    init() {
        stockpileData = StockpileModel()
        stockpile = Stockpile(stockpileData)
    }
    
    func setValue(resourcePoolData: ResourcePoolData) {
        self.days = resourcePoolData.days
        self.selectStatuses = resourcePoolData.selectStatuses
        self.stockpileData = resourcePoolData.stockpileData
    }

    func reset() {
        stockpile.reset()
        selectStatuses = Array(repeating: false, count: stockpile.getNumOfPeople())
        gameCon.reset()
        audio.playMusic("Kurt")
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
            generatedRoster.append(playerUnit(name: fullName, board: Board(players: number, audio, uiSetting)))
        }
        return generatedRoster
    }
    func generateMap() -> Board{
        
        return Board(players: stockpile.getSurvivorSent(), audio, uiSetting)
    }
    
    func passDay(){
        days+=1
        stockpile.calcConsumption()
        gameCon.checkForDefeat()
    }
    
    func transferResourcesToResourcePool(vm : Board){
        stockpile.transferResourcesToResourcePool(vm: vm)
        audio.resumeMusic()
        selectStatuses = Array(repeating: false, count: stockpile.getNumOfPeople())
        isInMission = false
        save(items: ResourcePoolData(resourcePool: self), key: key)
    }
    func hardmodeReset(){
        reset()
        stockpile = Stockpile(StockpileModel(foodStored: 0, survivorNumber: 1))
        selectStatuses = Array(repeating: false, count: 1)
    }
    
    func balance(_ index: Int) {
        if lastTappedIndex == index {
            // Tapped the same button twice set all buttons to false
            for i in 0...index {
                selectStatuses[i] = false
            }
            stockpile.setSurvivorSent(0)
            lastTappedIndex = nil
        } else {
            // Set the survivorSent value based on the index and switchToLeft flag
            if uiSetting.switchToLeft {
                stockpile.setSurvivorSent(selectStatuses.count - index)
            } else {
                stockpile.setSurvivorSent(index + 1)
            }
            
            // Set the selectStatuses array based on the survivorSent value
            for i in 0..<selectStatuses.count {
                selectStatuses[i] = (i < stockpile.getSurvivorSent())
            }
            lastTappedIndex = index
        }
    }
}
