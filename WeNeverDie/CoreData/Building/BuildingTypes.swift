//
//  BuildingTypes.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
enum ResourceType : Codable {
    case food, material, people
}
class ResourceProducer: Building {
    var extraModel: ProducerData

    var output: Int {
        get { extraModel.output }
        set { extraModel.output = newValue }
    }

    var rate: Int {
        get { extraModel.rate }
        set { extraModel.rate = newValue }
    }

    var produces: ResourceType {
        get { extraModel.produces }
        set { extraModel.produces = newValue }
    }

    override func doSomething() {
        output = rate * workers
    }

    init(model : BuildingData, extraModel : ProducerData) {
        self.extraModel = extraModel
        super.init(model: model)
    }
}
struct ProducerData : Codable, BuildingProtocol {
    var name: String
    var workers: Int
    var workProgress: Int
    var workCost: Int
    var autoWithDrawed: Bool
    var materialCost: Int
    var constructionStarted: Bool
    var rate : Int
    var output = 0
    var produces : ResourceType
}



class AdvancementBuilding: Building {
    var extraModel: AdvancementData

    var techBranch: [BuildingData] {
        get { extraModel.techBranch }
        set { extraModel.techBranch = newValue }
    }

    var hasGiven: Bool {
        get { extraModel.hasGiven }
        set { extraModel.hasGiven = newValue }
    }

    override func doSomething() {
        hasGiven = true
        techBranch = []
    }

    init(model : BuildingData, extraModel : AdvancementData) {
        self.extraModel = extraModel
        super.init(model: model)
    }
}


struct AdvancementData : Codable, BuildingProtocol {
    var name: String
    var workers: Int
    var workProgress: Int
    var workCost: Int
    var autoWithDrawed: Bool
    var materialCost: Int
    var constructionStarted: Bool
    var techBranch : [BuildingData]
    var hasGiven : Bool
}


