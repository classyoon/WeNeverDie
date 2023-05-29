//
//  ResourceProducer.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
enum ResourceType : Codable {
    case food, material, people
}
class ResourceProducer: Building {
   @Published var extraModel: ProducerData

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
