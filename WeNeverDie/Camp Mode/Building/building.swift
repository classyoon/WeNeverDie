//
//  building.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//
import Foundation
class Building: ObservableObject {
    @Published var model: BuildingData

    var name: String {
        get { model.name }
        set { model.name = newValue }
    }

    var workers: Int {
        get { model.workers }
        set { model.workers = newValue }
    }

    var workProgress: Int {
        get { model.workProgress }
        set { model.workProgress = newValue }
    }

    var autoWithDrawed: Bool {
        get { model.autoWithDrawed }
        set { model.autoWithDrawed = newValue }
    }

    var materialCost: Int {
        get { model.materialCost }
        set { model.materialCost = newValue }
    }

    var constructionStarted: Bool {
        get { model.constructionStarted }
        set { model.constructionStarted = newValue }
    }

    var workCost: Int {
        get { model.workCost }
        set { model.workCost = newValue }
    }

    var isComplete: Bool {
        model.workProgress >= model.workCost
    }

    init(model: BuildingData) {
        self.model = model
    }

    func increaseWorker() {
        model.increaseWorker()
    }

    func decreaseWorker() {
        model.decreaseWorker()
    }

    func updateWorkProgress() {
        if isComplete {
            doSomething()
        } else {
            model.build()
        }
    }

    func doSomething() {
        // implementation here
    }
    init(producer : ProducerData) {
        self.model = BuildingData(producer: producer)
    }
    init(advancement : AdvancementData) {
        self.model = BuildingData(advancement: advancement)
    }
}


struct BuildingData : Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var workers: Int = 0
    var workProgress: Int = 0
    var autoWithDrawed : Bool = true
    var materialCost : Int = 0
    var constructionStarted : Bool = true
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


