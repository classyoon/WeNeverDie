//
//  StockpileManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class Stockpile : ObservableObject {
    @Published var stockpileData : StockpileModel
    var survivorDefaultNumber : Int = 3
  
    init() {
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
}

struct StockpileModel : Codable, Identifiable {
    var id = UUID()
    var foodStored : Int = 10
    var survivorNumber : Int = 3
    var buildingResources : Int = 0
    var survivorDefaultNumber : Int = 3
    var starving : Bool {
        foodStored<0 ? true : false
    }
    mutating func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 10
        buildingResources = 0
    }
    mutating func calcConsumption(){
        foodStored -= survivorNumber
    }
    func runOutOfPeople()->Bool{
        if survivorNumber<=0 {
            return true
        }
        return false
    }
    
}


