//
//  BuildingManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/5/23.
//

import Foundation
class BuildingManager : ObservableObject {
    @Published var buildingProjects = [Building(name: "Mine", matCost: 10, cost: 30), Building(name: "Farm", matCost: 5, cost: 20), Building(name: "Upgrade", matCost: 3, cost: 10), Building(name: "Lab", matCost: 10, cost: 30)]
    @Published var unavailibleProjects = [Building(name: "Cure", cost: 30, prerequisite: "Lab")]
    @Published var requestedResources = 0
    @Published var observedIndex = 0
    func refundResources(){
        let currentProject = buildingProjects[observedIndex]
        if currentProject.progress < currentProject.cost {
            requestedResources = 0
        }
    }
    func selectProject(index : Int){
        var currentProject = buildingProjects[observedIndex]
        if index != observedIndex {
            currentProject = buildingProjects[index]
            observedIndex = index
            requestedResources+=currentProject.matCost
            refundResources()
        }
    }
    func addBuildingWithPrerequisite(_ prerequisite: String) {
        for possible in unavailibleProjects {
            if !buildingProjects.contains(possible) && prerequisite == possible.prerequisite{
                buildingProjects.append(possible)
            }
            
        }
    }
}
