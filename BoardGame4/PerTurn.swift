//
//  PerTurn.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    // MARK: Not private

    func createLists()-> (zombieList : [any Piece], unitList: [Coord], zombieCoord : [Coord]) {
        var playerCoordPins = [Coord]()
        var ZomCoordPins = [Coord]()
        var zombies = [any Piece]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="S"||board[row][col]?.faction=="E")) {
                    playerCoordPins.append( Coord(row: row, col: col)); continue
                }
                if ((board[row][col]?.faction=="Z")) {
                    zombies.append(board[row][col] as! Zombie)
                    ZomCoordPins.append( Coord(row: row, col: col)); continue
                }
            }
        }
        return (zombies, playerCoordPins, ZomCoordPins)
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
    func checkEndMission(unitList: [Coord]){
        if unitList.isEmpty{
            print("END MISSION")
            print(survivorList)

        }
    }
    
    func nextTurn(){
        let lists = createLists()
        var zombies = lists.zombieList; let players = lists.unitList; let zombieLoc = lists.zombieCoord
        applyTileStatuses(players)
        moveZombies(zombies, unitList: players, zombieLoc: zombieLoc)
        checkHPAndRefreshStamina()
        checkEndMission(unitList: players)
        
    }
}
