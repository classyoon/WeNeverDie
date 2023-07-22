//
//  Zombie.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 12/20/22.
//

import SwiftUI
struct Zombie: Piece, Equatable {
    var info: nameTag = nameTag(childhood: "Unknown", currentOccupation: "Infected", firstName: "Unknown", lastName: "Unknown")
    
    
    static func == (lhs: Zombie, rhs: Zombie) -> Bool {
        lhs.id == rhs.id
    }
    var team: TypeMob = .zombieUnit
    var isHidden = false
    var isStruck = false
 
   
    var health = 10
    var damage = (devMode ? 0 : 3)
    var alert = false
    let stamina = 1
    var movementCount = 0
    var trust = 0
    
    var isSelected = false
    var facing: Direction = .up
   
    
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
        
    ]
    
    func getCanMove()->Bool {
        //        print("I have taken \(movementCount) moves, while my limit is \(stamina)")
        return movementCount < stamina ? true : false
        
    }
    
    func getView() -> Image {
        Image(alert ? "AgroZombie" : "SZombie")
    }
    func getStats() -> any View {
        return Text("H : \(health), S: \(stamina-movementCount)")
    }
    
    
}

struct Zombie_Previews: PreviewProvider {
    static var previews: some View {
        let board = Board()
        let zombie = Zombie(board: board)
        zombie.getView()
            .previewLayout(.sizeThatFits)
    }
}


