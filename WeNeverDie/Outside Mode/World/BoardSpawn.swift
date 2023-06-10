//
//  BoardSpawn.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 6/6/23.
//

import Foundation
extension Board {
    func spawnRecruit(_ number : Int){
        var counter = 0
        while counter < number {
            let loc = randomLoc()
            terrainBoard[loc.row][loc.col].name = "t"
            terrainBoard[loc.row][loc.col].setTileBonuses()
            set(moveable: recruit(board: self), Coord: loc)
            counter += 1
        }
    }
    func spawnPlayers(_ amount: Int) {
        var counter = 0
        var r = 0
        var c = 0
        
        while counter < amount {
            while r < safeNum(r: 3) {
                while c < safeNum(c: 3) {
                    
                    if counter >= amount {
                        break
                    }
                    var temp = playerUnit(name: namesSurvivors[counter], board: self)
                    temp.checkForUpgrade()
                    set(moveable: temp, Coord: Coord(r, c))
                    terrainBoard[r][c].name = "t"
                    terrainBoard[r][c].setTileBonuses()
                    counter += 1
                    c += 1
                    print("\(counter)")
                }
                // Reset the value of c to 0 after each row
                c = 0
                r += 1
            }
        }
    }
    func spawnZombies(_ amount : Int){
        var counter = 0
        while counter<amount{
            set(moveable: Zombie(board: self), Coord: randomLoc())
            counter+=1
        }
    }
    //    func randomLoc() -> Coord{
    //        print("Col Max : \(colMax), Row Max : \(rowMax)")
    //        var ranR = safeNum(r: Int.random(in: 0...rowMax-1))
    //        var ranC = safeNum(c: Int.random(in: 0...colMax-1))
    //        // print("checking \(ranR), \(ranC)")
    //        print("Random Col : \(ranC), Random Row : \(ranR)")
    //        while board[ranR][ranC] != nil || (ranR == rowMax-1 && ranC == colMax-1) {
    //            ranR = Int.random(in: 0...rowMax-1); ranC = Int.random(in: 0...colMax-1)
    //            print("IN LOOP : Random Col : \(ranC), Random Row : \(ranR)")
    //        }
    //        return Coord(row: ranR, col: ranC)
    //    }
    func randomLoc() -> Coord {
        guard rowMax > 0 && colMax > 0 else {
            fatalError("rowMax and colMax must be greater than 0")
        }
        var ranR = safeNum(r: Int.random(in: 0...rowMax-1))
        var ranC = safeNum(c: Int.random(in: 0...colMax-1))
        guard ranR >= 0 else{
            fatalError("Asked for row is below zero : \(ranR)")
        }
        guard ranC >= 0 else{
            fatalError("Asked for row is below zero : \(ranC)")
        }
  
        
        guard rowMax > ranR || colMax > ranC else {
            
            guard rowMax > ranR && colMax > ranC else {
                fatalError("Asked for numbers are too large : \(ranR) and \(ranC) are too big for \(rowMax) and \(colMax) ")
            }
            guard ranR < rowMax else{
                fatalError("Asked for row are is too large : \(ranR) / \(rowMax)")
            }
            guard ranC < colMax else {
                fatalError("Asked for col are is too large : \(ranC) / \(colMax)")
            }
            fatalError("Unknown index out of bounds : Asked for numbers are too large : \(ranR) and \(ranC) are too big for \(rowMax) and \(colMax)")
        }
        while board[ranR][ranC] != nil || (ranR == rowMax-1 && ranC == colMax-1) {
            ranR = Int.random(in: 0...rowMax-1)
            ranC = Int.random(in: 0...colMax-1)
            
            
            guard ranR >= 0 && ranR < board.count && ranC >= 0 && ranC < board[ranR].count else {
                fatalError("IN LOOP : Index out of bounds")
            }
        }
        
        return Coord(row: ranR, col: ranC)
    }
    
    
}
