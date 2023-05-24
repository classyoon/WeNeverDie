//
//  BuildingManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class BuildingManager : ObservableObject {
    var stock: Stockpile
    @Published var advancementBuilding : AdvancementData {
        didSet {
            // Save function.
            save(items: advancementBuilding, key: "lab")
        }
    }
    @Published var farm : ProducerData {
        didSet {
            // Save function.
            save(items: farm, key: "farm")
        }
    }
    @Published var mine : ProducerData {
        didSet {
            // Save function.
            save(items: mine, key: "mine")
        }
    }
    @Published var house : ProducerData {
        didSet {
            // Save function.
            save(items: house, key: "house")
        }
    }
    @Published var buildings : [Building]
        
        
        init(stock: Stockpile) {
            self.stock = stock
            self.advancementBuilding = load(key: "lab") ?? AdvancementData(name: "Lab", workCost: 20, materialCost: 10, techBranch: [BuildingData( name: "Cure", workCost: 50), BuildingData(name: "Upgrade", workCost: 10)])
            self.farm = load(key: "farm") ?? ProducerData(name: "Farm", workCost: 10, rate: 3, produces: .food)
            self.mine = load(key: "mine") ?? ProducerData(name: "Homes", workCost: 20, rate: 1, produces: .people)
            self.house = load(key: "house") ?? ProducerData(name: "Mine", workCost: 5, rate: 3, produces: .material)
            self.buildings = [Building]()
//            buildings.append(Building(advancement: advancementBuilding))
//            buildings.append(Building(producer: farm))
            buildings.append(Building(producer: mine))
//            buildings.append(Building(producer: house))
        }
        var withdrawWorkersWhenBuildingIsCompleted: Bool = false
        
        func createList(){
            buildings.append(Building(advancement: advancementBuilding))
            buildings.append(Building(producer: farm))
            buildings.append(Building(producer: mine))
            buildings.append(Building(producer: house))
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
            let result = assignedWorkers < stock.getNumOfPeople()-stock.getSurvivorSent()
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
        //    var buildings: [BuildingProtocol] = [
        //        AdvancementData(name: "Lab", workCost: 20, materialCost: 10, techBranch: [BuildingData( name: "Cure", workCost: 50), BuildingData(name: "Upgrade", workCost: 10)]),
        //        ProducerData(name: "Farm", workCost: 10, rate: 3, produces: .food),
        //        ProducerData(name: "Homes", workCost: 20, rate: 1, produces: .people),
        //        ProducerData(name: "Mine", workCost: 5, rate: 3, produces: .material)
        //    ]
        
        var withdrawWorkersWhenBuildingIsCompleted: Bool
        
        init(withdrawWorkersWhenBuildingIsCompleted: Bool = true) {
            self.withdrawWorkersWhenBuildingIsCompleted = withdrawWorkersWhenBuildingIsCompleted
        }
    }
    
    /*
     BuildingManager needs stockpile to initialize and buildingManagerModel
     */
