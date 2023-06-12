//
//  playerUnit.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI
struct playerUnit: Piece, Identifiable, Equatable, Codable{
    
    static func == (lhs: playerUnit, rhs: playerUnit) -> Bool {
        lhs.id == rhs.id
    }
    var isBeingSent = false
    var isRecruitable: Bool = false
    var isPlayerUnit = true
    var isAttackable: Bool = false
    var isZombie : Bool = false
    var isStruck = false
    var isDeceased = false
    var childhood : String
    var currentOccupation : String
    var daysAlive : Int = 0

    
    var isHidden = false
    
    var name : String
    var firstName : String
    var lastName : String
    var health: Int = 10
    var damage = 5
    var trust = 0
    var movementCount = 0
    var stamina =  2
    
    var isSelected = false
    var alert = false
    var facing: Direction = .down

    mutating func checkForUpgrade(){
        for building in BuildMan.buildings {
            if building.name == "Upgrade" && building.isComplete {
                stamina = 3
            }
        }
    }
    
    var id = UUID()
    
    var board: BoardProtocol
    var vectors: [Vector] = [
        Vector(row: 1, col: 1),
        Vector(row: 1, col: 0),
        Vector(row: 1, col: -1),
        Vector(row: 0, col: 1),
        Vector(row: 0, col: -1),
        Vector(row: -1, col: 1),
        Vector(row: -1, col: 0),
        Vector(row: -1, col: -1),
//        Vector(row: 2, col: 2),
//        Vector(row: 2, col: 0),
//        Vector(row: 2, col: -2),
//        Vector(row: 0, col: 2),
//        Vector(row: 0, col: -2),
//        Vector(row: -2, col: 2),
//        Vector(row: -2, col: 0),
//        Vector(row: -2, col: -2),
//        Vector(row: 3, col: 3),
//        Vector(row: 3, col: 0),
//        Vector(row: 3, col: -3),
//        Vector(row: 0, col: 3),
//        Vector(row: 0, col: -3),
//        Vector(row: -3, col: 3),
//        Vector(row: -3, col: 0),
//        Vector(row: -3, col: -3),
        
    ]
  
    
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
        let playerUnit = playerUnit(childhood: "Unknown", currentOccupation : "Tech Entreprenuer", name: "Steve Jobs", firstName: "Steve", lastName: "Jobs")
        playerUnit.getView()
            .previewLayout(.sizeThatFits)
    }
}
