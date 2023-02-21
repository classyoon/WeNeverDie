//
//  ZombieMob.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
//    func findDistance(zombie : inout any Piece, targetList: [Coord])->(RowD : Int, ColD : Int, seekerCoord : Coord){//This properly locates the targets.
//        var targetLoc = Coord(); let seekerLoc = getCoord(of: zombie) ?? Coord()
//        var thingSighted = false
//        var DRow : Int = 100; var DCol : Int = 100
//        for target in 0..<targetList.count{
//            if abs(targetList[target].row-seekerLoc.row) <= DRow && abs(targetList[target].col-seekerLoc.col) <= DCol && board[targetList[target].row][targetList[target].col]?.faction == "S" {
//
//                targetLoc = targetList[target]
//                DRow = abs(targetList[target].row-seekerLoc.row); DCol = abs(targetList[target].col-seekerLoc.col)
//                thingSighted = true
//                zombie.alert = true
//
//            }
//        }
//        if thingSighted==false {
//            targetLoc=seekerLoc
//        }
//
//        print("Target sighted = \(zombie.alert)")
//        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
//    }
    /**PROGRAMMED BY CHATGPT3
     This version maps the targetList to an array of tuples containing the row and column distances between each target and the current zombie. It then uses the min function to find the minimum total distance (rowD + colD) between the zombie and any of the targets. Finally, it returns the distance between the current zombie and the closest target, along with the current zombie's coordinates. If there are no targets in the targetList, it returns a distance of 0 and the current zombie's coordinates.
     */
    func findDistance(zombie: inout any Piece, targetList: [Coord]) -> (RowD: Int, ColD: Int, seekerCoord: Coord) {
        let seekerCoord = getCoord(of: zombie) ?? Coord()
        let distanceList = targetList.map { targetCoord in
            (abs(targetCoord.row - seekerCoord.row), abs(targetCoord.col - seekerCoord.col))
        }
        if let (minRowD, minColD) = distanceList.min(by: { $0.0 + $0.1 < $1.0 + $1.1 }) {
            let targetIndex = distanceList.firstIndex(where: { $0.0 + $0.1 == minRowD + minColD })!
            let targetCoord = targetList[targetIndex]
            zombie.alert = true
            return (targetCoord.row - seekerCoord.row, targetCoord.col - seekerCoord.col, seekerCoord)
        } else {
            zombie.alert = false
            return (0, 0, seekerCoord)
        }
    }

    func chooseLocationAndDamage(zombie : inout any Piece, targetList: [Coord])->Coord{
        var distance = findDistance(zombie: &zombie, targetList: targetList)
        var returnCoord = distance.seekerCoord
        //Attacks Neighbor
        //        print("I scan from row \(safeNum(returnCoord.row-1)) \(safeNum(returnCoord.row+1))")
        //        print("I scan from col \(safeNum(returnCoord.col-1)) \(safeNum(returnCoord.col+1))")
        
        for r in safeNum(r: returnCoord.row-1)...safeNum(r: returnCoord.row+1) {//Checks if can attack
            for c in safeNum(c: returnCoord.col-1)...safeNum(c: returnCoord.col+1) {
                if let nearbyPiece = board[r][c]{
                    if nearbyPiece.isPlayerUnit && nearbyPiece.isHidden == false { //print("I check \(r) \(c)")
                        board[r][c]?.health -= zombie.damage; //print("I am in range to attack.")
                        return returnCoord
                    }
                }
            }
        }
        //Where it goes
        var directionText = "" //Allows for debugging printing
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

        var moveCost = terrainBoard[returnCoord.row][returnCoord.col].movementPenalty
        if (board[returnCoord.row][returnCoord.col]==nil && zombie.movementCount+moveCost<=zombie.stamina){//Check if will collide
            return returnCoord
        } 
        
        //Wandering
        let ranRow = safeNum(r: distance.seekerCoord.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: distance.seekerCoord.col+Int.random(in: -1...1))
        moveCost = terrainBoard[ranRow][ranRow].movementPenalty
        if board[ranRow][ranCol]==nil&&zombie.movementCount+moveCost<=zombie.stamina{//Check if will collide
            //print("wander from \(distance.seekerCoord) to (\(ranRow), \(ranCol))")
            return Coord(row: ranRow, col: ranCol)
        }
        else{
            //print("I remain at \(distance.seekerCoord)")
            return distance.seekerCoord
        }
    }
    func moveZombies(_ zombies : [any Piece], unitList: [Coord], zombieLoc: [Coord]){//Collects list of zombie
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            move(&zombies[currentZombie], from: zombieLoc[currentZombie], to: chooseLocationAndDamage(zombie: &zombies[currentZombie], targetList: unitList))
            
        }
    }
}
