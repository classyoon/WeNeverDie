//
//  ZombieMob.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    ///
    /// This function locates the targets by checking the distances between the zombie and a list of possible targets. It returns the distance in terms of rows and columns along with the coordinates of the zombie.
    /// - Parameters:
    ///   - zombie: Seeker. Is an inout because alert is triggered here
    ///   - targetList: List of valid targets
    /// - Returns: The distance in row and column, and the location of the seeker
    func findDistance(zombie : inout any Piece, targetList: [Coord])->(RowD : Int, ColD : Int, seekerCoord : Coord){//This properly locates the targets.
        var targetLoc = Coord(); let seekerLoc = getCoord(of: zombie) ?? Coord()
        var thingSighted = false
        var DRow : Int = 100; var DCol : Int = 100
        for target in 0..<targetList.count{
            if abs(targetList[target].row-seekerLoc.row) <= DRow && abs(targetList[target].col-seekerLoc.col) <= DCol && board[targetList[target].row][targetList[target].col]?.isHidden == false {
                
                targetLoc = targetList[target]
                DRow = abs(targetList[target].row-seekerLoc.row); DCol = abs(targetList[target].col-seekerLoc.col)
                thingSighted = true
                zombie.alert = true
                printZombieThoughts ? print("I see") : nil
            }
        }
        if thingSighted == false {
            targetLoc = seekerLoc
            zombie.alert = false
            printZombieThoughts ? print("I don't see") : nil
            
        }
        
        // print("Target sighted = \(zombie.alert)")
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    
    /// This is the function that dictates whether the zombie attacks or not
    /// - Parameters:
    ///   - selfPiece: This is the piece, allowing us to modify whether the piece is alert or not.
    ///   - selfLoc: This is the piece's location on the board.
    /// - Returns: it returns whether it has attacked or not
    func attemptToAttack(selfPiece : inout any Piece, selfLoc : Coord) ->Bool{
        for r in safeNum(r: selfLoc.row-1)...safeNum(r: selfLoc.row+1) {//Checks if can attack
            for c in safeNum(c: selfLoc.col-1)...safeNum(c: selfLoc.col+1) {
                if let nearbyPiece = board[r][c]{
                    if nearbyPiece.isPlayerUnit && nearbyPiece.isHidden == false { //print("I check \(r) \(c)")
                        board[r][c]?.health -= selfPiece.damage //print("I am in range to attack.")
                        //zomSound?.prepareToPlay()
                        board[r][c]?.isStruck = true
                        soundPlayer?.play()
                        printZombieThoughts ? print(selfPiece.alert) : nil
                        selfPiece.alert = true
                        printZombieThoughts ? print("While attacking I see") : nil
                        printZombieThoughts ? print(selfPiece.alert) : nil
                        return true
                    }
                }
            }
        }
        return false
    }
    
    /// This behavior dictates the chase behavior
    /// - Parameters:
    ///   - RowD: Row distance from target
    ///   - ColD: Col distance from target
    ///   - selfLoc: This is the piece's location on the board.
    ///   - zombie: This is the piece, allowing us to modify whether the piece is alert or not
    /// - Returns: This returns a coord for the piece to possibly go to and it returns whether the piece is chasing or not.
    func returnChaseDirection(_ RowD : Int, _ ColD : Int, selfLoc : Coord, zombie : inout any Piece) -> (target : Coord, isChasing: Bool){
        var directionText = "" //Allows for debugging printing
        var targetLoc = selfLoc
        if RowD > 0 {
            targetLoc.row+=1; directionText+="Down "
            zombie.alert = true
            
        }
        else if RowD < 0 {
            targetLoc.row-=1; directionText+="Up "
            zombie.alert = true
        }
        if ColD < 0 {
            targetLoc.col-=1; directionText+="Left"
            zombie.alert = true
        }
        else if ColD > 0 {
            targetLoc.col+=1; directionText+="Right"
            zombie.alert = true
        }
        if !willCollide(zombie, targetLoc) && zombie.alert {//Check if will collide
            return (targetLoc, true)
        }
        else{
            zombie.alert = false
            printZombieThoughts ? print("There is nothing to see or I have collided") : nil
            return (selfLoc, false)
           
        }
    }
    func findBehaviorResultLocation(zombie : inout any Piece, targetList: [Coord])->Coord{
        let distance = findDistance(zombie: &zombie, targetList: targetList)
  
        if attemptToAttack(selfPiece: &zombie, selfLoc: distance.seekerCoord) {
            printZombieThoughts ? print(zombie.alert) : nil
            printZombieThoughts ? print("ATTACK") : nil

            zombie.alert = true
            printZombieThoughts ? print(zombie.alert) : nil
            return distance.seekerCoord
        }
        
        let chaseStatus = returnChaseDirection(distance.RowD, distance.ColD, selfLoc: distance.seekerCoord, zombie: &zombie)
        
        if chaseStatus.isChasing{
            printZombieThoughts ? print("I am chasing") : nil
            printZombieThoughts ? print(zombie.alert) : nil

            return chaseStatus.target
        }
        else{
            printZombieThoughts ? print(zombie.alert) : nil

            return wander(&zombie, distance.seekerCoord)
        }
            }
    func willCollide(_ zombie : any Piece, _ desiredCoord : Coord) -> Bool{
        let moveCost = terrainBoard[desiredCoord.row][desiredCoord.col].movementPenalty
        if (board[desiredCoord.row][desiredCoord.col]==nil && zombie.movementCount+moveCost<=zombie.stamina){//Check if will collide
            return false
        }
        return true
    }
    func wander(_ zombie : inout any Piece, _ selfCoord : Coord) -> Coord{
        //Wandering
        printZombieThoughts ? print("b/c I wander I don't see") : nil
        let ranRow = safeNum(r: selfCoord.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: selfCoord.col+Int.random(in: -1...1))
        if !willCollide(zombie, Coord(ranRow, ranCol)){//Check if will collide
            zombie.alert = false
            
            return Coord(row: ranRow, col: ranCol)
            
        }
        else{
            //print("I remain at \(distance.seekerCoord)")
            zombie.alert = false
            return selfCoord
        }
    }
    func moveZombies(_ zombies : [any Piece], playerCoords: [Coord], zombieLoc: [Coord]){//Collects list of zombie
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            move(&zombies[currentZombie], from: zombieLoc[currentZombie], to: findBehaviorResultLocation(zombie: &zombies[currentZombie], targetList: playerCoords))//We're basically asking it to move itself.  Then it decides how to move.
            
        }
    }
}

/**PROGRAMMED BY CHATGPT3
 This version maps the targetList to an array of tuples containing the row and column distances between each target and the current zombie. It then uses the min function to find the minimum total distance (rowD + colD) between the zombie and any of the targets. Finally, it returns the distance between the current zombie and the closest target, along with the current zombie's coordinates. If there are no targets in the targetList, it returns a distance of 0 and the current zombie's coordinates.
 */
//    func findDistance(zombie: inout any Piece, targetList: [Coord]) -> (RowD: Int, ColD: Int, seekerCoord: Coord) {
//        let seekerCoord = getCoord(of: zombie) ?? Coord()
//        let distanceList = targetList.map { targetCoord in
//            (abs(targetCoord.row - seekerCoord.row), abs(targetCoord.col - seekerCoord.col))
//        }
//        if let (minRowD, minColD) = distanceList.min(by: { $0.0 + $0.1 < $1.0 + $1.1 }) {
//            let targetIndex = distanceList.firstIndex(where: { $0.0 + $0.1 == minRowD + minColD })!
//            let targetCoord = targetList[targetIndex]
//            zombie.alert = true
//            return (targetCoord.row - seekerCoord.row, targetCoord.col - seekerCoord.col, seekerCoord)
//        } else {
//            zombie.alert = false
//            return (0, 0, seekerCoord)
//        }
//    }
