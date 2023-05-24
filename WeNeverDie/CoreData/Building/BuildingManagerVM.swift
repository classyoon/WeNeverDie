//
//  BuildingManagerVM.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import Foundation

class BuildingManagerVM : ObservableObject {
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
    init(){
        self.advancementBuilding = load(key: "lab") ?? AdvancementData(name: "Lab", workCost: 20, materialCost: 10, techBranch: [BuildingData( name: "Cure", workCost: 50), BuildingData(name: "Upgrade", workCost: 10)])
        self.farm = load(key: "farm") ?? ProducerData(name: "Farm", workCost: 10, rate: 3, produces: .food)
        self.mine = load(key: "mine") ?? ProducerData(name: "Homes", workCost: 20, rate: 1, produces: .people)
        self.house = load(key: "house") ?? ProducerData(name: "Mine", workCost: 5, rate: 3, produces: .material)
    }
    
    
}
