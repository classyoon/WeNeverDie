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
}


struct BuildingData : Codable, BuildingProtocol {
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
}

protocol BuildingProtocol {
    var name: String { get set }
    var workers: Int { get set }
    var workProgress: Int { get set }
    var workCost: Int { get }
    var autoWithDrawed : Bool {get set}
    var materialCost : Int {get}
    var constructionStarted : Bool {get set}
}
