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
    
    let rowMax: Int = 8
    let colMax: Int = 8
    func reset()->Board{
        Board()
    }
    init(){
        board = Array(repeating: Array(repeating: nil, count: rowMax), count: colMax)
        //        set(moveable: Checker(board: self), location: Location(row: 1, col: 1))
        //        set(moveable: Pawn(board: self), location: Location(row: 4, col: 4))
        //        set(moveable: Knight(board: self), location: Location(row: 5, col: 2))
        
    
        
               
        //Issue Set
        /** Visual Representation, T is target. S is seeker
        T  *  *
        * * *
        * *  S
         */
        set(moveable: King(board: self), location: Location(row: 0, col: 0))
        set(moveable: Zombie(board: self), location: Location(row: 6, col: 0))
//        set(moveable: King(board: self), location: Location(row: 6, col: 6))
//        set(moveable: Zombie(board: self), location: Location(row: 0, col: 0))
      
        /**
        Pattern Observation. Whenever seeker is on the right and there is a difference in **vertical, the 'y' cordinate (within this intializer it is defined by column, (oddly enough), elsewhere it should be defined by row)**.
         */
    }
}

extension Board {
    // MARK: Not private
    
    
    
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
                    if piece.getCanMove() {
                        piece.incrementMoveCounter()
                        board[row][col] = piece
                        board[tappedRow][tappedCol] = nil//Erases original copy of player pieces moved.
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
                    print("Seeker \(seekerLoc)")
                }
                if (board[row][col]?.faction=="S") {//Locates target on the map
                    targetLoc = Location(row: row, col: col)
                    print("Target \(targetLoc)")
                    thingSighted=true
                }
            }
        }
        if thingSighted==false {
            targetLoc=seekerLoc
            print("Nothing left")
        }
        //print("I see row distance \(targetLoc.row-seekerLoc.row), col distance \(targetLoc.col-seekerLoc.col), I am at \(seekerLoc)")
        return (targetLoc.row-seekerLoc.row, targetLoc.col-seekerLoc.col, seekerLoc)//returns the distance
    }
    
    func seekFor()->Location{/**IMPORTANT to work on
                              A very basic and glitchy path finding algorithem. It is not callibrated correctly.
                              
                              */
        //targetPlace.col - seekerPlace.col
        let distance = findDistance()
        var returnLocation = Location(row: distance.seekerLocation.row, col: distance.seekerLocation.col)
        
        if distance.RowD==0&&distance.ColD==0{
            print("Should be stationary")
            return returnLocation
        }
        if distance.RowD > 0 {// Target row 2  Seeker row 1 = Distance is 1//Seeker shoudl go right
            returnLocation.row+=1
            print("left")
        }
        else if distance.RowD < 0 {// Target row 1  Seeker row 2 = Distance is -1//Seeker should go left
            returnLocation.row-=1
            print("right")
        }
        if distance.ColD < 0 {// Target row 1  Seeker row 2 = Distance is -1 // seeker should go up
            returnLocation.col-=1
            print("up")
        }
        else if distance.ColD > 0 {// Target col 2  Seeker col 1 = Distance is 1//Seeker should go down
            returnLocation.col+=1
            print("down")
        }
//        if distance.RowD < 0 && distance.ColD < 0 {// Target row 1  Seeker row 2 = Distance is -1 // seeker should go up
            board[distance.seekerLocation.row][distance.seekerLocation.col] = nil
//        }
        print("From \(distance.seekerLocation) I go to \(returnLocation)")
        return returnLocation
    }
    
    func set(moveable: any Piece, location: Location) {
        guard locationIsValid(location: location) else { return }
        board[location.row][location.col] = moveable
    }
    func nextTurn(){
        var seeker : Zombie?

        var originalLocation : Location?
        var rowS = 0
        var colS = 0
        for row in 0..<rowMax {
            for col in 0..<colMax {
                //                print("Checking \(row) \(col)")
                if ((board[row][col]?.faction=="Z")) {//Identifies the first NPC it meets as a seeker
                    seeker = board[row][col] as? Zombie//designates seeker piece by where it encounters on the map
//                    rowS = row
//                    colS = col
//                    originalLocation = Location(row: row, col: col)
                }
            }
        }
        
        //
 var counter = 0
        if seeker != nil{
            while(counter<seeker?.stamina ?? 0){
                set(moveable: seeker!, location:seekFor())
                counter+=1
            }
        }
        
//        var newLocation : Location?
//        for row in 0..<rowMax {
//            for col in 0..<colMax {
//                //                print("Checking \(row) \(col)")
//                if ((board[row][col]?.faction=="Z")) {//Identifies the first NPC it meets as a seeker
//                    seeker = board[row][col] as? Zombie//designates seeker piece by where it encounters on the map
//                    newLocation = Location(row: row, col: col)
//                }
//            }
//        }
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


