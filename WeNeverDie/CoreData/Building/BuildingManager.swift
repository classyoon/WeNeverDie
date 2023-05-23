//
//  BuildingManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class BuildingManager : ObservableObject {
    @Published private(set) var model: BuildingManagerModel
    @Published var buildings : [Building]
    var stock: Stockpile

   init(model: BuildingManagerModel, stock: Stockpile) {
        self.model = model
        self.stock = stock
        self.buildings = model.buildings.map { Building(model: $0) }
    }
    var withdrawWorkersWhenBuildingIsCompleted: Bool {
        get { model.withdrawWorkersWhenBuildingIsCompleted }
        set { model.withdrawWorkersWhenBuildingIsCompleted = newValue }
    }

    func addBuilding(_ building: Building) {
        buildings.append(building)
    }

    func updateWorkProgress() {
        for building in buildings {
            building.updateWorkProgress()

            if building.autoWithDrawed == false && withdrawWorkersWhenBuildingIsCompleted && building.workProgress >= building.workCost {
                building.workers = 0
            }
            if building.workProgress >= building.workCost {
                building.autoWithDrawed = true

                if let advancementBuilding = building as? AdvancementBuilding, !advancementBuilding.hasGiven {
                    advancementBuilding.hasGiven = true
                    let newBuildings = advancementBuilding.extraModel.techBranch.map { Building(model: $0) }
                    buildings.append(contentsOf: newBuildings)
                }
 else if let resourceProducer = building as? ResourceProducer {
                    switch resourceProducer.produces {
                    case .food:
                        stock.stockpileData.foodStored += resourceProducer.output
                    case .material:
                        stock.stockpileData.buildingResources += resourceProducer.output
                    case .people:
                        stock.stockpileData.survivorNumber += resourceProducer.output
                    }
                }
            }
        }
    }

    func canAssignWorker(to building: Building) -> Bool {
        let assignedWorkers = buildings.reduce(0) { $0 + $1.workers }
        let result = assignedWorkers < stock.getNumOfPeople()
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

    func scrap(_ building: Building) {
        building.workers = 0
        stock.stockpileData.buildingResources += building.materialCost
        building.workProgress = 0
    }
    func reset(){
        
    }
}

struct BuildingManagerModel: Codable, Identifiable {
    var id = UUID()
    var buildings: [BuildingData] = [AdvancementData(name: "Lab", workCost: 20, techBranch: [BuildingData( name: "Cure", workCost: 50), BuildingData(name: "Upgrade", workCost: 10)], materialCost: 10), ProducerData(name: "Farm", workCost: 10, rate: 3, produces: .food), ProducerData(name: "Homes", workCost: 20, rate: 1, produces: .people), ProducerData(name: "Mine", workCost: 5, rate: 3, produces: .material)]
    var withdrawWorkersWhenBuildingIsCompleted: Bool

    init(buildings: [BuildingData] = [], withdrawWorkersWhenBuildingIsCompleted: Bool = true) {
        self.buildings = buildings.map { $0.model }
        self.withdrawWorkersWhenBuildingIsCompleted = withdrawWorkersWhenBuildingIsCompleted
    }
}

/*
 BuildingManager needs stockpile to initialize and buildingManagerModel
 */
