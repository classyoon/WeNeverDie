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
    @Published var survivorNames = ["Steve", "Jobs"]
    func passDay(){
        foodResource-=survivorNumber
        survivorNumber = survivorNames.count
    }

    init() {
        foodResource = 0
        survivorNumber = 2
    }
}
