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

//let testSoundPlayer = try? AVAudioPlayer(contentsOf: soundUrl!)
// Start playing the music


class Board : ObservableObject, BoardProtocol {
    @Published var stockpile : Stockpile = Stockpile.shared

    @Published var UnitsDied = 0
    @Published var UnitsRecruited = 0
    
    @Published var namesSurvivors = ["Steve", "Jobs", "Billy", "Gates", "Jeff", "Bezos", "Gates", "Jeff", "Bezos"]
   
    @Published var showBoard = false
    @Published var terrainBoard: [[TileType]] = [[TileType(name: "g",loot: 0,movementPenalty: 0)]]
    @Published var board: [[(any Piece)?]] = [[]]
    @Published var missionUnderWay = false
    @Published var alreadyEscaped = false
    @Published var showEscapeOption = false
    var unitWasSelected : Bool {
        selectedUnit != nil
    }
    @Published var examinedPiece : (any Piece)? = nil
    
    @Published var turnsSinceStart = 0
    @Published var lengthOfPlay = 0
    @Published var changeToNight = false
    @Published var turnsOfDaylight = 8
    @Published var turnsOfNight = 12
    @Published var selectedUnit : (any Piece)? = nil
    @Published var enteringSurvivors = [any Piece]()
    @Published var survivorList = [any Piece]()
    @Published var numberOfZombies : Int = 0
    @Published var highlightSquare : Coord?{
        didSet{
            setPossibleCoords()
        }
    }
    @Published var canAnyoneMove = true
    @Published var badOutcome = false
    @Published var neutralOutcome = false
    @Published var avoidedOutcome = false
    @Published var turn = UUID()
    
    @Published var possibleLoc: [Coord] = []
    let rowMax: Int = 4
    let colMax: Int = 5
    let startSquares = 4
    var availibleTiles : Int {rowMax*colMax-startSquares-1}
    
    @Published var foodNew = 0
    @Published var materialNew = 0
    @Published var uiSettings : UserSettingsManager
    @Published var audio : AudioManager
    
    func randomCountFromPercent(_ percent : Double,  varience : Double = 0.05)->Int{
        let minPercent = percent-varience
        let maxPercent = percent+varience
        return Int(Int.random(in: Int( minPercent*Double(availibleTiles))...Int((maxPercent*Double(availibleTiles)))))
    }
    
    func randomGenerateTerrain(players : Int, trees : Double = 0, houses : Double = 0, water : Double = 0, exit escapePoint : Coord)->[[TileType]]{
      //  print(board)
        let trees = randomCountFromPercent(trees)
        let houses = randomCountFromPercent(houses)
        let water = randomCountFromPercent(water)
        
        var tempTerrain = Array(repeating: Array(repeating: TileType(name: "g", loot: 0, movementPenalty: 0), count: colMax), count: rowMax)
//        print(tempTerrain)
//        print("\(rowMax), \(colMax)")
//        print("\(escapePoint)")
        tempTerrain[escapePoint.row][escapePoint.col].name = "X"
        
        //print(tempTerrain)

        
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
        
       // print(tempTerrain)
        return tempTerrain
    }
    
    func randomLoc() -> Coord{
        
        var ranR = Int.random(in: 0...rowMax-1); var ranC = Int.random(in: 0...colMax-1)
       // print("checking \(ranR), \(ranC)")
        while board[ranR][ranC] != nil || (ranR == rowMax-1 && ranC == colMax-1) {
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
    
    /// Spawns the player's units in rows of three
    /// - Parameter amount: number of player units.
    func spawnPlayers(_ amount: Int) {
        var counter = 0
        var r = 0
        var c = 0
        
        while counter < amount {
            while r < safeNum(r: 3) {
                while c < safeNum(c: 3) {
                    
                    if counter >= amount {
                        break
                    }
                    var temp = playerUnit(name: namesSurvivors[counter], board: self)
                    temp.checkForUpgrade()
                    set(moveable: temp, Coord: Coord(r, c))
                    terrainBoard[r][c].name = "t"
                    counter += 1
                    c += 1
                    print("\(counter)")
                }
                // Reset the value of c to 0 after each row
                c = 0
                r += 1
            }
        }
    }

    func generateBoard(_ players : Int){
        
        missionUnderWay = true
        turnsSinceStart = 0
        turnsOfDaylight = (Int.random(in: 6...10))
        turnsOfNight = (Int.random(in: 10...12))
        lengthOfPlay = turnsOfDaylight + turnsOfNight
        
        board = Array(repeating: Array(repeating: nil, count: colMax), count: rowMax)
        let bottomRight = Coord(safeNum(r: rowMax), safeNum(c:colMax))
        terrainBoard = randomGenerateTerrain(players : players, trees: 0.5, houses: Double(Stockpile.shared.getNumOfPeople())*0.1, water: 0.1, exit : bottomRight)
        //print("Terrain generated, generating players")
     
        spawnPlayers(players)
        spawnZombies(Int.random(in: 1...4))
        let loc = randomLoc()
        terrainBoard[loc.row][loc.col].name = "t"
        set(moveable: recruit(board: self), Coord: loc)
    }
    init(players : Int, _ audioInit : AudioManager, _ settings : UserSettingsManager){
        audio = audioInit
        uiSettings = settings
        generateBoard(outsideTesting && devMode ? 1 : players)
        uiSettings.isAutoPauseMusic ? audio.pauseMusic() : nil
    }
    init(){
        audio = AudioManager()
        uiSettings = UserSettingsManager()
        generateBoard(1)
        uiSettings.isAutoPauseMusic ? audio.pauseMusic() : nil
    }
}
