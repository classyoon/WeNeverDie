//
//  PerTurn.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    // MARK: Not private

    func checkHPAndRefreshStamina(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col]?.health ?? 0 <= 0){
                    board[row][col] = nil; continue
                }
                if (board[row][col] != nil) {//If it encounters anything
                    board[row][col]?.movementCount = 0//Resets movement counter
                }
                
            }
        }
        
    }
    func nextTurn(){
        let zombies = createLists().zombieList; let players = createLists().unitList
        applyConcealment(players)
        moveZombies(zombies, unitList: players)
        checkHPAndRefreshStamina()
    }
}
