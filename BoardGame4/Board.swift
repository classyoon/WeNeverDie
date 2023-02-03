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
    var name = "g"
    var loot = 0
    var movementPenalty = 0
    var houseLoot = 2
    
    mutating func setTileBonuses(){
        switch name {
        case "h":
            loot += houseLoot
        case "w":
            movementPenalty = 1
        default :
            _ = 0
        }
    }
    
}
struct TerrainPiece {
    
}
class Board : ObservableObject, BoardProtocol {
    @Published var showBoard = true
    @Published var terrainBoard: [[TileType]] = [[TileType(name: "g",loot: 0,movementPenalty: 0)]]
    @Published var board: [[(any Piece)?]] = [[]]
    @Published var game : GameWND
    
    
    @Published var unitWasSelected = false
    @Published var selectedUnit : (any Piece)? = nil
    @Published var selectedLoc :Coord? = nil
    
    @Published var enteringSurvivors = [King]()
    
    @Published var survivorList = [King]()
    @Published var wasTappedCoord : Coord?{
        didSet{
            setPossibleCoords()
        }
    }
    
    @Published var possibleLoc: [Coord] = []
    let rowMax: Int = 5
    let colMax: Int = 5
   
    let startSquares = 1
    var availibleTiles : Int {rowMax*colMax-startSquares-1}
    
    func randomCountFromPercent(_ percent : Double,  varience : Double = 0.05)->Int{
        let minPercent = percent-varience
        let maxPercent = percent+varience
        return Int(Int.random(in: Int( minPercent*Double(availibleTiles))...Int((maxPercent*Double(availibleTiles)))))
    }
    
    func randomGenerateTerrain(trees : Double = 0, houses : Double = 0, water : Double = 0, exit escapePoint : Coord)->[[TileType]]{
        
        let trees = randomCountFromPercent(trees)
        let houses = randomCountFromPercent(houses)
        let water = randomCountFromPercent(water)
        //        let water = 0 //randomCountFromPercent(water)
        
        
        var tempTerrain = Array(repeating: Array(repeating: TileType(name: "g", loot: 0, movementPenalty: 0), count: rowMax), count: colMax)
        tempTerrain[escapePoint.row][escapePoint.col].name = "X"
        tempTerrain[0][0].name = "t"
        var counter = 0 // Sharing the counter
        var numberAdded = 0
        
        while (((counter<trees-startSquares)||(counter<houses)||(counter<water))&&(numberAdded<availibleTiles)){
            var Random = randomLoc()
            while (tempTerrain[Random.row][Random.col].name != "g"){
                Random = randomLoc()
            }
            if counter<trees-startSquares {
                tempTerrain[Random.row][Random.col].name = "t"
                numberAdded += 1
                tempTerrain[Random.row][Random.col].setTileBonuses()
            }
            while (tempTerrain[Random.row][Random.col].name != "g"){
                Random = randomLoc()
            }
            if counter<houses {
                tempTerrain[Random.row][Random.col].name = "h"
                numberAdded += 1
                tempTerrain[Random.row][Random.col].setTileBonuses()
            }
            while (tempTerrain[Random.row][Random.col].name != "g"){
                Random = randomLoc()
            }
            if counter<water {
                tempTerrain[Random.row][Random.col].name = "w"
                numberAdded += 1
                tempTerrain[Random.row][Random.col].setTileBonuses()
            }
           
            
            counter+=1
        }
        return tempTerrain
    }
//    func randomGenerateTerrain(trees : Int = 0, houses : Int = 0, water : Int = 0, exit escapePoint : Coord)->[[(String, Int, Int)]]{
//        var tempTerrain = Array(repeating: Array(repeating: ("g", 0, 0), count: rowMax), count: colMax)
//        tempTerrain[escapePoint.row][escapePoint.col].0 = "X"
//        tempTerrain[0][0].name = "t"
//        var counter = 0 // Sharing the counter
//        while (((counter<trees-1)||(counter-(trees-1)<houses))&&(counter<rowMax*colMax-2)){
//            var Random = randomLoc()
//            while (tempTerrain[Random.row][Random.col].0 != "g"){
//                Random = randomLoc()
//            }
//            if counter<trees-1 {
//                tempTerrain[Random.row][Random.col].0 = "t"
//            }
//            else if counter-(trees-1)<houses {
//                tempTerrain[Random.row][Random.col].0 = "h"
//                tempTerrain[Random.row][Random.col].1+=houseLoot
//            }
//            else if counter-(trees-1)-(houses)<water {
//                tempTerrain[Random.row][Random.col].0 = "w"
//                tempTerrain[Random.row][Random.col].2+=1
//            }
//            counter+=1
//        }
//        return tempTerrain
//    }
    
    
    
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
        let bottemRight = Coord(rowMax-1, colMax-1)
        
        terrainBoard = randomGenerateTerrain(trees: 0.2, houses: 0.2, water: 0.2, exit : bottemRight)
        
        set(moveable: King(board: self), Coord: Coord())
        
        set(moveable: Zombie(board: self), Coord: Coord(row : 2))
        //        terrainBoard[2][0].0 = "g"
        //        terrainBoard[2][0].2 = 0
        //        terrainBoard[1][0].0 = "g"
        //        terrainBoard[1][0].2 = 0
        //        spawnZombies(1)
        
    }
}

extension Board {
    
    
    /**
     future feature : If tap on unit and send to place but still have stamina, that unit will remain selected
     */
    func increaseMoveCount(row: Int, col: Int) {
        if let tappedCol = wasTappedCoord?.col, let tappedRow = wasTappedCoord?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
            piece.incrementMoveCounter()
        }
        
    }
    
    // MARK: Private Functions
    func setPossibleCoords() {
        guard let loc = wasTappedCoord, let piece = board[loc.row][loc.col]
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



