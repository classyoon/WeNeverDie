//
//  ResourcePool.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/19/23.
//

import Foundation

class ResourcePool : ObservableObject {
    @Published var foodResource : Int
    @Published var survivorNumber : Int
    @Published var deathCountdown : Int = 1 /// AMOUNT OF DAYS PLAYER HAS TO GET FOOD IF THEY ARE STARVING, BEFORE THEY DIE
    @Published var progressToDeath : Int = 0
    @Published var starving = false
    @Published var death = false
    init(surviors : Int, food : Int) {
        foodResource = food
        survivorNumber = surviors
    }
    func passDay(){
        foodResource-=survivorNumber
        if foodResource>0 {
            starving = false
            if progressToDeath > 0{
               progressToDeath-=1
            }
        }
        if starving {
            progressToDeath+=1
        }
        else if foodResource<0{
            starving = true
        }
        if deathCountdown == progressToDeath {
            death = true
            print("Death")
        }
    }
}
