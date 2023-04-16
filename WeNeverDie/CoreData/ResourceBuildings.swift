//
//  ResourceBuildings.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/16/23.
//

import Foundation
struct ResourceBuilding {
    static let buildings = [
        Building(name: "Mine", matCost: 10, cost: 30),
        Building(name: "Farm", matCost: 5, cost: 20)
    ]
}

struct ResearchBuilding {
    static let buildings = [
        Building(name: "Lab", matCost: 10, cost: 30),
        Building(name: "Cure", cost: 30, prerequisite: "Lab")
    ]
}

struct UpgradeBuilding {
    static let buildings = [
        Building(name: "Upgrade", matCost: 3, cost: 10)
    ]
}
