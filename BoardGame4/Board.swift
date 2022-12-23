//
//  Board.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import Foundation

protocol BoardProtocol {
    var rowMax: Int { get }
    var colMax: Int { get }
    func getLocation(of moveable: any Moveable) -> Location?
}

class Board : ObservableObject, BoardProtocol {
    @Published private(set) var board: [[(any Piece)?]] = [[]]
    
    @Published var isTapped = false
    @Published var tappedLoc : Location?{
        didSet{
            setPossibleLocations()
        }
    }
    @Published var possibleLoc: [Location] = []
    
    let rowMax: Int = 5
    let colMax: Int = 5
    func reset()->Board{
        Board()
    }
    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        //        set(moveable: Checker(board: self), location: Location(row: 1, col: 1))
        //        set(moveable: Pawn(board: self), location: Location(row: 4, col: 4))
        //        set(moveable: Knight(board: self), location: Location(row: 5, col: 2))
        //var mob: Piece = [King(board: self),  Zombie(board: self)](any Piece)//Attempted array

        set(moveable: King(board: self), location: Location(row: 0, col: 0))
        set(moveable: Zombie(board: self), location: Location(row: 2, col: 0))
        set(moveable: King(board: self), location: Location(row: 0, col: 1))
//        set(moveable: Zombie(board: self), location: Location(row: 0, col: 3))
            }
}

extension Board {
    // MARK: Not private
    
    func findInRange(){
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col] != nil){
                    for r in safeNum(row-1)..<safeNum(row+2) {
                        for c in safeNum(col-1)..<safeNum(col+2) {
                            if (board[r][c] != nil&&(!(r==row&&c==col))){
                                print("In \(row) \(col) is in range to attack \(r) \(c)")
                            }
                        }
                    }
                }
            }
        }
    }
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
                if (board[row][col] != nil)&&((board[row][col]?.isSelected) != nil) {
                    
                    return "\(board[row][col]?.faction) \(String(describing: board[row][col]?.movementCount)) / \(String(describing: board[row][col]?.stamina))"
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
    
    func handleTap(row: Int, col: Int) {
        if isTapped == false {
            tappedLoc = Location(row: row, col: col)
        }else{
            if let tappedCol = tappedLoc?.col, let tappedRow = tappedLoc?.row, isPossibleLoc(row: row, col: col) {
                if var piece = board[tappedRow][tappedCol] {//If taps pice
                    if (piece.getCanMove() && !(board[row][col] != nil)){//Checks stamina and if a piece is already there
                        piece.incrementMoveCounter()
                        board[row][col] = piece
                        board[tappedRow][tappedCol] = nil//Erases original copy of player pieces moved.
                        findInRange()
                    }
                    if (piece.getCanMove() && board[row][col] != nil && board[row][col]?.faction == "Z"){
                        print("Attack")
                        board[row][col]?.health-=piece.damage
                        piece.incrementMoveCounter()
                    }
                }
            }
            
            tappedLoc = nil
        }
        isTapped.toggle()
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
    
    func findDistance()->(RowD : Int, ColD : Int, seekerLocation : Location){//This properly locates the targets.
        var seekerLoc = Location(row: 0, col: 0)
        var targetLoc = Location(row: 0, col: 0)
        var thingSighted = false
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col]?.faction=="Z") {//Locates seeker on the map
                    seekerLoc = Location(row: row, col: col)
//                    print("Seeker \(seekerLoc)")
                }
                if (board[row][col]?.faction=="S") {//Locates target on the map
                    targetLoc = Location(row: row, col: col)
//                    print("Target \(targetLoc)")
                    thingSighted=true
                }
            }
        }
        if thingSighted==false {
            targetLoc=seekerLoc
//            print("Nothing left")
        }
        
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    
//    func markTarget()->Location{
//        for r in safeNum(returnLocation.row-1)..<safeNum(returnLocation.row+2) {
//            for c in safeNum(returnLocation.col-1)..<safeNum(returnLocation.col+2) {
//                if (board[r][c] != nil&&(!(r==returnLocation.row&&c==returnLocation.col))){
//                    return Location(row: r, col: c)
//                }
//            }
//        }
//    }
    
    func seekFor()->Location{
        let distance = findDistance()
        
        var returnLocation = Location(row: distance.seekerLocation.row, col: distance.seekerLocation.col)
        
        if board[distance.seekerLocation.row][distance.seekerLocation.col]?.health ?? 0 <= 0{
            print("Enemy defeated")
            board[distance.seekerLocation.row][distance.seekerLocation.col] = nil
            return returnLocation
        }
        for r in safeNum(returnLocation.row-1)..<safeNum(returnLocation.row+2) {
            for c in safeNum(returnLocation.col-1)..<safeNum(returnLocation.col+2) {
                if (board[r][c] != nil&&(!(r==returnLocation.row&&c==returnLocation.col))){
//                    print("I am in range to attack.")
                    return returnLocation
                }
            }
        }
        if distance.RowD==0&&distance.ColD==0{
//            print("Should be stationary")
            return returnLocation
        }
        if distance.RowD > 0 {// Target row 2  Seeker row 1 = Distance is 1//Seeker shoudl go right
            returnLocation.row+=1
//            print("up")
        }
        else if distance.RowD < 0 {// Target row 1  Seeker row 2 = Distance is -1//Seeker should go left
            returnLocation.row-=1
//            print("down")
        }
        if distance.ColD < 0 {// Target row 1  Seeker row 2 = Distance is -1 // seeker should go up
            returnLocation.col-=1
//            print("left")
        }
        else if distance.ColD > 0 {// Target col 2  Seeker col 1 = Distance is 1//Seeker should go down
            returnLocation.col+=1
//            print("right")
        }
        //        if distance.RowD < 0 && distance.ColD < 0 {// Target row 1  Seeker row 2 = Distance is -1 // seeker should go up
        
        board[distance.seekerLocation.row][distance.seekerLocation.col] = nil
        //        }
//        print("From \(distance.seekerLocation) I go to \(returnLocation)")
        return returnLocation
    }
    
    func set(moveable: any Piece, location: Location) {
        guard locationIsValid(location: location) else { return }
        board[location.row][location.col] = moveable
        findInRange()
    }
    func nextTurn(){
        var seeker : Zombie?
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if ((board[row][col]?.faction=="Z")) {//ONLY TESTED TO WORK FOR ONE ZOMBIE
                    seeker = board[row][col] as? Zombie//designates seeker piece by where it encounters on the map
                }
            }
        }
        var counter = 0
        if seeker != nil{
            while(counter<seeker?.stamina ?? 0){
                set(moveable: seeker!, location:seekFor())
                counter+=1
            }
        }
        for row in 0..<rowMax {
            for col in 0..<colMax {
                if (board[row][col] != nil) {//If it encounters anything
                    board[row][col]?.movementCount = 0//Resets movement counter
                }
            }
        }
      
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
        print("\(piece.getMoves())")
        possibleLoc = piece.getMoves()
    }
    private func locationIsValid(location: Location) -> Bool {
        location.row >= 0 && location.row < rowMax && location.col >= 0 && location.col < colMax
    }
}


