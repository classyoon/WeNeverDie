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
        model.workProgress < model.workCost
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
        // implementation here
    }
    init(producer : ProducerData) {
        self.model = BuildingData(producer: producer)
    }
    init(advancement : AdvancementData) {
        self.model = BuildingData(advancement: advancement)
    }
}




