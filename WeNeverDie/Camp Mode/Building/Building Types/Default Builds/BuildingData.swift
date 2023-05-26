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
    mutating func increaseWorker() {
        workers += 1
    }
    mutating func decreaseWorker() {
        if workers > 0 {
            workers -= 1
        }
    }
    mutating func build(){
        workProgress += workers
    }
    init(id: UUID = UUID(), name: String, workers: Int = 0, workProgress: Int = 0, autoWithDrawed: Bool = true, materialCost: Int = 0, constructionStarted: Bool = false, workCost: Int) {
        self.id = id
        self.name = name
        self.workers = workers
        self.workProgress = workProgress
        self.autoWithDrawed = autoWithDrawed
        self.materialCost = materialCost
        self.constructionStarted = constructionStarted
        self.workCost = workCost
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
    }
}
