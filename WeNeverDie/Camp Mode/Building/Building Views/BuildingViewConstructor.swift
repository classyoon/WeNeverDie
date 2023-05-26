//
//  BuildingVM.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import Foundation
import SwiftUI
class BuildingViewConstructor {
    static let shared = BuildingViewConstructor()
    private init(){
        
    }
    let alertText = "Are you sure you want to scrap this building?"
    let alert2Text = "This will refund your resources."
    let confirmScrap = "Scrap"
    let startToBuild = "Start Construction"
    let stopConstruction = "Stop Working"
    let increaseWorkerButton = "+"
    let decreaseWorkerButton = "-"
    let workerTitle = "Workers"
    let builderTitle = "Builders"
    let insufficentResourcesText = "Not enough resources, Need"
    
    func workerText(for building: Building) -> String {
        if !building.isComplete {
            return "\(builderTitle): \(building.workers)"
        } else {
            return "\(workerTitle): \(building.workers)"
        }
    }
    
    
    func workCostText(for building: Building) -> String {
        if building.isComplete {
            return "\(building.name)"
        } else {
            return "Build a \(building.name) | Progress : \(building.workProgress) / \(building.workCost)"
        }
    }
    func startConstructionButton(for building: Building, buildMan: BuildingManager, stockpile : Stockpile) -> some View {
        Group {
            if checkBuildRequirements(for: building, stockpile: stockpile){
                Button(startToBuild) {
                    building.constructionStarted = true
                    buildMan.assignWorker(to: building)
                    stockpile.stockpileData.buildingResources -= building.materialCost
                }
            } else if !building.constructionStarted{
                Text(giveInsufficent(for:building.materialCost))
            }
        }
    }
    func giveInsufficent(for cost : Int)->String{
        return "\(insufficentResourcesText) \(cost)"
        
    }
    func checkBuildRequirements(for building : Building, stockpile : Stockpile)->Bool{
        return !building.constructionStarted && stockpile.getNumOfMat() >= building.materialCost
    }
    func deductCost(of building : Building, from stockpile : Stockpile){
        stockpile.stockpileData.buildingResources -= building.materialCost
    }
    
    func workerButtons(for building: Building, buildMan: BuildingManager) -> some View {
        Group {
            if shouldShowInterface(of: building, using: buildMan) {
                HStack {
                    Button(stopConstruction) {
                        Stockpile.shared.stockpileData.builders -= building.workers
                        building.workers = 0
                    }
                    Button(decreaseWorkerButton) {
                        buildMan.removeWorker(from: building)
                    }
                    Button(increaseWorkerButton) {
                        buildMan.assignWorker(to: building)
                    }
                }
            }
        }
    }
    
    func shouldShowInterface(of building : Building, using buildMan : BuildingManager)->Bool{
        return building.constructionStarted || building.workers > 0
    }
    
    
    func buildingButtons(for building: Building, buildMan: BuildingManager, stock : Stockpile) -> some View {
        Group {
            if building.isComplete && building is AdvancementBuilding {
                Text("Researcher Jobs not implemented yet")
               
            } else {
    
                startConstructionButton(for: building, buildMan: buildMan, stockpile: stock)
                workerButtons(for: building, buildMan: buildMan)
            }
        }
    }
}
