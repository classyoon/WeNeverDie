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
    
    var input: Int {
        get { model.input }
        set { model.input = newValue }
    }

    var rateIn: Int {
        get { model.rateIn }
        set { model.rateIn = newValue }
    }

    var consumes: ResourceType {
        get { model.consumes }
        set { model.consumes = newValue }
    }


    var isComplete: Bool {
        model.workProgress >= model.workCost
    }

    var isStartingBuild: Bool {
        get { model.isStartingBuild }
        set { model.isStartingBuild = newValue }
    }
    var isActive: Bool {
        get { model.isActive }
        set { model.isActive = newValue }
    }
    var hasNotified: Bool {
        get { model.hasNotified }
        set { model.hasNotified = newValue }
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

    func updateBuilding() {
        if isComplete {
            
            doSomething()
        } else {
            model.build()
        }
    }

    func doSomething() {
//        print("Did something, nothing")
    }
    init(producer : ProducerData) {
        self.model = BuildingData(producer: producer)
    }
    init(advancement : AdvancementData) {
        self.model = BuildingData(advancement: advancement)
    }
}




