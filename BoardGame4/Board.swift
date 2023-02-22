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
    var houseLoot = 10
    var waterPenalty = 1
    
    mutating func setTileBonuses(){
        switch name {
        case "h":
            loot += houseLoot
        case "w":
            movementPenalty += waterPenalty
        default :
            _ = 0
        }
    }
    
}
import AVFoundation

// Load the music file
let musicUrl = Bundle.main.url(forResource: "myMusic", withExtension: "mp3")
let musicPlayer = try? AVAudioPlayer(contentsOf: musicUrl!)

// Start playing the music

class Board : ObservableObject, BoardProtocol {
    @Published var namesSurvivors = ["Steve", "Jobs", "Billy", "Gates", "Jeff", "Bezos", "Gates", "Jeff", "Bezos"]
    @Published var showBoard = true
    @Published var terrainBoard: [[TileType]] = [[TileType(name: "g",loot: 0,movementPenalty: 0)]]
    @Published var board: [[(any Piece)?]] = [[]]
    @Published var missionUnderWay = true
    var unitWasSelected : Bool {
        selectedUnit != nil
    }
    @Published var UnitsDied = 0
    @Published var selectedUnit : (any Piece)? = nil
    @Published var enteringSurvivors = [any Piece]()
    @Published var survivorList = [any Piece]()
    @Published var highlightSquare : Coord?{
        didSet{
            setPossibleCoords()
        }
    }
    
    @Published var turn = UUID()
    @Published var possibleLoc: [Coord] = []
    let rowMax: Int = 4
    let colMax: Int = 4
   
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
//    var survivorList = [playerUnit(name: "Steve", board: self),  playerUnit(name: "Jobs", board: self)]
    
    func spawnPlayers(_ amount: Int) {
        var counter = 0
        var r = 0
        var c = 0
        
        while counter < amount {
//            if counter <= amount {
//                break
//            }
            while r < safeNum(r: 3) {
                while c < safeNum(c: 3) {
                    
                    if counter >= amount {
                        break
                    }
                    set(moveable: playerUnit(name: namesSurvivors[counter], board: self), Coord: Coord(r, c))
                    
//                    print("\(r), \(c) spawn : \(counter)")
                    counter += 1
                    c += 1
                }
                
                // Reset the value of c to 0 after each row
                
                c = 0
                r += 1
            }
        }
    }
   
    func generateBoard(_ players : Int){
        missionUnderWay = true
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        let bottemRight = Coord(rowMax-1, colMax-1)
        terrainBoard = randomGenerateTerrain(trees: 0.2, houses: 0.2, water: 0.0, exit : bottemRight)
        spawnPlayers(players)
//        set(moveable: playerUnit(name: "Jobs", board: self), Coord: Coord(col: 1))
       spawnZombies(3)
//        set(moveable: Zombie(board: self), Coord: Coord(row : 2))
    }
    init(players : Int){

       generateBoard(players)
       // spawnPlayers(3)
    }
}

extension Board {
    func increaseMoveCount(row: Int, col: Int) {
        if let tappedCol = highlightSquare?.col, let tappedRow = highlightSquare?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
            piece.incrementMoveCounter()
        }
        
    }
    func setPossibleCoords() {
        guard let loc = highlightSquare, let piece = board[loc.row][loc.col]
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
