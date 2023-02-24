//
//  playerUnit.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI
struct playerUnit: Piece, Identifiable, Equatable{
    
    static func == (lhs: playerUnit, rhs: playerUnit) -> Bool {
        lhs.id == rhs.id
    }
    
var isPlayerUnit = true
    var name : String
    var health: Int = 10
    var damage = 5
    var faction: String = "S"
    var isHidden = false
    var isSelected = false
    var movementCount = 0
    var alert = false
    var facing: Direction = .down
    let stamina = 2
    
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
    
    func getView() -> AnyView {
        AnyView(Image("SurvivorY")
            .resizable()
            .scaledToFit()
                
        )
        
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount)")
    }
}

struct playerUnit_Previews: PreviewProvider {
    static var previews: some View {
        let board = Board(players: 1)
        let playerUnit = playerUnit(name: "Steve Jobs", board: board)
        playerUnit.getView()
            .previewLayout(.sizeThatFits)
    }
}

