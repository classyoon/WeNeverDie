//
//  NightResultsCalculator.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/13/23.
//

import Foundation
struct NightResult {
    var costOfSafeOption : Int
    var chanceOfFailure : Double
}
struct NightResultCalculator {
    var zombieCount : Int
    var results : NightResult {
        switch zombieCount {
            case 0...3:
            return NightResult(costOfSafeOption: 0, chanceOfFailure: 0.0)
            case 4...7:
            return NightResult(costOfSafeOption: 3, chanceOfFailure: 0.10)
            default:
            return NightResult(costOfSafeOption: 5, chanceOfFailure: 0.30)
        }
    }
}
