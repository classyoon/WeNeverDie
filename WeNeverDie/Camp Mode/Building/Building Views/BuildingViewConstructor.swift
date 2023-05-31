//
//  BuildingVM.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import Foundation
import SwiftUI
class BuildingViewConstructor {
    var audio = AudioManager()
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
   var stockpile : Stockpile = Stockpile.shared
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
            return "\(building.name) (\(building.workProgress) / \(building.workCost)) <- "
        }
    }
    func startConstructionButton(for building: Building, buildMan: BuildingManager) -> some View {
        Group {
            if checkBuildRequirements(for: building){
                Button(startToBuild) {
                    building.constructionStarted = true
                    buildMan.assignWorker(to: building)
                    Stockpile.shared.stockpileData.buildingResources -= building.materialCost
                    self.audio.playSFX(.starting)
                    
                }.buttonStyle(.bordered)
            } else if !building.constructionStarted{
                Text(giveInsufficent(for:building.materialCost))
            }
        }
    }
    func giveInsufficent(for cost : Int)->String{
        return "\(insufficentResourcesText) \(cost)"
        
    }
    func checkBuildRequirements(for building : Building)->Bool{
        return !building.constructionStarted && Stockpile.shared.getNumOfMat() >= building.materialCost
    }
    func deductCost(of building : Building){
        Stockpile.shared.stockpileData.buildingResources -= building.materialCost
    }
    
    func workerButtons(for building: Building, buildMan: BuildingManager) -> some View {
        Group {
            if shouldShowInterface(of: building, using: buildMan) {
                HStack {
//                    Button(stopConstruction) {
//                        Stockpile.shared.stockpileData.builders -= building.workers
//                        building.workers = 0
//                    }
                    Button(decreaseWorkerButton) {
                        buildMan.removeWorker(from: building)
                    }.buttonStyle(.bordered)
                    Button(increaseWorkerButton) {
                        buildMan.assignWorker(to: building)
                    }.buttonStyle(.bordered)
                }
            }
        }
    }
    
    func shouldShowInterface(of building : Building, using buildMan : BuildingManager)->Bool{
        return building.constructionStarted || building.workers > 0
    }
    
    
    func buildingButtons(for building: Building, buildMan: BuildingManager) -> some View {
        Group {
            if building.name == "Upgrade" {
                Text("Feature not implemented yet.")
            }
            else if building.isComplete && building is AdvancementBuilding {
                Text("Feature Jobs not implemented yet")
               
            } else {
    
                startConstructionButton(for: building, buildMan: buildMan)
                workerButtons(for: building, buildMan: buildMan)
            }
        }
    }
}
