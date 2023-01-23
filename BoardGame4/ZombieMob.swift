//
//  ZombieMob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    func findDistance(zombie : Zombie, targetList: [Coord])->(RowD : Int, ColD : Int, seekerCoord : Coord){//This properly locates the targets.
        var targetLoc = Coord(); let seekerLoc = getCoord(of: zombie) ?? Coord()
        var thingSighted = false
        var DRow : Int = 100; var DCol : Int = 100
        for target in 0..<targetList.count{
            if abs(targetList[target].row-seekerLoc.row) <= DRow && abs(targetList[target].col-seekerLoc.col) <= DCol && board[targetList[target].row][targetList[target].col]?.faction == "S" {
                targetLoc = targetList[target]
                DRow = abs(targetList[target].row-seekerLoc.row); DCol = abs(targetList[target].col-seekerLoc.col)
                thingSighted = true
            }
        }
        if thingSighted==false {
            targetLoc=seekerLoc
        }
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    
    
    
    func approachAndDamage(zombie : Zombie, targetList: [Coord])->Coord{
        let distance = findDistance(zombie: zombie, targetList: targetList)
        var returnCoord = distance.seekerCoord
        //Attacks Neighbor
        //        print("I scan from row \(safeNum(returnCoord.row-1)) \(safeNum(returnCoord.row+1))")
        //        print("I scan from col \(safeNum(returnCoord.col-1)) \(safeNum(returnCoord.col+1))")
        for r in safeNum(r: returnCoord.row-1)...safeNum(r: returnCoord.row+1) {//Checks if can attack
            for c in safeNum(c: returnCoord.col-1)...safeNum(c: returnCoord.col+1) {
                if (board[r][c]?.faction == "S"&&(!(r==returnCoord.row&&c==returnCoord.col))){ //print("I check \(r) \(c)")
                    board[r][c]?.health -= zombie.damage; //print("I am in range to attack.")
                    return returnCoord
                }
            }
        }
        //Where it goes
        var directionText = ""
        if distance.RowD > 0 {
            returnCoord.row+=1; directionText+="Down "
        }
        else if distance.RowD < 0 {
            returnCoord.row-=1; directionText+="Up "
        }
        if distance.ColD < 0 {
            returnCoord.col-=1; directionText+="Left"
        }
        else if distance.ColD > 0 {
            returnCoord.col+=1; directionText+="Right"
        }
        ///CAN UPDATE FACING BY READING DIRECTION TEXT THROUGH SWITCH CASE
        ////**
        ///Use rotation angle facing thingy.
        ///
        //Actual moving, where it provides the place where it wants to move to give to the function set()
        
        if (board[returnCoord.row][returnCoord.col]==nil){//Check if will collide
            board[distance.seekerCoord.row][distance.seekerCoord.col] = nil//Prevents self duplication
            //print("I go \(directionText). From \(distance.seekerCoord) I go to \(returnCoord)")

            return returnCoord
        }
        //Wandering
        let ranRow = safeNum(r: distance.seekerCoord.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: distance.seekerCoord.col+Int.random(in: -1...1))
        if board[ranRow][ranCol]==nil{//Check if will collide
            board[distance.seekerCoord.row][distance.seekerCoord.col] = nil //Prevents self duplication
            //print("wander from \(distance.seekerCoord) to (\(ranRow), \(ranCol))")
            return Coord(row: ranRow, col: ranCol)
        }
        else{
            //print("I remain at \(distance.seekerCoord)")
            return distance.seekerCoord
        }
    }
    func moveZombies(_ zombies : [Zombie], unitList: [Coord]){//Collects list of zombie
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            while zombies[currentZombie].getCanMove(){
                zombies[currentZombie].movementCount+=1; //print("I zombie number \(currentZombie+1) at stamina \(zombies[currentZombie].stamina-zombies[currentZombie].movementCount)")
                set(moveable: zombies[currentZombie], Coord:approachAndDamage(zombie: zombies[currentZombie], targetList: unitList))//SeekFor erases the duplicate zombie
            }
        }
    }
    
}
