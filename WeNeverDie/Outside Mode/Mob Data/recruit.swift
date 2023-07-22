//
//  recruit.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct recruit: Piece, Identifiable, Equatable {
    var team: TypeMob = .recruitableUnit
    var info = nameTag(childhood: "Unknown", currentOccupation: "Infected", firstName: "Unknown", lastName: "Unknown")
    static func == (lhs: recruit, rhs: recruit) -> Bool {
        lhs.id == rhs.id
    }
    var trust = 0
    var alert: Bool = false
    var id = UUID()
   
    
    var isHidden: Bool = true
    
    var isSelected: Bool = false
    
    var health: Int = 10
    
    var damage: Int = 5
    var isStruck = false
    var board: BoardProtocol
    var vectors: [Vector] = [
        Vector(row: 1, col: 1),
        Vector(row: 1, col: 0),
        Vector(row: 1, col: -1),
        Vector(row: 0, col: 1),
        Vector(row: 0, col: -1),
        Vector(row: -1, col: 1),
        Vector(row: -1, col: 0),
        Vector(row: -1, col: -1)
    ]
    
    var facing: Direction = .down
    
    var stamina: Int = 3
    
    var movementCount: Int = 0
    
   
    
    func getCanMove()->Bool {
        movementCount < stamina ? true : false
    }
    
    func getView() -> Image {
        Image("SurvivorW")
           
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount), T: \(trust)")
    }
}

struct recruit_Previews: PreviewProvider {
    static var previews: some View {
        let board = Board()
        let recruitUnit = recruit(board: board)
        recruitUnit.getView()
            .previewLayout(.sizeThatFits)
    }
}
