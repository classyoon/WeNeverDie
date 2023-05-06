//
//  ResourceCalculator.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/6/23.
//

import Foundation

class ResourceManager{
    @Published var foodStored : Int = 10
    @Published var survivorNumber : Int = 3
    @Published var resourcePts = 10
    func calcFoodConsumption(){
        foodStored-=survivorNumber
    }
    func transferResourcesToResourcePool(vm : Board){
        foodStored += vm.foodNew
        survivorNumber+=vm.UnitsRecruited
        survivorNumber-=vm.UnitsDied
    }
}

