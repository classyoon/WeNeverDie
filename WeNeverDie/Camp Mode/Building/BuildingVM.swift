//
//  BuildingVM.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import Foundation
import SwiftUI
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
            return "Building a \(building.name) | Progress : \(building.workProgress) / \(building.workCost)"
        }
    }
    func startConstructionButton(for building: Building, buildMan: BuildingManager, stockpile : Stockpile) -> some View {
        Group {
            if !building.constructionStarted && stockpile.getNumOfMat() >= building.materialCost{
                Button("Start Construction") {
                    building.constructionStarted = true
                    buildMan.assignWorker(to: building)
                    stockpile.stockpileData.buildingResources -= building.materialCost
                }
            } else if !building.constructionStarted{
                Text("Not enough resources, Need \(building.materialCost)")
            }
        }
    }
    
    func workerButtons(for building: Building, buildMan: BuildingManager) -> some View {
        Group {
            if building.constructionStarted && (buildMan.canAssignWorker(to: building) || building.workers > 0) {
                HStack {
                    Button("Stop Working") {
                        building.workers = 0
                    }
                    Button("-") {
                        buildMan.removeWorker(from: building)
                    }
                    Button("+") {
                        buildMan.assignWorker(to: building)
                    }
                }
            }
        }
    }
    
    
    func buildingButtons(for building: Building, buildMan: BuildingManager, stock : Stockpile) -> some View {
        Group {
            if building.isComplete && building is AdvancementBuilding {
                //Text("Researcher Jobs not implemented yet")
            } else {
                //Text(workerText(for: building))
                startConstructionButton(for: building, buildMan: buildMan, stockpile: stock)
                workerButtons(for: building, buildMan: buildMan)
            }
        }
    }
}
