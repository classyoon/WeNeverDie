//
//  PerTurn.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    // MARK: Not private

    func createLists()-> (zombieList : [Zombie], unitList: [Coord]) {
        var playerCoordPins = [Coord]()
        var zombies = [Zombie]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="S"||board[row][col]?.faction=="E")) {
                    playerCoordPins.append( Coord(row: row, col: col)); continue
                }
                if ((board[row][col]?.faction=="Z")) {
                    zombies.append(board[row][col] as! Zombie)
                }
            }
        }
        return (zombies, playerCoordPins)
    }
    
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
        var lists = createLists()
        let zombies = lists.zombieList; let players = lists.unitList
        applyConcealment(players)
        moveZombies(zombies, unitList: players)
        checkHPAndRefreshStamina()
    }
}
