//
//  BuildingManager.swift
//  BuildingThePain
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
///GOOD
class BuildingManager : ObservableObject {
    let labTemplate = AdvancementData(name: "Lab", workCost: 30, materialCost: 10, techBranch: [])
    let cureTemplate = BuildingData(name: "Cure", workCost: 20, isStartingBuild: false)
    let upgradeTemplate = BuildingData(name: "Upgrade", workCost: 50, isStartingBuild: false)
    let farmTemplate = ProducerData(name: "Farm", workCost: 1, materialCost : 0, rate: 3, produces: .food, rateIn : 1, consumes: .material)
    let houseTemplate = ProducerData(name: "Nursery", workCost: 20, rate: 1, produces: .people)
    let mineTemplate = ProducerData(name: "Mine", workCost: 10, rate: 3, produces: .material)
    
    static let shared = BuildingManager()
    private init() {
        self.cure = load(key: "cure") ?? cureTemplate
        self.upgrade = load(key: "upgrade") ?? upgradeTemplate
        self.advancementBuilding = load(key: "lab") ?? labTemplate
        
        self.farm = load(key: "farm") ?? farmTemplate
        self.house = load(key: "house") ?? houseTemplate
        self.mine = load(key: "mine") ?? mineTemplate
        self.buildings = [Building]()
        self.advancementBuilding.techBranch.append(cure)
        self.advancementBuilding.techBranch.append(upgrade)
        
        buildings.append(ResourceProducer(extraModel: mine))
        buildings.append(AdvancementBuilding(extraModel: advancementBuilding))
        buildings.append(ResourceProducer(extraModel: house))
        buildings.append(ResourceProducer(extraModel: farm))
        buildings.append(Building(model: cure))
        buildings.append(Building(model: upgrade))
    }
    
    @Published var stockpile : Stockpile = Stockpile.shared
    
    @Published var advancementBuilding : AdvancementData
    @Published var farm : ProducerData
    @Published var mine : ProducerData
    @Published var house : ProducerData
    
    @Published var cure : BuildingData
    @Published var upgrade : BuildingData
    @Published var allBuildingAreMaintained : Bool = true
    @Published var isABuildingCompleted : Bool = false
    @Published var buildings : [Building]
    var withdrawWorkersWhenBuildingIsCompleted: Bool = true
    
    func returnAllWorkers(from building : Building){
        Stockpile.shared.stockpileData.builders -= building.workers
        building.workers = 0
        building.autoWithDrawed = true
    }
    
    func updateWorkProgress() {
        isABuildingCompleted = false
        allBuildingAreMaintained = true
        for building in buildings {
            building.updateBuilding()
            if building.model.shouldNotify &&  !building.model.hasNotified {
                isABuildingCompleted = true
                building.model.hasNotified = true
                building.model.shouldNotify = false
            }
            
            if building.isComplete {
                if building.autoWithDrawed == false && withdrawWorkersWhenBuildingIsCompleted {
                    returnAllWorkers(from: building)
                }
                
                utilizeBuilding(building)
            }
            if let advancementBuilding = building as? AdvancementBuilding {
                switch building.name {
                case "Lab" :
                    save(items: AdvancementData(buildAdvance: advancementBuilding), key: "lab")
                default :
                    break
                }
            }
            if let resourceProducer = building as? ResourceProducer {
                print("Detected : \(resourceProducer.workProgress)")
                switch building.name {
                case "Mine" :
                    save(items: ProducerData(Producer: resourceProducer), key: "mine")
                case "Farm" :
                    save(items: ProducerData(Producer: resourceProducer), key: "farm")
                case "Nursery" :
                    save(items: ProducerData(Producer: resourceProducer), key: "house")
                default :
                    break
                }
            }
            else {
                switch building.name {
                case "Cure" :
                    save(items : BuildingData(buildData: building), key: "cure")
                case "Upgrade" :
                    save(items : BuildingData(buildData: building), key: "upgrade")
                default :
                    break
                }
            }
        }
        
        
        // saveAll()
    }
    func getProjectedOutputOf(_ name : String)->Int{
        for building in buildings {
            if let resourceProducer = building as? ResourceProducer {
                if resourceProducer.name == name {
                    return resourceProducer.output
                }
            }
        }
        return -1
    }
    func getProjectedInputOf(_ name : String)->Int{
        for building in buildings {
            
            if building.name == name {
                return building.input
            }
            
        }
        return -1
    }
    func getStatusOf(_ name : String)->Bool{
        for building in buildings {
            
            if building.name == name {
                if building.isComplete {
                    return true
                }
                else {
                    return false
                }
            }
            
        }
        return false
    }
    func utilizeBuilding(_ building : Building){
        runMantainance(building)
        if buildingMaintained() {
            if let advancementBuilding = building as? AdvancementBuilding, !advancementBuilding.hasGiven {
                activateAdvancement(advancementBuilding)
            }
            if let resourceProducer = building as? ResourceProducer {
                runProductionBuildings(resourceProducer)
            }
        }
    }
    
    
    func activateAdvancement(_ advancementBuilding : AdvancementBuilding){
        advancementBuilding.hasGiven = true
        //let newBuildings = advancementBuilding.extraModel.techBranch.map { Building(model: $0) }
        returnAllWorkers(from: advancementBuilding)
        for unlockedBuilding in advancementBuilding.techBranch  {
            for building in buildings {
                if building.name == unlockedBuilding.name {
                    building.isActive = true
                }
            }
        }
        //        buildings.append(contentsOf: newBuildings)
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
        case .nothing :
            break
        }
    }
    func runMantainance(_ building : Building){
        switch building.consumes {
        case .nothing :
            break
        case .food:
            Stockpile.shared.stockpileData.foodStored -= building.input
        case .material:
            Stockpile.shared.stockpileData.buildingResources -= building.input
        case .people:
            Stockpile.shared.stockpileData.survivorNumber -= building.input
        }
        print("Input \(building.input)")
    }
    func buildingMaintained()->Bool{
        if Stockpile.shared.getNumOfFood() >= 0 &&  Stockpile.shared.getNumOfMat() >= 0 &&  Stockpile.shared.getNumOfPeople() >= 0{
            print("Building maintained")
            return true
        }
        else if Stockpile.shared.getNumOfFood() < 0 {
            Stockpile.shared.stockpileData.foodStored = 0
            print("Building not maintained")
            allBuildingAreMaintained = false
        }
        else if Stockpile.shared.getNumOfMat() < 0 {
            Stockpile.shared.stockpileData.buildingResources = 0
            print("Building not maintained")
            allBuildingAreMaintained = false
        }
        else if Stockpile.shared.getNumOfPeople() < 0 {
            Stockpile.shared.stockpileData.survivorNumber = 0
            print("Building not maintained")
            allBuildingAreMaintained = false
        }
        allBuildingAreMaintained = false
        return false
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
    
    func reset(){
        self.cure = load(key: "cure") ?? cureTemplate
        self.upgrade = load(key: "upgrade") ?? upgradeTemplate
        self.advancementBuilding = load(key: "lab") ?? labTemplate
        self.farm = load(key: "farm") ?? farmTemplate
        self.house = load(key: "house") ?? houseTemplate
        self.mine = load(key: "mine") ?? mineTemplate
        self.buildings = [Building]()
        
        self.advancementBuilding.techBranch.append(cure)
        self.advancementBuilding.techBranch.append(upgrade)
        
        buildings.append(ResourceProducer(extraModel: mine))
        buildings.append(AdvancementBuilding(extraModel: advancementBuilding))
        buildings.append(ResourceProducer(extraModel: farm))
        buildings.append(Building(model: cure))
        buildings.append(Building(model: upgrade))
        buildings.append(ResourceProducer(extraModel: house))
        
        isABuildingCompleted = false
        allBuildingAreMaintained = true
        for building in buildings {
            building.constructionStarted = false
            if !building.isStartingBuild {
                building.isActive = false
            }
            building.workProgress = 0
            building.workers = 0
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


