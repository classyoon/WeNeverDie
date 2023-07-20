//
//  Board.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
// Modified by Conner Yoon

import Foundation

protocol BoardProtocol {
    var rowMax: Int { set get }
    var colMax: Int { set get }
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
    var rowMax: Int = 7
    var colMax: Int = 7
    let startSquares = 4
    var zombieNumber = Int.random(in: 1...4)
    var availibleTiles : Int {rowMax*colMax-startSquares-1}
    var bottomRight : Coord {Coord(safeNum(r: rowMax), safeNum(c:colMax))}
    @Published var foodNew = 0
    @Published var materialNew = 0
    @Published var uiSettings : UserSettingsManager
    @Published var audio : AudioManager
    
    @Published var size : Int = 100
    @Published var zombieSpawnLimit = 10
    
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
        tempTerrain[escapePoint.row][escapePoint.col].name = "X"
        
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
    
    func chooseMap(_ number : Int)->[[TileType]] {
        switch mapIndex {
        case 0...1 :
            rowMax = 7
            colMax = 7
            turnsOfDaylight += 3
            turnsOfNight += 3
            zombieNumber += 3
            print("Wreckage Map")
            size = 700
            zombieSpawnLimit = 15
            return convertLevel(level: levelWreckage)
        case 2...4:
            rowMax = 7
            colMax = 7
            turnsOfDaylight += 3
            turnsOfNight += 3
            zombieNumber += 2
            zombieSpawnLimit = 20
            print("Roadblock Map")
            size = 700
            return convertLevel(level: levelRoadBlock)
        case 5...6:
            rowMax = 7
            colMax = 7
            turnsOfDaylight += 4
            turnsOfNight += 4
            zombieNumber += 3
            zombieSpawnLimit = 25
            print("Neighborhood Map")
            size = 700
            return convertLevel(level: levelneighborhood)
        default :
            colMax = 5
            rowMax = 5
            print("Random Map")
            board = Array(repeating: Array(repeating: nil, count: colMax), count: rowMax)
            size = 500
            zombieSpawnLimit = 10
            return randomGenerateTerrain(players : number, trees: 0.5, houses: Double(Stockpile.shared.getNumOfPeople())*0.1, water: 0.1, exit : bottomRight)
            
        }
    }
    
    func generateBoard(_ players : Int){
        missionUnderWay = true
        turnsSinceStart = 0
        lengthOfPlay = turnsOfDaylight + turnsOfNight
        terrainBoard = chooseMap(players)
        spawnPlayers(players)
        spawnZombies(zombieNumber)
        spawnRecruit(Int.random(in: 0...2))
        
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
    func convertLevel(level: [[String]]) -> [[TileType]] {
        var tempTerrain: [[TileType]] = []
        for row in level {
            var tileRow: [TileType] = []
            for tileName in row {
                var tile = TileType(name: tileName, loot: 0, movementPenalty: 0)
                tile.setTileBonuses()
                tileRow.append(tile)
            }
            tempTerrain.append(tileRow)
        }
        board = Array(repeating: Array(repeating: nil, count: colMax), count: rowMax)
        return tempTerrain
    }
    
    var mapIndex = Int.random(in: 0...10)
    var levelRoadBlock = [["t","t","g", "g","w","t","t",],
                          ["t","g","g","h","w","t","g",],
                          ["g","g","g","w","h","g","g",],
                          ["g","w","w","g","t","h","g",],
                          ["w","g","h","t","g","g","w",],
                          ["t","t","g","h","g","g","g",],
                          ["t","t","g","g","w","g","X",]]
    var levelWreckage = [["t","t","g","g","w","h","h",],
                         ["t","t","g","g","g","g","g",],
                         ["w","w","w","w","g","g","g",],
                         ["g","g","g","g","w","g","X",],
                         ["t","t","t","g","g","w","g",],
                         ["h","h","t","t","g","w","g",],
                         ["h","h","h","t","g","w","g",]]
    var levelneighborhood = [["t","t","g","g","t","t","t",],
                             ["t","g","g","g","g","t","t",],
                             ["g","g","g","g","g","g","g",],
                             ["w","g","h","h","h","h","g",],
                             ["w","w","g","g","g","g","g",],
                             ["w","w","h","h","h","h","g",],
                             ["w","w","t","t","g","g","X",]]
    
}
