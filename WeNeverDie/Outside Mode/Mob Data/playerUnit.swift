//
//  playerUnit.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI
struct playerUnit: Piece, Identifiable, Equatable {
    var board: BoardProtocol
    
    static func == (lhs: playerUnit, rhs: playerUnit) -> Bool {
        lhs.id == rhs.id
    }
    var team: TypeMob = .playerUnit
    var isStruck = false
    var isHidden = false
    var health: Int = 10
    var damage = 5
    var trust = 0
    var movementCount = 0
    var stamina = (devMode ? 10 : 2)
    
    var isSelected = false
    var alert = false
    var facing: Direction = .down
    
    var id = UUID()
 
    var info : nameTag = nameTag(childhood: "Blank Childhood", currentOccupation: "Blank Occupation", firstName: "Blank First Name", lastName: "Blank Last Name")
    
    var vectors: [Vector] = [
        Vector(row: 1, col: 1),
        Vector(row: 1, col: 0),
        Vector(row: 1, col: -1),
        Vector(row: 0, col: 1),
        Vector(row: 0, col: -1),
        Vector(row: -1, col: 1),
        Vector(row: -1, col: 0),
        Vector(row: -1, col: -1)]
  
    
    func getCanMove()->Bool {
        movementCount < stamina ? true : false
    }
    
    func getView() -> Image {
        Image("SurvivorY")
           
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount)")
    }
}

struct playerUnit_Previews: PreviewProvider {
    static var previews: some View {
        let board = Board()
        let playerUnit = playerUnit(board: board, info: nameTag(childhood: "Blank Childhood", currentOccupation: "Blank Occupation", firstName: "Blank First Name", lastName: "Blank Last Name"))
        playerUnit.getView()
            .previewLayout(.sizeThatFits)
    }
}

struct nameTag : Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var childhood : String
    var currentOccupation : String
    var daysAlive : Int = 0
    var firstName : String
    var lastName : String
    var isDeceased = false
    var isBeingSent = false
    var name : String {
        firstName + " " + lastName
    }
}
