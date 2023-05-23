//
//  BuildingTypes.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
enum ResourceType {
    case food, material, people
}
class ResourceProducer: Building {
    var output = 0
    var rate: Int
    var produces : ResourceType
    
    override func doSomething() {
        output = rate * workers
    }
    
    init(name: String, workCost: Int, rate: Int, produces : ResourceType) {
        self.rate = rate
        self.produces = produces
        super.init(name: name, workCost: workCost)
    }
}

class AdvancementBuilding: Building {
    var techBranch = [Building]()
    var hasGiven = false
  
    override func doSomething() {
        hasGiven = true
        techBranch = []
    }
    
    init(name: String, workCost : Int, techBranch: [Building], materialCost : Int) {
        self.techBranch = techBranch
        super.init( name: name, workCost: workCost, materialCost: materialCost)
    }
}


