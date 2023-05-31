//
//  AdvancementData.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
struct AdvancementData : Codable, Identifiable {
    var id = UUID()
    var name: String
    var workers: Int
    var workProgress: Int
    var workCost: Int
    var autoWithDrawed: Bool
    var materialCost: Int
    var constructionStarted: Bool
    var techBranch : [BuildingData]
    var hasGiven : Bool
    init(name: String, workers: Int=0, workProgress: Int=0, workCost: Int, autoWithDrawed: Bool=false, materialCost: Int=0, constructionStarted: Bool=false, techBranch : [BuildingData], hasGiven : Bool = false) {
        self.id = UUID()
        self.name = name
        self.workers = workers
        self.workProgress = workProgress
        self.workCost = workCost
        self.autoWithDrawed = autoWithDrawed
        self.materialCost = materialCost
        self.constructionStarted = constructionStarted
        self.techBranch = techBranch
        self.hasGiven = hasGiven
        
    }
    init(buildAdvance : AdvancementBuilding) {
        self.id = UUID()
        self.name = buildAdvance.name
        self.workers = buildAdvance.workers
        self.workProgress = buildAdvance.workProgress
        self.workCost = buildAdvance.workCost
        self.autoWithDrawed = buildAdvance.autoWithDrawed
        self.materialCost = buildAdvance.materialCost
        self.constructionStarted = buildAdvance.constructionStarted
        self.techBranch = buildAdvance.techBranch
        self.hasGiven = buildAdvance.hasGiven
        
    }
    
}
