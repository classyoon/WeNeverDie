//
//  PerTurn.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
 
    func createLists()-> (zombieList : [any Piece], playerCoords: [Coord], zombieCoord : [Coord]) {
        var playerCoordPins = [Coord]()
        var ZomCoordPins = [Coord]()
        var zombies = [any Piece]()
        var playerPieces = [any Piece]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if let piece = board[row][col] {
                    if piece.isPlayerUnit {
                        playerCoordPins.append( Coord(row: row, col: col))
                        playerPieces.append(piece)
                    }
                    if piece.isZombie {
                        zombies.append(piece as! Zombie)
                        ZomCoordPins.append( Coord(row: row, col: col)); continue
                    }
                }
            }
        }
        return (zombies, playerCoordPins, ZomCoordPins)
    }

    
    func checkHPAndRefreshStamina(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                
                if let piece = board[row][col] {
                    if piece.health <= 0 {
                        if piece.isPlayerUnit{
                            UnitsDied+=1
                            checkEndMission()
                            print("Units died \(UnitsDied)")
                        }
                        board[row][col] = nil
                    }
                    board[row][col]?.movementCount = 0//Resets movement counter
                }
                
            }
        }
    }
    func transferSurvivorsToCamp()->[any Piece]{
        return survivorList
    }
    func checkEndMission2(){
//        if numOfUnits == UnitsDied {
//            missionUnderWay = false
//            
//        }
    }
    func checkEndMission(playerCoords: [Coord]? = nil){
        let playerCoords  = playerCoords ?? createLists().playerCoords
        
        if playerCoords.isEmpty{
//            print("END MISSION")
//            print(survivorList)
            missionUnderWay = false
            return
        }
        else if playerCoords.count == 1{
            let lastSurvivor = playerCoords[0]
            if terrainBoard[lastSurvivor.row][lastSurvivor.col].name=="X"{//Exit
                if let survivorOnCoord = board[lastSurvivor.row][lastSurvivor.col] {
                    survivorList.append(survivorOnCoord)
                    board[lastSurvivor.row][lastSurvivor.col]=nil
                    if survivorOnCoord.id  == selectedUnit?.id {
                        selectedUnit = nil
                    }
                }
                print("END MISSION")
             
//                print(survivorList)
                missionUnderWay = false
            }
        }
        else{
            for survivor in playerCoords {
                if terrainBoard[survivor.row][survivor.col].name=="X"{//Exit
                    if let survivorOnCoord = board[survivor.row][survivor.col] {
                        survivorList.append(survivorOnCoord)
                        board[survivor.row][survivor.col]=nil
                        if survivorOnCoord.id  == selectedUnit?.id {
                            selectedUnit = nil
                        }
                    }
                }
            }
        }
    }
    func updateDayLightStatus(_ zombieNumber : Int){
        if turnsSinceStart > turnsOfDaylight && turnsSinceStart < lengthOfPlay {
            changeToNight = true
            if zombieNumber < 10 {
                spawnZombies(1)
            }
        } else if turnsSinceStart > lengthOfPlay {
            missionUnderWay = false
        }
    }
    func nextTurn(){
 
        turnsSinceStart += 1
        let lists = createLists()
        let zombies = lists.zombieList; let players = lists.playerCoords; let zombieLoc = lists.zombieCoord
        updateDayLightStatus(zombies.count)
        applyTileStatuses(players)
        moveZombies(zombies, playerCoords: players, zombieLoc: zombieLoc)
        checkHPAndRefreshStamina()
        deselectUnit()
        //checkEndMission()
        
    }
}
