//
//  BuildingManager.swift
//  BuildingThePain
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
///GOOD
class BuildingManager : ObservableObject {
    @Published var stockpile : Stockpile = Stockpile.shared
    
    @Published var advancementBuilding : AdvancementData
    @Published var farm : ProducerData
    @Published var mine : ProducerData
    @Published var house : ProducerData
    
    @Published var cure : BuildingData
    @Published var upgrade : BuildingData
    
    @Published var buildings : [Building]
    init() {
        self.cure = load(key: "cure") ?? BuildingData(name: "Cure", workCost: 20)
        self.upgrade = load(key: "upgrade") ?? BuildingData(name: "Upgrade", workCost: 50)
        self.advancementBuilding = load(key: "lab") ?? AdvancementData(name: "Lab", workCost: 20, materialCost: 10, techBranch: [])
        self.farm = load(key: "farm") ?? ProducerData(name: "Farm", workCost: 10, materialCost : 10, rate: 3, produces: .food)
        self.house = load(key: "house") ?? ProducerData(name: "House", workCost: 20, rate: 1, produces: .people)
        self.mine = load(key: "mine") ?? ProducerData(name: "Mine", workCost: 10, rate: 3, produces: .material)
        self.buildings = [Building]()
        self.advancementBuilding.techBranch.append(cure)
        self.advancementBuilding.techBranch.append(upgrade)
        buildings.append(ResourceProducer(extraModel: mine))
        buildings.append(AdvancementBuilding(extraModel: advancementBuilding))
        buildings.append(ResourceProducer(extraModel: farm))
    }
    var withdrawWorkersWhenBuildingIsCompleted: Bool = true
    
    func returnAllWorkers(from building : Building){
        Stockpile.shared.stockpileData.builders -= building.workers
        building.workers = 0
        building.autoWithDrawed = true
    }
    
    func updateWorkProgress() {
        for building in buildings {
            building.updateBuilding()
            if building.isComplete {
                if building.autoWithDrawed == false && withdrawWorkersWhenBuildingIsCompleted {
                    returnAllWorkers(from: building)
                }
                
                utilizeBuilding(building)
            }
        }
    }
    func saveAll(){
        save(items: farm, key: "farm")
        save(items: mine, key: "mine")
        save(items: house, key: "house")
        save(items: cure, key: "cure")
        save(items: upgrade, key: "upgrade")
    }
    func utilizeBuilding(_ building : Building){
        
        if let advancementBuilding = building as? AdvancementBuilding, !advancementBuilding.hasGiven {
            activateAdvancement(advancementBuilding)
        }
        if let resourceProducer = building as? ResourceProducer {
            runProductionBuildings(resourceProducer)
        }
    }
    
    
    func activateAdvancement(_ advancementBuilding : AdvancementBuilding){
        advancementBuilding.hasGiven = true
        let newBuildings = advancementBuilding.extraModel.techBranch.map { Building(model: $0) }
        buildings.append(contentsOf: newBuildings)
    }
    func runProductionBuildings(_ resourceProducer : ResourceProducer){
        switch resourceProducer.produces {
        case .food:
            Stockpile.shared.stockpileData.foodStored += resourceProducer.output
            print(stockpile)
            print("\(resourceProducer.output)")
        case .material:
            Stockpile.shared.stockpileData.buildingResources += resourceProducer.output
            print(stockpile)
            print("\(resourceProducer.output)")
        case .people:
            Stockpile.shared.stockpileData.survivorNumber += resourceProducer.output
        }
    }
    func canAssignWorker(to building: Building) -> Bool {
        let assignedWorkers = buildings.reduce(0) { $0 + $1.workers }
        print("\(assignedWorkers) are working")
        print("\(Stockpile.shared.getNumOfPeople()-Stockpile.shared.getSurvivorSent()) are not working")
        let result = assignedWorkers < Stockpile.shared.getNumOfPeople()-Stockpile.shared.getSurvivorSent()
        return result
    }
    
    func assignWorker(to building: Building) {
        if canAssignWorker(to: building) {
            building.increaseWorker()
            Stockpile.shared.stockpileData.builders+=1
        }
    }
    
    func removeWorker(from building: Building) {
        building.decreaseWorker()
        if Stockpile.shared.stockpileData.builders > 0 {
            Stockpile.shared.stockpileData.builders-=1
        }
    }
    
    func scrap(_ building: Building) {
        Stockpile.shared.stockpileData.builders-=building.workers
        building.workers = 0
        Stockpile.shared.stockpileData.buildingResources += building.materialCost
        building.workProgress = 0
        building.constructionStarted = false
    }
}


