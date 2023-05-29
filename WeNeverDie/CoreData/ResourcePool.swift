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
    @Published var gameConData : GameConditionModel = GameConditionModel()
    @Published var audio : AudioManager = AudioManager()
    var constructor : BuildingViewConstructor = BuildingViewConstructor.shared
    @Published var buildingMan : BuildingManager = BuildingManager()
    
    
    @Published var stockpileData : StockpileModel = StockpileModel()
    @Published var stockpile : Stockpile = Stockpile.shared
    @Published var gameCon : GameCondition = GameCondition.shared
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
        selectStatuses = Array(repeating: false, count: stockpile.getNumOfPeople()-stockpile.stockpileData.builders)
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
        buildingMan.updateWorkProgress()
        Stockpile.shared.calcConsumption()
        gameCon.checkForDefeat()
        if gameCon.getDeath() {
            audio.playMusic("Death")
        }
        checkCure()
    }
    func checkCure() {
        for building in buildingMan.buildings {
            if building.name == "Cure" && building.isComplete {
                gameCon.data.victory = true
                print("Won")
                audio.playMusic("Victory")
            }
            print(building.name)
        }
    }
    func transferResourcesToResourcePool(vm : Board){
        Stockpile.shared.transferResourcesToResourcePool(vm: vm)
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
    
            selectingSurvivors(index)
        
    }
    func selectingSurvivors(_ index: Int){
        
//        if selectStatuses.count-stockpile.getBuilders()<selectStatuses.count {
//            for i in selectStatuses.count-stockpile.getBuilders()...selectStatuses.count {
//                selectStatuses[i] = false
//            }
//        }
        if lastTappedIndex == index {
            // Tapped the same button twice set all buttons to false
            for i in 0...index {
                selectStatuses[i] = false
            }
            Stockpile.shared.setSurvivorSent(0)
            lastTappedIndex = nil
        } else {
            // Set the survivorSent value based on the index and switchToLeft flag
            if uiSetting.switchToLeft {
                Stockpile.shared.setSurvivorSent(selectStatuses.count - index)
            } else {
                Stockpile.shared.setSurvivorSent(index + 1)
            }
            
            // Set the selectStatuses array based on the survivorSent value
            for i in 0..<selectStatuses.count {
                selectStatuses[i] = (i < Stockpile.shared.getSurvivorSent())
            }
            lastTappedIndex = index
        }
    }
    func selectingBuilders(_ index: Int){
        if lastTappedIndex == index {
            // Tapped the same button twice set all buttons to false
            for i in 0...index {
                selectStatuses[i] = false
            }
            stockpile.setBuilders(0)
            lastTappedIndex = nil
        } else {
            // Set the survivorSent value based on the index and switchToLeft flag
            if uiSetting.switchToLeft {
                stockpile.setBuilders(selectStatuses.count - index)
            } else {
                stockpile.setBuilders(index + 1)
            }
            
            // Set the selectStatuses array based on the survivorSent value
            for i in 0..<selectStatuses.count {
                selectStatuses[i] = (i < stockpile.getBuilders())
            }
            lastTappedIndex = index
        }
    }

}
