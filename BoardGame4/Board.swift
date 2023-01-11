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
    func getLocation(of moveable: any Moveable) -> Location?
}


class Board : ObservableObject, BoardProtocol {
    @Published private(set) var board: [[(any Piece)?]] = [[]]
    
    //    @Published private(set) var mobs: [(any Piece)?] = []
    
    @Published var isTapped = false
    @Published var tappedLoc : Location?{
        didSet{
            setPossibleLocations()
        }
    }
    @Published var possibleLoc: [Location] = []
    
    let rowMax: Int = 4
    let colMax: Int = 4 //WARNING SafeNum only works for col, as long as they equal each other it will be safe.
    func reset()->Board{
        Board()
    }
    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        
        
        set(moveable: King(board: self), location: Location(row: 3, col: 3))
        set(moveable: Zombie(board: self), location: Location(row: 1, col: 3))
        //        set(moveable: Zombie(board: self), location: Location(row: 3, col: 0))
        //        set(moveable: Zombie(board: self), location: Location(row: 4, col: 3))
        //        set(moveable: Zombie(board: self), location: Location(row: 2, col: 3))
        //        set(moveable: Zombie(board: self), location: Location(row: 0, col: 2))
        //        set(moveable: Zombie(board: self), location: Location(row: 2, col: 0))
    }
}

extension Board {
    // MARK: Not private
    func handleTap(row: Int, col: Int) {
        if isTapped == false {
            tappedLoc = Location(row: row, col: col)
        }else{
            if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col), var piece = board[tappedRow][tappedCol]  {
                if piece.getCanMove(){
                    if (!(board[row][col] != nil)){//Checks stamina and if a piece is already there
                        piece.incrementMoveCounter()
                        board[row][col] = piece
                        board[tappedRow][tappedCol] = nil//Erases original copy of player pieces moved.
                    }
                    if (board[row][col]?.faction == "Z"){
                        board[row][col]?.health-=piece.damage
                        board[tappedRow][tappedCol]?.movementCount+=1
                        if board[row][col]?.health == 0 {
                            board[row][col] = nil
                        }
                    }
                }
            }
            tappedLoc = nil
        }
        /**
         future feature : If tap on unit and send to place but still have stamina, that unit will remain selected
         */
        isTapped.toggle()
    }
    
    func findDistance(zombie : Zombie)->(RowD : Int, ColD : Int, seekerLocation : Location){//This properly locates the targets.
        let seekerLoc = getLocation(of: zombie) ?? Location()
        var targetLoc = Location()
        var thingSighted = false
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col]?.faction=="S") {//Locates target on the map
                    targetLoc = Location(row: row, col: col)
                    thingSighted=true
                }
            }
        }
        if thingSighted==false {
            targetLoc=seekerLoc
        }
        
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    
    func seekFor(zombie : Zombie)->Location{
        let distance = findDistance(zombie: zombie)
        
        var returnLocation = distance.seekerLocation
        
        for r in safeNum(returnLocation.row-1)..<safeNum(returnLocation.row+2) {//Checks if can attack
            for c in safeNum(returnLocation.col-1)..<safeNum(returnLocation.col+2) {
                if (board[r][c]?.faction == "S"&&(!(r==returnLocation.row&&c==returnLocation.col))){
                    print("I am in range to attack.")
                    board[r][c]?.health -= zombie.damage
                    return returnLocation
                }
            }
        }
        var directionText = ""
        if distance.RowD > 0 {// Target row 2  Seeker row 1 = Distance is 1//Seeker shoudl go right
            returnLocation.row+=1
            directionText+="Down "
        }
        else if distance.RowD < 0 {// Target row 1  Seeker row 2 = Distance is -1//Seeker should go left
            returnLocation.row-=1
            directionText+="Up "
        }
        if distance.ColD < 0 {// Target row 1  Seeker row 2 = Distance is -1 // seeker should go up
            returnLocation.col-=1
            directionText+="Left"
        }
        else if distance.ColD > 0 {// Target col 2  Seeker col 1 = Distance is 1//Seeker should go down
            returnLocation.col+=1
            directionText+="Right"
        }
        print(directionText)
        
        if (board[returnLocation.row][returnLocation.col]==nil){//Check if will collide
            board[distance.seekerLocation.row][distance.seekerLocation.col] = nil//Prevents self duplication
            //        }
            print("From \(distance.seekerLocation) I go to \(returnLocation)")
            return returnLocation
        }
        else{
            print("I remain at \(distance.seekerLocation)")
            //            var ranC = Int.random(in: -1..<1)
            //            var ranR = Int.random(in: -1..<1)
            //            if (board[safeNum(returnLocation.row+ranR)][safeNum(returnLocation.col+ranC)]==nil){//Check if will collide
            //                board[distance.seekerLocation.row][distance.seekerLocation.col] = nil//Prevents self duplication
            //                //        }
            //                returnLocation.row = safeNum(returnLocation.row+ranR)
            //                returnLocation.col = safeNum(returnLocation.col+ranC)
            //                print("From \(distance.seekerLocation) I wander to \(returnLocation)")
            //                return returnLocation
            //            }
            return distance.seekerLocation
            
        }
    }
    
    func moveZombie(){//Collects list of zombie
        var zombies = [Zombie]()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="Z")) {
                    zombies.append(board[row][col] as! Zombie)
                }
            }
        }
        for currentZombie in 0..<zombies.count {
            if zombies[currentZombie].getCanMove(){
                set(moveable: zombies[currentZombie], location:seekFor(zombie: zombies[currentZombie]))
                print("I moved a zombie.")
                //SeekFor erases the duplicate zombie
                zombies[currentZombie].movementCount+=1
            }
        }
    }
    
    func nextTurn(){
        checkHP()
        var playerLocationPin = Location()
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="S")) {
                    playerLocationPin = Location(row: row, col: col)
                }
                
            }
        }
        if playerLocationPin == Location(row: 1, col: 1){
            board[1][1]?.faction = "E"
            print("HIDDEN")
        }
        moveZombie()
        refreshStamina()
        
    }
}

extension Board {
    // MARK: Private Functions
    private func setPossibleLocations() {
        guard let loc = tappedLoc, let piece = board[loc.row][loc.col]
        else {
            possibleLoc = []
            return
        }
        //        print("\(piece.getMoves())")
        possibleLoc = piece.getMoves()
    }
    private func locationIsValid(location: Location) -> Bool {
        location.row >= 0 && location.row < rowMax && location.col >= 0 && location.col < colMax
    }
    //Internal functions, functions that will be used without much change to them.
    func safeNum(_ col : Int)->Int{
        if col>colMax{
            return colMax
        }
        else if col<0 {
            return 0
        }
        return col
    }
    func findStats()->String{
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col] != nil) {
                    return "\(board[row][col]?.faction ?? "N") : \(board[row][col]?.health ?? 0)"
                    //\(String(describing: board[row][col]?.movementCount)) / \(String(describing: board[row][col]?.stamina))"
                }
            }
        }
        return ""
    }
    
    func isPossibleLoc(row: Int, col: Int) -> Bool {
        for loc in possibleLoc {
            if loc.row == row && loc.col == col {
                return true
            }
        }
        
        return false
    }
    func set(moveable: any Piece, location: Location) {
        guard locationIsValid(location: location) else { return }
        board[location.row][location.col] = moveable
        //findInRange()
    }
    func getLocation(of moveable: any Moveable) -> Location? {
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if board[row][col]?.id == moveable.id {
                    return Location(row: row, col: col)
                }
            }
        }
        return nil
    }
    func checkHP(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col]?.health ?? 0 <= 0){
                    board[row][col] = nil
                }
            }
        }
    }
    func refreshStamina(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col] != nil) {//If it encounters anything
                    board[row][col]?.movementCount = 0//Resets movement counter
                }
            }
        }
    }
}


