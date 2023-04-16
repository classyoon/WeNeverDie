//
//  building.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

import Foundation

struct Building : Identifiable, Equatable{
    var id = UUID()
    
    var name : String
    var cost : Int//Cost for building to function
    var progress : Int = 0//Progress on it
    var matCost : Int
    var survivorsWorking : Int = 0//Number of people working
    var isFunctional = false
    
}
