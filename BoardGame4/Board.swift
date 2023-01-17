//
//  Board.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
// Modified by Conner Yoon

import Foundation



protocol BoardProtocol {
    var rowMax: Int { get }
    var colMax: Int { get }
    func getCoord(of moveable: any Moveable) -> Coord?
}

struct TileType {
    var name  = "g"
    var lootCount = 1

}
class Board : ObservableObject, BoardProtocol {
    @Published var terrainBoard: [[String]] = [["g"]]
//    @Published var terrainBoard2: [[(Terrain : String, Loot : Int)]] = [[("g", 1)]]
    @Published var terrain = [[TileType]]()
    @Published var ADVterrainBoard: [[(terrain : String, moveCost: Int, lootable : Int)]] = [[("g", 0, 1)]]
    @Published var SuperADVterrainBoard: [[(String, Int, Int, Double)]] = [[("g", 0, 1, 0.0)]]
    @Published var board: [[(any Piece)?]] = [[]]
    @Published var treeCoords = [Coord]()
    
    @Published var lootCoords = [Coord]()
    @Published var isTapped = false
    @Published var lootBoard = [[Int]]()
    @Published var selectedUnit : (any Piece)? = nil
    @Published var selectedUnitLoc :Coord? = nil
    
    @Published var hillCoords = [Coord]()
    @Published var blockerCoords = [Coord]()
    
    @Published var escapeCoord : Coord = Coord()
    @Published var survivorList = [King]()
    @Published var tappedLoc : Coord?{
        didSet{
            setPossibleCoords()
        }
    }
    
    @Published var possibleLoc: [Coord] = []
    let rowMax: Int = 10
    let colMax: Int = 10
    let houseLoot = 4
    
    func randomGenerateTerrain(trees : Int, houses : Int, _ escapePoint : Coord)->[[String]]{
        var tempTerrain = Array(repeating: Array(repeating: "g", count: rowMax), count: colMax)

        escapeCoord = escapePoint
        tempTerrain[escapePoint.row][escapePoint.col] = "X"
        var counter = 0
        while ((counter<trees)&&(counter<houses)){
            var Rrow = randomLoc().row
            var Rcol = randomLoc().col
            if counter<trees {
                if tempTerrain[Rrow][Rcol] == "g"{
                    tempTerrain[Rrow][Rcol] = "t"
                }
            }
        Rrow = randomLoc().row
        Rcol = randomLoc().col
            if counter<houses {
                if tempTerrain[Rrow][Rcol] == "g"{
                    tempTerrain[Rrow][Rcol] = "h"
                    lootBoard[Rrow][Rcol]+=houseLoot
                }
            }
            counter+=1
        }
        return tempTerrain
    }
 
    
    func randomLoc() -> Coord{
        var ranR = Int.random(in: 0...rowMax-1); var ranC = Int.random(in: 0...colMax-1)
        while board[ranR][ranC] != nil {
            ranR = Int.random(in: 0...rowMax-1); ranC = Int.random(in: 0...colMax-1)
        }
        return Coord(row: ranR, col: ranC)
    }

    func spawnZombies(_ amount : Int){
        var counter = 0
        while counter<amount{
            set(moveable: Zombie(board: self), Coord: randomLoc())
            counter+=1
        }
    }
    //    @Published private(set) var mobs: [(any Piece)?] = []
    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        lootBoard = Array(repeating: Array(repeating: 1, count: rowMax), count: colMax)
        terrainBoard = randomGenerateTerrain(trees: 10, houses: 10, Coord(9,9))
        
        set(moveable: King(board: self), Coord: Coord())
        set(moveable: King(board: self), Coord: Coord(row: 1))
        
        escapeCoord = Coord(row: rowMax-1, col: colMax-1)
        
        spawnZombies(1)
      
    }
}


extension Board {

    
    /**
     future feature : If tap on unit and send to place but still have stamina, that unit will remain selected
     */
    func increaseMoveCount(row: Int, col: Int) {
        if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
            piece.incrementMoveCounter()
        }
        
    }
    
    // MARK: Private Functions
    func setPossibleCoords() {
        guard let loc = tappedLoc, let piece = board[loc.row][loc.col]
        else {
            possibleLoc = []
            return
        }
        //        print("\(piece.getMoves())")
        possibleLoc = piece.getMoves()
    }
    func CoordIsValid(Coord: Coord) -> Bool {
        Coord.row >= 0 && Coord.row < rowMax && Coord.col >= 0 && Coord.col < colMax
    }
    func safeNum(c : Int)->Int{
        if c>colMax-1{
            return colMax-1
        }
        else if c<0 {
            return 0
        }
        return c
    }
    func safeNum(r : Int)->Int{
        if r>rowMax-1{
            return rowMax-1
        }
        else if r<0 {
            return 0
        }
        return r
    }
    func isPossibleLoc(row: Int, col: Int) -> Bool {
        for loc in possibleLoc {
            if loc.row == row && loc.col == col {
                return true
            }
        }
        return false
    }
    func set(moveable: any Piece, Coord: Coord) {
        guard CoordIsValid(Coord: Coord) else { return }
        board[Coord.row][Coord.col] = moveable
        //findInRange()
    }
    func getCoord(of moveable: any Moveable) -> Coord? {
        
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if board[row][col]?.id == moveable.id {
                    //                    print(Coord(row: row, col: col))
                    return Coord(row: row, col: col)
                }
            }
        }
        
        return nil
    }
}
/**
 Attempt to optimize checkHPAndRefreshStamina
 //        for zombie in Zombies {
 //            if zombie.health == 0 {
 //                var locZ = getCoord(of: zombie)
 //                board[locZ!.row][locZ!.col]  = nil
 //                zombie.movementCount = 0
 ////                board[getCoord(of: zombie])!.row][getCoord(of: Zombies[zombie])!.col] = nil
 //            }
 //        }
 //        for player in PlayerUnit {
 //            if board[player.row][player.col]?.health == 0 {
 //                board[player.row][player.col] = nil
 //                board[player.row][player.col]?.movementCount = 0
 //            }
 //        }
 
 
 for zombie in 0..<zombieRef.count{
 if zombieRef[zombie].health == 0{
 zombieRef.remove(at: zombie)
 }
 else{
 zombieRef[zombie].movementCount = 0
 }
 }
 for player in 0..<unitCoords.count{
 if board[unitCoords[player].row][unitCoords[player].col]?.health == 0{
 board[unitCoords[player].row][unitCoords[player].col] = nil
 unitCoords.remove(at: player)
 }
 else{
 board[unitCoords[player].row][unitCoords[player].col]?.movementCount = 0
 }
 }
 */

//    func checkHP(){
//        for row in 0..<rowMax {
//            for col in 0..<colMax {
//                if (board[row][col]?.health ?? 0 <= 0){
//                    board[row][col] = nil
//                }
//
//            }
//        }
//    }
//    func refreshStamina(){
//        for row in 0..<rowMax {
//            for col in 0..<colMax {
//                if (board[row][col] != nil) {//If it encounters anything
//                    board[row][col]?.movementCount = 0//Resets movement counter
//                }
//            }
//        }
//    }



