//
//  PerTurn.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 1/16/23.
//

import Foundation
extension Board {
    //MARK: Runs through whole Board
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
        numberOfZombies = zombies.count
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
    
    //MARK: Unused Transfer Survivors
    func transferSurvivorsToCamp()->[any Piece]{
        return survivorList
    }
 
    //MARK: Check Endmission? Maybe not used?
    func checkEndMission(playerCoords: [Coord]? = nil){
        let playerCoords = playerCoords ?? createLists().playerCoords
        if playerCoords.isEmpty{
            missionUnderWay = false
            return
        }
        else if playerCoords.count == 1{
            let lastSurvivor = playerCoords[0]
            if terrainBoard[lastSurvivor.row][lastSurvivor.col].name=="X"{//Exit
                if let survivorOnCoord = board[lastSurvivor.row][lastSurvivor.col] {
                    survivorList.append(survivorOnCoord)
                    board[lastSurvivor.row][lastSurvivor.col]=nil
                    if survivorOnCoord.id == selectedUnit?.id {
                        selectedUnit = nil
                        canAnyoneMove = isAnyoneStillActive()
                        audio.playSFX(.vanDoor)
                    }
                }
                audio.playSFX(.carStarting)
                missionUnderWay = false
            }
        }
        else{
            for survivor in playerCoords {
                if terrainBoard[survivor.row][survivor.col].name=="X"{//Exit
                    if let survivorOnCoord = board[survivor.row][survivor.col] {
                        survivorList.append(survivorOnCoord)
                        board[survivor.row][survivor.col]=nil
                        canAnyoneMove = isAnyoneStillActive()
                        audio.playSFX(.vanDoor)
                        if survivorOnCoord.id == selectedUnit?.id {
                            selectedUnit = nil
                            canAnyoneMove = isAnyoneStillActive()
                            audio.playSFX(.vanDoor)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Daylight
    func updateDayLightStatus(_ zombieNumber : Int){
        if turnsSinceStart > turnsOfDaylight && turnsSinceStart < lengthOfPlay {
            changeToNight = true
            if zombieNumber < 10 {
                spawnZombies(2)
                //
                audio.playSFX(.longGrowl)
            }
        } else if turnsSinceStart > lengthOfPlay {
            showEscapeOption = true
            missionUnderWay = false
        }
    }
    //MARK: Next Turn
    func nextTurn(){
        //audio.playSFX(.next)
        turnsSinceStart += 1
        let lists = createLists()
        
        let zombies = lists.zombieList; let players = lists.playerCoords; let zombieLoc = lists.zombieCoord
        updateDayLightStatus(zombies.count)
        applyTileStatuses(players)
        runBehaviorOfAllZombies(zombies, playerCoords: players, zombieLoc: zombieLoc)
        checkHPAndRefreshStamina()
        deselectUnit()
        //checkEndMission()
        if createLists().playerCoords.count <= 0 {
            missionUnderWay = false
        }
        turn = UUID()
        
    }
}
