//
//  AdvancementBuilding.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
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
