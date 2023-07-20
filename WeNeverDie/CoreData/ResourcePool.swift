//
//  ResourcePool.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/19/23.
//

import Foundation
var devMode = false
var outsideTesting = true
var printZombieThoughts = false
var autoShowTutorial = false
//var campStats = true
class ResourcePool : ObservableObject {
    @Published var gameConData : GameConditionModel = GameConditionModel()
    @Published var audio : AudioManager = AudioManager()
    var constructor : BuildingViewConstructor = BuildingViewConstructor.shared
    @Published var buildingMan : BuildingManager = BuildingManager.shared
    
    
    @Published var stockpileData : StockpileModel = StockpileModel()
    @Published var stockpile : Stockpile = Stockpile.shared
    @Published var gameCon : GameCondition = GameCondition.shared
    @Published var isInMission = false
    
    
    @Published var lastTappedIndex: Int?
    @Published var displayOfSelectedIcons : [Bool] = Array(repeating: false, count: 3)
    @Published var uiSetting = UserSettingsManager()
    @Published var days = 0
    
    @Published var displayInfo  = true
    @Published var viewedPiece = Stockpile.shared.getRandomPerson()
    
    func setValue(resourcePoolData: ResourcePoolData) {
        self.days = resourcePoolData.days
        self.displayOfSelectedIcons = resourcePoolData.displayOfSelectedIcons
        self.stockpileData = resourcePoolData.stockpileData
        self.gameConData = resourcePoolData.gameConData
    }
    
    func reset() {
        Stockpile.shared.reset()
        BuildingManager.shared.reset()
        displayOfSelectedIcons = Array(repeating: false, count: stockpile.getNumOfPeople())
        
        GameCondition.shared.reset()
        audio.playMusic("Kurt")
        days = 0
    }
    
    func generateMap() -> Board{
        
        return Board(players: Stockpile.shared.getSurvivorSent(), audio, uiSetting)
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
        save(items: ResourcePoolData(resourcePool: self), key: key)
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
        displayOfSelectedIcons = Array(repeating: false, count: stockpile.getNumOfPeople())
        isInMission = false
        save(items: ResourcePoolData(resourcePool: self), key: key)
    }
    func hardmodeReset(){
        reset()
        Stockpile.shared.stockpileData.foodStored = 0
        Stockpile.shared.stockpileData.survivorNumber = 1
        displayOfSelectedIcons = Array(repeating: false, count: 1)
    }
    
    func getSurvivorsSelcted()->[playerUnit]{
        var returningList = [playerUnit]()
        for survivor in  Stockpile.shared.stockpileData.rosterOfSurvivors  {
            if survivor.isBeingSent {
                returningList.append(survivor)
                print(survivor.name)
            }
        }
        return returningList
    }
    func deselectAll(){
        for i in 0...displayOfSelectedIcons.count-1 {
            displayOfSelectedIcons[i] = false
            // print(displayOfSelectedIcons.count-1)
            Stockpile.shared.stockpileData.rosterOfSurvivors[i].isBeingSent = false
        }
        Stockpile.shared.setSurvivorSent(0)
        lastTappedIndex = nil
    }
    func getUnselected()->[playerUnit]{
        var returningList = [playerUnit]()
        for survivor in  Stockpile.shared.stockpileData.rosterOfSurvivors  {
            if !survivor.isBeingSent {
                returningList.append(survivor)
            }
        }
        return returningList
    }
    func selectRangeOfSurvivors(leftMostIndex : Int = 0, rightMostIndex : Int = Stockpile.shared.stockpileData.rosterOfSurvivors.count-1){
        var count = 0
        for survivor in leftMostIndex...rightMostIndex{
            Stockpile.shared.stockpileData.rosterOfSurvivors[survivor].isBeingSent = true
            print(Stockpile.shared.stockpileData.rosterOfSurvivors[survivor].name)
            count += 1
        }
        Stockpile.shared.setSurvivorSent(count)
    }
    func balance(_ tapIndex: Int) {
        displayOfSelectedIcons = Array(repeating: false, count: Stockpile.shared.stockpileData.rosterOfSurvivors.count)
        if lastTappedIndex == tapIndex {
            deselectAll()
        } else {
            deselectAll()
            uiSetting.isUsingLeftHandedInterface ? selectRangeOfSurvivors(leftMostIndex: tapIndex) : selectRangeOfSurvivors(rightMostIndex: tapIndex)
            
            lastTappedIndex = tapIndex
        }
        
    }
    
    func getBiography(of selectedPerson: playerUnit) -> String {
        let title = "\(selectedPerson.childhood.lowercased()) \(selectedPerson.currentOccupation.lowercased())"
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        let article = vowels.contains(title.first ?? Character("")) ? "an" : "a"
        let scriptBasic = "\(selectedPerson.name)\n\nOverall, \(selectedPerson.firstName) could be called \(article) \(title)."
        return scriptBasic
    }
    func displayInfo(index : Int){
        viewedPiece = stockpile.getSurvivor(index: index)
        displayInfo = true
    }
    func getImageName(index : Int) ->String{
        uiSetting.isUsingLeftHandedInterface ?
        (index >= displayOfSelectedIcons.count -  stockpile.getSurvivorSent() ? "person.fill" : "person") :
        (index < stockpile.getSurvivorSent() ? "person.fill" : "person")
    }
}
