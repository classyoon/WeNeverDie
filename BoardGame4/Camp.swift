//
//  Camp.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
class Camp {
    @Published var SurvivorList : [any Piece] = []
    @Published var foodStored = 0
    init() {
        self.SurvivorList = []
        self.foodStored = 0
    }
    
    
}
