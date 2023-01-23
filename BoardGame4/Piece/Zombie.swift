//
//  Zombie.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/20/22.
//

import SwiftUI
struct Zombie: Piece {
    var health = 10
    var damage = 3
    var alert = false
    
    var isNPC = true
    var isSelected = false
    var movementCount = 0
    var faction = "Z"
    
    var facing: Direction = .up
    let stamina = 1
    
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
    
    func getView() -> AnyView {
        AnyView(Image(alert ? "AgroZombie" : "Zombie")
            .resizable()
            .scaledToFit()
                
        )
        
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


