//
//  building.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//
import SwiftUI
import Foundation
class Building: ObservableObject {
    @Published var name: String
    @Published var workers: Int = 0
    @Published var workProgress: Int = 0
    @Published var autoWithDrawed = false
    @Published var materialCost = 0
    @Published var facility: String = ""
    @Published var constructionStarted = false
    var uniqueAbility: (() -> Void)?
    var workCost: Int
    var isComplete : Bool {
        workProgress>=workCost
    }
    
    init(name: String, workCost: Int,  materialCost : Int = 0) {
        self.workCost = workCost
        self.name = name
        self.materialCost = materialCost
    }
    
    func increaseWorker() {
        workers += 1
    }
    
    func decreaseWorker() {
        if workers > 0 {
            workers -= 1
        }
    }
    
    func updateWorkProgress() {
        if isComplete {
            doSomething()
        }
        else {
            workProgress += workers
        }
    }
    func doSomething(){
        
    }
}
class BuildingsViewModel : ObservableObject{
    func workerText(for building: Building) -> String {
        if building.workProgress >= building.workCost {
            return "Workers: \(building.workers)"
        } else {
            return "Builders: \(building.workers)"
        }
    }
    
    func workCostText(for building: Building) -> String {
        if building.workProgress >= building.workCost {
            return "\(building.name)"
        } else {
            return "Building [\(building.name)] | Progress : \(building.workProgress) / \(building.workCost)"
        }
    }
    func startConstructionButton(for building: Building, ResourcePool: ResourcePool) -> some View {
        Group {
            if !building.constructionStarted && ResourcePool.stockpile.getNumOfMat() >= building.materialCost{
                Button("Start Construction") {
                    building.constructionStarted = true
                    ResourcePool.buildingMan.assignWorker(to: building)
                    ResourcePool.stockpile.stockpileData.buildingResources -= building.materialCost
                }
            } else if !building.constructionStarted{
                Text("Not enough resources, Need \(building.materialCost)")
            }
        }
    }
    
    func workerButtons(for building: Building, ResourcePool: ResourcePool) -> some View {
        Group {
            if building.constructionStarted && (ResourcePool.buildingMan.canAssignWorker(to: building) || building.workers > 0) {
                HStack {
                    Button("Stop Working") {
                        building.workers = 0
                    }
                    Button("-") {
                        ResourcePool.buildingMan.removeWorker(from: building)
                    }
                    Button("+") {
                        ResourcePool.buildingMan.data.assignWorker(to: building)
                    }
                }
            }
        }
    }
    
    
    func buildingButtons(for building: Building, ResourcePool: ResourcePool) -> some View {
        Group {
            if building.isComplete && building is AdvancementBuilding {
                Text("Researcher Jobs not implemented yet")
            } else {
                Text(workerText(for: building))
                startConstructionButton(for: building, ResourcePool: ResourcePool)
                workerButtons(for: building, ResourcePool: ResourcePool)
            }
        }
    }
}
