//
//  StockpileManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class Stockpile : ObservableObject, Codable {
    @Published var foodStored : Int = 10
    @Published var survivorNumber : Int = 3
    @Published var buildingResources : Int = 0
    var starving : Bool {
        foodStored<0 ? true : false
    }
    var survivorDefaultNumber : Int = 3
    init(foodStored: Int, survivorNumber: Int, buildingResources: Int, survivorDefaultNumber: Int = 3) {
        self.foodStored = foodStored
        self.survivorNumber = survivorNumber
        self.buildingResources = buildingResources
        self.survivorDefaultNumber = survivorDefaultNumber
    }
    init() {
        self.foodStored = 10
        self.survivorNumber = 3
        self.buildingResources = 0
        self.survivorDefaultNumber = 3
    }
    func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 10
        buildingResources = 0
    }
    func calcConsumption(){
        foodStored -= survivorNumber
    }
    
    func transferResourcesToResourcePool(vm : Board){
        foodStored += vm.foodNew
        survivorNumber+=vm.UnitsRecruited
        survivorNumber-=vm.UnitsDied
    }
}

struct StockpileModel : Codable {
    var foodStored : Int = 10
    var survivorNumber : Int = 3
    var buildingResources : Int = 0
    var starving : Bool {
        foodStored<0 ? true : false
    }
    var survivorDefaultNumber : Int = 3
}

class Stockpile2 {
    @Published var data : StockpileModel = StockpileModel()
    func reset(){
        data.survivorNumber = data.survivorDefaultNumber
        data.foodStored = 10
        data.buildingResources = 0
    }
    func calcConsumption(){
        data.foodStored -= data.survivorNumber
    }
    
    func transferResourcesToResourcePool(board : Board){
        data.foodStored += board.foodNew
        data.survivorNumber+=board.UnitsRecruited
        data.survivorNumber-=board.UnitsDied
    }
}
