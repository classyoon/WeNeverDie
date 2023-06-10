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
        self.stockpileData = load(key: "stocks") ?? StockpileModel()
    }
    func reset(){
        stockpileData.reset()
    }
    func calcConsumption(){
        stockpileData.calcConsumption()
        save(items: stockpileData, key: "stocks")
    }
    
    func transferResourcesToResourcePool(vm : Board){
        stockpileData.foodStored += vm.foodNew
        stockpileData.survivorNumber+=vm.UnitsRecruited
        stockpileData.survivorNumber-=vm.UnitsDied
        stockpileData.survivorSent = 0
        stockpileData.buildingResources += vm.materialNew
        print(vm.UnitsRecruited)
            save(items: stockpileData, key: "stocks")
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
    func getBuilders()->Int{
        print(stockpileData.builders)
        return stockpileData.builders
    }
    func setSurvivorSent(_ survivors : Int){
    stockpileData.survivorSent = survivors
    }
    func setBuilders(_ survivors : Int){
    stockpileData.builders = survivors
    }
    
}
struct StockpileModel : Codable, Identifiable {
    var id = UUID()
    var foodStored : Int = 0
    var survivorNumber : Int = 1
    var builders : Int = 0
    var buildingResources : Int = 0
    var survivorDefaultNumber : Int = 1
    var survivorSent : Int = 0
    var starving : Bool {
        return foodStored==0 ? true : false
    }
    var unemployed : Int {
        survivorNumber-builders-survivorSent
    }
    
    mutating func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 0
        buildingResources = 0
        survivorSent = 0
        builders = 0
        
    }
    mutating func calcConsumption(){
        if foodStored-survivorNumber > 0{
            foodStored -= survivorNumber
            print("Is starving = \(starving)")
        }
        else {
            foodStored = 0
            print("Is starving = \(starving)")
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

