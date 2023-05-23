//
//  Test.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import Foundation
class StockpileTest : ObservableObject, Codable {
    var foodStored : Int = 10
    var survivorNumber : Int = 3
    var buildingResources : Int = 0
    
    var survivorDefaultNumber : Int = 3
}
