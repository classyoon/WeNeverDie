//
//  building.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

import Foundation

struct Building : Identifiable, Equatable, Codable{
    var id = UUID()
    
    var name : String
    var cost : Int//Cost for building to function
    var progress : Int = 0//Progress on it
    var matCost : Int = 0
    var survivorsWorking : Int = 0//Number of people working
    var isFunctional = false
    let prerequisite: String?
    
    init(name: String, cost: Int) {
        self.name = name
        self.cost = cost
        self.prerequisite = nil
    }
    init(name: String, cost: Int, prerequisite: String) {
        self.name = name
        self.cost = cost
        self.prerequisite = prerequisite
    }
    init(name: String, matCost: Int, cost: Int) {
        self.name = name
        self.matCost = matCost
        self.cost = cost
        self.prerequisite = nil
    }
    init(name: String, matCost: Int, cost: Int, prerequisite: String? = nil) {
        self.name = name
        self.matCost = matCost
        self.prerequisite = prerequisite
        self.cost = cost
    }

}
