//
//  Zombie.swift
//  BoardGame4
//
//  Created by Conner Yoon on 12/20/22.
//

import SwiftUI
struct Zombie: Piece {

    var isSelected = false
    var movementCount = 0
    
    var facing: Direction = .down
    let stamina = 3
    
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
        movementCount < stamina ? true : false
    }
    
    func getView() -> AnyView {
        AnyView(Image("Pawn")
            .resizable()
            .scaledToFit()
            
        )
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


