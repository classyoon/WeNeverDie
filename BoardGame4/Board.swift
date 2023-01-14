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
class Board : ObservableObject, BoardProtocol {
    @Published private(set) var board: [[(any Piece)?]] = [[]]
    @Published var treeCoords = [Coord]()
    @Published var lootCoords = [Coord]()
    @Published var isTapped = false
    @Published var lootBoard = [[Int]]()
    @Published var mobArray = [(any Piece)?]()
    @Published var tappedLoc : Coord?{
       
        didSet{
            setPossibleCoords()
        }
    }
    @Published var possibleLoc: [Coord] = []
    let rowMax: Int = 10
    let colMax: Int = 10
    func reset()->Board{
        Board()
    }
    func createCoordList(_ amount : Int)->[Coord]{
        var count = 0; var coordArray = [Coord]()
        while count < amount {
            coordArray.append(Coord(row: randomLoc().row, col: randomLoc().col))
            count+=1
        }
        return coordArray
    }
    func checkForTree(_ r: Int,_ c: Int)->Bool{
        for treeNum in 0..<treeCoords.count{
            if treeCoords[treeNum].row == r && treeCoords[treeNum].col == c{
                return true
            }
        }
        return false
    }
    func checkForLoot(_ r: Int,_ c: Int)->Bool{
        for loc in 0..<lootCoords.count{
            if lootCoords[loc].row == r && lootCoords[loc].col == c{
                return true
            }
        }
        return false
    }
    
    //    @Published private(set) var mobs: [(any Piece)?] = []
    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        lootBoard = Array(repeating: Array(repeating: 1, count: rowMax), count: colMax)
        //        set(moveable: King(board: self), Coord: Coord())
        //        set(moveable: King(board: self), Coord: Coord(row: 6))
        //        set(moveable: Zombie(board: self), Coord: Coord(row: 4))
        
        set(moveable: King(board: self), Coord: Coord(row: 9, col: 9))
        set(moveable: King(board: self), Coord: Coord(row: 8, col: 9))
        set(moveable: King(board: self), Coord: Coord(row: 7, col: 9))
        
        var counter = 0; let quota = 30
        while counter<quota{
            set(moveable: Zombie(board: self), Coord: randomLoc())
            counter+=1
        }
        mobArray = createMobArray()
        treeCoords = createCoordList(30)
    }
}

extension Board {
    // MARK: Not private
    func createMobArray()->[any Piece]{
        var mobList = [any Piece]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if !(board[row][col]==nil){
                    mobList.append(board[row][col]!)
                }
            }
        }
        return mobList
    }
    
    func randomLoc() -> Coord{
        var ranR = Int.random(in: 0...rowMax-1); var ranC = Int.random(in: 0...colMax-1)
        while board[ranR][ranC] != nil {
            ranR = Int.random(in: 0...rowMax-1); ranC = Int.random(in: 0...colMax-1)
        }
        return Coord(row: ranR, col: ranC)
    }
    /**
     future feature : If tap on unit and send to place but still have stamina, that unit will remain selected
     */
    func handleTap(row: Int, col: Int) {
        if isTapped == false {
            tappedLoc = Coord(row: row, col: col)
        }
        else{
            if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
                if piece.getCanMove(){
                    if (!(board[row][col] != nil)){//Checks stamina and if a piece is already there
                        piece.incrementMoveCounter()
                        board[row][col] = piece; board[tappedRow][tappedCol] = nil//Erases original copy of player pieces moved.
                    }
                    if (board[row][col]?.faction == "Z"){
                        board[row][col]?.health-=piece.damage
                        board[tappedRow][tappedCol]?.movementCount+=1
                        
                        if board[row][col]?.health == 0 {board[row][col] = nil}
                    }
                }
            }
            tappedLoc = nil
        }
        isTapped.toggle()
    }
    //////////ZOMBIE//////////
    func findDistance(zombie : Zombie, targetList: [Coord])->(RowD : Int, ColD : Int, seekerCoord : Coord){//This properly locates the targets.
        var targetLoc = Coord(); let seekerLoc = getCoord(of: zombie) ?? Coord()
        var thingSighted = false
        var DRow : Int = 100; var DCol : Int = 100
            for target in 0..<targetList.count{
                if abs(targetList[target].row-seekerLoc.row) <= DRow && abs(targetList[target].col-seekerLoc.col) <= DCol && board[targetList[target].row][targetList[target].col]?.faction == "S" {
                    targetLoc = targetList[target]
                    DRow = abs(targetList[target].row-seekerLoc.row); DCol = abs(targetList[target].col-seekerLoc.col)
                    thingSighted = true
                }
            }
        if thingSighted==false {
            targetLoc=seekerLoc
        }
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    func approachAndDamage(zombie : Zombie, targetList: [Coord])->Coord{
        let distance = findDistance(zombie: zombie, targetList: targetList)
        var returnCoord = distance.seekerCoord
        //Attacks Neighbor
        //        print("I scan from row \(safeNum(returnCoord.row-1)) \(safeNum(returnCoord.row+1))")
        //        print("I scan from col \(safeNum(returnCoord.col-1)) \(safeNum(returnCoord.col+1))")
        for r in safeNum(r: returnCoord.row-1)...safeNum(r: returnCoord.row+1) {//Checks if can attack
            for c in safeNum(c: returnCoord.col-1)...safeNum(c: returnCoord.col+1) {
                if (board[r][c]?.faction == "S"&&(!(r==returnCoord.row&&c==returnCoord.col))){ //print("I check \(r) \(c)")
                    board[r][c]?.health -= zombie.damage; print("I am in range to attack.")
                    return returnCoord
                }
            }
        }
        //Travels toward
        var directionText = ""
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
        
        //Actual moving
        if (board[returnCoord.row][returnCoord.col]==nil){//Check if will collide
            board[distance.seekerCoord.row][distance.seekerCoord.col] = nil//Prevents self duplication
            print("I go \(directionText). From \(distance.seekerCoord) I go to \(returnCoord)")
            return returnCoord
        }
        
        let ranRow = safeNum(r: distance.seekerCoord.row+Int.random(in: -1...1))
        let ranCol = safeNum(c: distance.seekerCoord.col+Int.random(in: -1...1))
        if board[ranRow][ranCol]==nil{//Check if will collide
            board[distance.seekerCoord.row][distance.seekerCoord.col] = nil //Prevents self duplication
            print("wander from \(distance.seekerCoord) to (\(ranRow), \(ranCol))")
            return Coord(row: ranRow, col: ranCol)
        }
        else{
            print("I remain at \(distance.seekerCoord)"); return distance.seekerCoord
        }
    }
    func moveZombies(_ zombies : [Zombie], unitList: [Coord]){//Collects list of zombie
        var zombies = zombies.self
        for currentZombie in 0..<zombies.count {
            while zombies[currentZombie].getCanMove(){
                zombies[currentZombie].movementCount+=1; print("I zombie number \(currentZombie+1) at stamina \(zombies[currentZombie].stamina-zombies[currentZombie].movementCount)")
                set(moveable: zombies[currentZombie], Coord:approachAndDamage(zombie: zombies[currentZombie], targetList: unitList))//SeekFor erases the duplicate zombie
            }
        }
    }
    //////////END OF ZOMBIE//////////
    
    func createLists()-> (zombieList : [Zombie], unitList: [Coord]) {
        var playerCoordPins = [Coord]()
        var zombies = [Zombie]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="S"||board[row][col]?.faction=="E")) {
                    playerCoordPins.append( Coord(row: row, col: col)); continue
                }
                if ((board[row][col]?.faction=="Z")) {
                    zombies.append(board[row][col] as! Zombie)
                }
            }
        }
        return (zombies, playerCoordPins)
    }
    func applyConcealment(_ playerCoordPins : [Coord]){
        for each in 0..<playerCoordPins.count{
            if checkForTree(playerCoordPins[each].row, playerCoordPins[each].col){
                board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "E"; print("HIDDEN")
            }
            else{board[playerCoordPins[each].row][playerCoordPins[each].col]?.faction = "S"}
        }
    }
    func checkHPAndRefreshStamina(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col]?.health ?? 0 <= 0){
                    board[row][col] = nil; continue
                }
                if (board[row][col] != nil) {//If it encounters anything
                    board[row][col]?.movementCount = 0//Resets movement counter
                }
                
            }
        }
    }
    func nextTurn(){
        let zombies = createLists().zombieList; let players = createLists().unitList
        applyConcealment(players)
        moveZombies(zombies, unitList: players)
        checkHPAndRefreshStamina()
    }
}

extension Board {
    
    // MARK: Private Functions
    private func setPossibleCoords() {
        guard let loc = tappedLoc, let piece = board[loc.row][loc.col]
        else {
            possibleLoc = []
            return
        }
        //        print("\(piece.getMoves())")
        possibleLoc = piece.getMoves()
    }
    private func CoordIsValid(Coord: Coord) -> Bool {
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



