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
    func percieveDistances(zombie : any Piece, targetList: [Coord])->(RowD : Int, ColD : Int, seekerCoord : Coord){//This properly locates the targets.
        var targetLoc = Coord(); let seekerLoc = getCoord(of: zombie) ?? Coord()
        var thingSighted = false
        var DRow : Int = 100; var DCol : Int = 100
        for target in 0..<targetList.count{
            if abs(targetList[target].row-seekerLoc.row) <= DRow && abs(targetList[target].col-seekerLoc.col) <= DCol && board[targetList[target].row][targetList[target].col]?.isHidden == false {
                
                targetLoc = targetList[target]
                DRow = abs(targetList[target].row-seekerLoc.row); DCol = abs(targetList[target].col-seekerLoc.col)
                thingSighted = true
                printZombieThoughts ? print("I see") : nil
            }
        }
        if thingSighted == false {
            targetLoc = seekerLoc
            printZombieThoughts ? print("I don't see") : nil
        }
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    

    func attackNearbyPiece(selfPiece : any Piece, selfLoc : Coord) ->Bool{
        for r in safeNum(r: selfLoc.row-1)...safeNum(r: selfLoc.row+1) {//Checks if can attack
            for c in safeNum(c: selfLoc.col-1)...safeNum(c: selfLoc.col+1) {
                if let nearbyPiece = board[r][c]{
                    if nearbyPiece.isPlayerUnit && nearbyPiece.isHidden == false { //print("I check \(r) \(c)")
                        board[r][c]?.health -= selfPiece.damage
                        audio.playSFX(.monsterNoises)
                        printZombieThoughts ? print(selfPiece.alert) : nil
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
    func calculateChaseInfo(_ RowD : Int, _ ColD : Int, selfLoc : Coord, zombie :  any Piece) -> (pursuitCoord : Coord, isChasing: Bool){
        var directionText = "" //Allows for debugging printing
        var targetLoc = selfLoc
        if RowD > 0 {
            targetLoc.row+=1; directionText+="Down "
        }
        else if RowD < 0 {
            targetLoc.row-=1; directionText+="Up "
        }
        if ColD < 0 {
            targetLoc.col-=1; directionText+="Left"
        }
        else if ColD > 0 {
            targetLoc.col+=1; directionText+="Right"
        }
        if !willCollide(zombie, targetLoc) {//Check if will collide
            print("I am moving \(directionText) to chase a target")
            return (targetLoc, true)
        }
        else{
            printZombieThoughts ? print("There is nothing to see or I have collided") : nil
            return (selfLoc, false)
        }
    }
   
    func willCollide(_ zombie : any Piece, _ desiredCoord : Coord) -> Bool{
        let moveCost = terrainBoard[desiredCoord.row][desiredCoord.col].movementPenalty
        if (board[desiredCoord.row][desiredCoord.col]==nil && zombie.movementCount+moveCost<=zombie.stamina){//Check if will collide
            return false
        }
        return true
    }
    func provideWanderingCoord(_ zombie : any Piece, _ selfCoord : Coord) -> Coord{
        //Wandering
        let ranRow = safeNum(r: selfCoord.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: selfCoord.col+Int.random(in: -1...1))
        if !willCollide(zombie, Coord(ranRow, ranCol)){//Check if will collide
            return Coord(row: ranRow, col: ranCol)
        }
        else{
            return selfCoord
        }
    }
    func runBehaviorOfAllZombies(_ zombies : [any Piece], playerCoords: [Coord], zombieLoc: [Coord]){//Collects list of zombie
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            executeZombieBehavior(zombie: &zombies[currentZombie], targetList: playerCoords)
           
        }
    }
    func executeZombieBehavior(zombie : inout any Piece, targetList: [Coord]){
        let percievedDistances = percieveDistances(zombie: zombie, targetList: targetList)
        let chaseInformation = calculateChaseInfo(percievedDistances.RowD, percievedDistances.ColD, selfLoc: percievedDistances.seekerCoord, zombie: zombie)
        
        if attackNearbyPiece(selfPiece: zombie, selfLoc: percievedDistances.seekerCoord) {
            print("Attack")
            zombie.alert = true
            board[percievedDistances.seekerCoord.row][percievedDistances.seekerCoord.col] = zombie
        }
        else if chaseInformation.isChasing{
            print("Chase")
            zombie.alert = true
            move(&zombie, from: percievedDistances.seekerCoord, to: chaseInformation.pursuitCoord)
        }
        else{
            print("Wander")
            zombie.alert = false
            board[percievedDistances.seekerCoord.row][percievedDistances.seekerCoord.col] = zombie
            move(&zombie, from: percievedDistances.seekerCoord, to: provideWanderingCoord(zombie, percievedDistances.seekerCoord))
         
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
