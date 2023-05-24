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

    init(extraModel : ProducerData) {
        self.extraModel = extraModel
        super.init(producer: extraModel)
    }
}
struct ProducerData : Codable, Identifiable {
    var id = UUID()
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
    
    init(name: String, workers: Int=0, workProgress: Int=0, workCost: Int, autoWithDrawed: Bool=true, materialCost: Int=0, constructionStarted: Bool=false, rate: Int, output: Int = 0, produces: ResourceType) {
        self.id = UUID()
        self.name = name
        self.workers = workers
        self.workProgress = workProgress
        self.workCost = workCost
        self.autoWithDrawed = autoWithDrawed
        self.materialCost = materialCost
        self.constructionStarted = constructionStarted
        self.rate = rate
        self.output = output
        self.produces = produces
    }
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

    init(extraModel : AdvancementData) {
        self.extraModel = extraModel
        super.init(advancement: extraModel)
    }
 
}


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
    init(name: String, workers: Int=0, workProgress: Int=0, workCost: Int, autoWithDrawed: Bool=true, materialCost: Int=0, constructionStarted: Bool=false, techBranch : [BuildingData], hasGiven : Bool = false) {
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
}


