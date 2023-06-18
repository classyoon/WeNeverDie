//
//  BuildingData.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation

struct BuildingData : Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var workers: Int = 0
    var workProgress: Int = 0
    var autoWithDrawed : Bool = true

    var materialCost : Int = 0
    var constructionStarted : Bool = false
    var workCost: Int = 0

    var rateIn : Int = 0
    var input = 0
    var consumes : ResourceType = .nothing
    var isActive : Bool = false
    var isStartingBuild : Bool = false
    var hasNotified : Bool = false
    var shouldNotify : Bool = false
    mutating func increaseWorker() {
        workers += 1
    }
    mutating func decreaseWorker() {
        if workers > 0 {
            print("\(name) is decreasing workers")
            workers -= 1
        }
    }
    mutating func build(){
        workProgress += workers
        if workProgress>=workCost {
            shouldNotify = true
        }
    }
    init(id: UUID = UUID(), name: String, workers: Int = 0, workProgress: Int = 0, autoWithDrawed: Bool = true, materialCost: Int = 0, constructionStarted: Bool = false, workCost: Int, rateIn : Int = 0, input : Int = 0, consumes : ResourceType = .nothing, isActive : Bool = false, isStartingBuild : Bool = false,hasNotified : Bool = false, shouldNotify : Bool = false) {
        self.id = id
        self.name = name
        self.workers = workers
        self.workProgress = workProgress
        self.autoWithDrawed = autoWithDrawed
        self.materialCost = materialCost
        self.constructionStarted = constructionStarted
        self.workCost = workCost
        
        self.rateIn = rateIn
        self.input = input
        self.consumes = consumes
        
        self.isActive = isActive
        self.isStartingBuild = isStartingBuild
        self.hasNotified = hasNotified
    }
    init(buildData : Building) {
        self.name = buildData.name
        self.workers = buildData.workers
        self.workProgress = buildData.workProgress
        self.autoWithDrawed = buildData.autoWithDrawed
        self.materialCost = buildData.materialCost
        self.constructionStarted = buildData.constructionStarted
        self.workCost = buildData.workCost
        
        self.rateIn = buildData.rateIn
        self.input = buildData.input
        self.consumes = buildData.consumes
        
        self.isActive = buildData.isActive
        self.isStartingBuild = buildData.isStartingBuild
        self.hasNotified = buildData.hasNotified
        
    }
    init(advancement : AdvancementData) {
        self.id = advancement.id
        self.name = advancement.name
        self.workers = advancement.workers
        self.workProgress = advancement.workProgress
        self.autoWithDrawed = advancement.autoWithDrawed
        self.materialCost = advancement.materialCost
        self.constructionStarted = advancement.constructionStarted
        self.workCost = advancement.workCost
        
        self.rateIn = advancement.rateIn
        self.input = advancement.input
        self.consumes = advancement.consumes
        
        self.isActive = advancement.isActive
        self.isStartingBuild = advancement.isStartingBuild
        self.hasNotified = advancement.hasNotified
    }
    init(producer : ProducerData) {
        self.id = producer.id
        self.name = producer.name
        self.workers = producer.workers
        self.workProgress = producer.workProgress
        self.autoWithDrawed = producer.autoWithDrawed
        self.materialCost = producer.materialCost
        self.constructionStarted = producer.constructionStarted
        self.workCost = producer.workCost
        
        self.rateIn = producer.rateIn
        self.input = producer.input
        self.consumes = producer.consumes
        
        self.isActive = producer.isActive
        self.isStartingBuild = producer.isStartingBuild
        
        self.hasNotified = producer.hasNotified
    }
}
