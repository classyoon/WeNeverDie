//
//  BuildingManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class BuildingManager : ObservableObject, Codable {
    @Published var buildings = [AdvancementBuilding(name: "Lab", workCost: 20, techBranch: [Building( name: "Cure", workCost: 50), Building(name: "Upgrade", workCost: 10)], materialCost: 10), ResourceProducer(name: "Farm", workCost: 10, rate: 3, produces: .food), ResourceProducer(name: "Homes", workCost: 20, rate: 1, produces: .people), ResourceProducer(name: "Mine", workCost: 5, rate: 3, produces: .material)]
    var withdrawWorkersWhenBuildingIsCompleted: Bool = true
    var stock  : Stockpile = Stockpile()
    
    init(_ stock : Stockpile) {
        self.stock = stock
    }
    func addBuilding(building: Building) {
        buildings.append(building)
    }
    
    func updateWorkProgress() {
        for building in buildings {
            building.updateWorkProgress()
            
            if building.autoWithDrawed == false && withdrawWorkersWhenBuildingIsCompleted && building.workProgress >= building.workCost {
                building.workers = 0
            }
            if  building.workProgress >= building.workCost{
                building.autoWithDrawed = true
                
                
                if let advancementBuilding = building as? AdvancementBuilding, !advancementBuilding.hasGiven {
                    advancementBuilding.hasGiven = true
                    buildings.append(contentsOf: advancementBuilding.techBranch)
                } else if let resourceProducer = building as? ResourceProducer {
                    switch resourceProducer.produces {
                    case .food:
                        stock.foodStored += resourceProducer.output
                    case .material :
                        stock.buildingResources += resourceProducer.output
                    case .people :
                        stock.survivorNumber += resourceProducer.output
                    }
                }
            }
        }
        
    }
    
    func canAssignWorker(to building: Building) -> Bool {
        let assignedWorkers = buildings.reduce(0) { $0 + $1.workers }
        let result = assignedWorkers < stock.survivorNumber
        return result
    }
    
    func assignWorker(to building: Building) {
        if canAssignWorker(to: building) {
            building.increaseWorker()
        }
    }
    
    func removeWorker(from building: Building) {
        building.decreaseWorker()
    }
    func scrap(_ building : Building){
        building.workers = 0
        stock.buildingResources+=building.materialCost
        building.workProgress = 0
    }
    
}
