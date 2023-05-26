//
//  Stockpile.swift
//  BuildingThePain
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
//
//  StockpileManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//CHECK

import Foundation
class Stockpile : ObservableObject {
    @Published var stockpileData : StockpileModel
    var survivorDefaultNumber : Int = 3
    static let shared = Stockpile()
    private init() {
        self.stockpileData = StockpileModel()
    }
    init(_ stock : StockpileModel) {
        self.stockpileData = stock
    }
    func reset(){
        stockpileData.reset()
    }
    func calcConsumption(){
        stockpileData.calcConsumption()
    }
    
    func transferResourcesToResourcePool(vm : Board){
        stockpileData.foodStored += vm.foodNew
        stockpileData.survivorNumber+=vm.UnitsRecruited
        stockpileData.survivorNumber-=vm.UnitsDied
        stockpileData.survivorSent = 0
    }
    func runOutOfPeople()->Bool{
        return stockpileData.runOutOfPeople()
    }
    func getNumOfPeople()->Int{
        return stockpileData.survivorNumber
    }
    func getNumOfFood()->Int{
        return stockpileData.foodStored
    }
    func getNumOfMat()->Int{
        return stockpileData.buildingResources
    }
    func killOnePerson(){
        stockpileData.survivorNumber -= 1
    }
    func isStarving()->Bool{
        return stockpileData.starving
    }
    func getSurvivorSent()->Int{
        return stockpileData.survivorSent
    }
    func setSurvivorSent(_ survivors : Int){
    stockpileData.survivorSent = survivors
    }
}

struct StockpileModel : Codable, Identifiable {
    var id = UUID()
    var foodStored : Int = 3
    var survivorNumber : Int = 3
    var builders : Int = 0
    var buildingResources : Int = 10
    var survivorDefaultNumber : Int = 3
    var survivorSent : Int = 0
    var starving : Bool {
        foodStored<0 ? true : false
    }
    var unemployed : Int {
        survivorNumber-builders
    }
    mutating func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 10
        buildingResources = 10
        survivorSent = 0
        builders = 0
        buildingResources = 0
    }
    mutating func calcConsumption(){
        if foodStored > 0{
            foodStored -= survivorNumber
        }
        else {
            foodStored = 0
        }
        print("Eating")
        print(foodStored)
    }
    func runOutOfPeople()->Bool{
        if survivorNumber<=0 {
            return true
        }
        return false
    }
    
}

