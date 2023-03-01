//
//  ZombieMob.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    func findDiffWithDesiredCoord(zombie : inout any Piece, targetList: [Coord])->(rowDifference  : Int, colDifference  : Int, selfLocation : Coord){//This properly locates the targets.
        var designatedTargetLocation = Coord(); let selfLocation = getCoord(of: zombie) ?? Coord()
        var rowDistance : Int = 100; var colDistance : Int = 100
        if targetList.isEmpty{
            designatedTargetLocation = selfLocation
            zombie.alert = false
        }
        else{
            for candidateLocation in 0..<targetList.count{
                if abs(targetList[candidateLocation].row-selfLocation.row) <= rowDistance && abs(targetList[candidateLocation].col-selfLocation.col) <= colDistance {
                    designatedTargetLocation = targetList[candidateLocation]
                    rowDistance = abs(targetList[candidateLocation].row-selfLocation.row); colDistance = abs(targetList[candidateLocation].col-selfLocation.col)
                    zombie.alert = true
                    
                }
            }
        }
        print("Target sighted = \(zombie.alert)")
        return (designatedTargetLocation.row-selfLocation.row, designatedTargetLocation.col-selfLocation.col, selfLocation)//returns the distance
    }
  
    func chooseLocationAndDamage(zombie : inout any Piece, targetList: [Coord])->Coord{
        let selfLocAndTargetCoordDifference = findDiffWithDesiredCoord(zombie: &zombie, targetList: targetList)
        var returnCoord = selfLocAndTargetCoordDifference.selfLocation
        //Attacks Neighbor
        //        print("I scan from row \(safeNum(returnCoord.row-1)) \(safeNum(returnCoord.row+1))")
        //        print("I scan from col \(safeNum(returnCoord.col-1)) \(safeNum(returnCoord.col+1))")
        
        for r in safeNum(r: returnCoord.row-1)...safeNum(r: returnCoord.row+1) {//Checks if can attack
            for c in safeNum(c: returnCoord.col-1)...safeNum(c: returnCoord.col+1) {
                if let nearbyPiece = board[r][c]{
                    if nearbyPiece.isPlayerUnit && nearbyPiece.isHidden == false { //print("I check \(r) \(c)")
                        board[r][c]?.health -= zombie.damage //print("I am in range to attack.")
                        //zomSound?.prepareToPlay()
                        zombie.alert = true

                        return returnCoord
                        
                    }
                }
            }
        }
        //Where it goes
        var directionText = "" //Allows for debugging printing
        if selfLocAndTargetCoordDifference.rowDifference  > 0 {
            returnCoord.row+=1; directionText+="Down "
            zombie.alert = true

        }
        else if selfLocAndTargetCoordDifference.rowDifference  < 0 {
            returnCoord.row-=1; directionText+="Up "
            zombie.alert = true
        }
        if selfLocAndTargetCoordDifference.colDifference  < 0 {
            returnCoord.col-=1; directionText+="Left"
            zombie.alert = true
        }
        else if selfLocAndTargetCoordDifference.colDifference  > 0 {
            returnCoord.col+=1; directionText+="Right"
            zombie.alert = true
        }

        var moveCost = terrainBoard[returnCoord.row][returnCoord.col].movementPenalty
        if (board[returnCoord.row][returnCoord.col]==nil && zombie.movementCount+moveCost<=zombie.stamina){//Check if will collide
            return returnCoord
        } 
        
        //Wandering
        let ranRow = safeNum(r: selfLocAndTargetCoordDifference.selfLocation.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: selfLocAndTargetCoordDifference.selfLocation.col+Int.random(in: -1...1))
        moveCost = terrainBoard[ranRow][ranRow].movementPenalty
        if board[ranRow][ranCol]==nil&&zombie.movementCount+moveCost<=zombie.stamina{//Check if will collide
            //print("wander from \(distance.selfLocation) to (\(ranRow), \(ranCol))")
            zombie.alert = false
            return Coord(row: ranRow, col: ranCol)
        }
        else{
            //print("I remain at \(distance.selfLocation)")
            zombie.alert = false
            return selfLocAndTargetCoordDifference.selfLocation
        }
    }
    func checkVisible(_ unitList: [Coord]) -> [Coord] {
        var local = [Coord]()
        for current in unitList {
            if board[current.row][current.col]?.isHidden == false {
                local.append(current)
            }
        }
        return local
    }
    func attack(_ zombieLoc : Coord, _ zombie : any Piece){
        for r in safeNum(r: zombieLoc.row-1)...safeNum(r: zombieLoc.row+1) {//Checks if can attack
            for c in safeNum(c: zombieLoc.col-1)...safeNum(c: zombieLoc.col+1) {
                if let nearbyPiece = board[r][c]{
                    if nearbyPiece.isPlayerUnit && nearbyPiece.isHidden == false {
                        board[r][c]?.health -= zombie.damage //print("I am in range to attack.")
                        //zomSound?.prepareToPlay()
                    }
                }
            }
        }
    }
    func chase(_ zombie : any Piece, _ zombieLoc : Coord, _ targetLocList : [Coord]){
    
    }
    
    func executeBehavior(_ zombie : any Piece, _ zombieLoc : Coord, _ targetLocList : [Coord]){
        
    }
    func moveZombies(_ zombies : [any Piece], unitList: [Coord], zombieLoc: [Coord]){//Collects list of zombie
        var validTargetList = checkVisible(unitList)
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            executeBehavior(zombies[currentZombie], zombieLoc[currentZombie], validTargetList)
            
            //move(&zombies[currentZombie], from: zombieLoc[currentZombie], to: chooseLocationAndDamage(zombie: &zombies[currentZombie], targetList: validTargetList))//We're basically asking it to move itself.  Then it decides how to move.
            
        }
    }
 
}

/**PROGRAMMED BY CHATGPT3
 This version maps the targetList to an array of tuples containing the row and column distances between each target and the current zombie. It then uses the min function to find the minimum total distance (rowD + colD) between the zombie and any of the targets. Finally, it returns the distance between the current zombie and the closest target, along with the current zombie's coordinates. If there are no targets in the targetList, it returns a distance of 0 and the current zombie's coordinates.
 */
//    func findDistance(zombie: inout any Piece, targetList: [Coord]) -> (rowDifference : Int, colDifference : Int, selfLocation: Coord) {
//        let selfLocation = getCoord(of: zombie) ?? Coord()
//        let distanceList = targetList.map { targetCoord in
//            (abs(targetCoord.row - selfLocation.row), abs(targetCoord.col - selfLocation.col))
//        }
//        if let (minRowD, minColD) = distanceList.min(by: { $0.0 + $0.1 < $1.0 + $1.1 }) {
//            let targetIndex = distanceList.firstIndex(where: { $0.0 + $0.1 == minRowD + minColD })!
//            let targetCoord = targetList[targetIndex]
//            zombie.alert = true
//            return (targetCoord.row - selfLocation.row, targetCoord.col - selfLocation.col, selfLocation)
//        } else {
//            zombie.alert = false
//            return (0, 0, selfLocation)
//        }
//    }
