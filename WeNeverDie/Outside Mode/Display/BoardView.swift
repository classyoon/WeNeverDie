//
//  BoardView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/27/23.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var gameData: ResourcePool
    @ObservedObject var vm: Board

    

    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0..<vm.rowMax, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<vm.colMax, id: \.self) { col in
                            TilePieceDisplay(gameData: gameData, row: row, col: col, vm: vm)
                        }
                    }
                }
            }
            .frame(width: CGFloat(vm.size))
            .id(vm.turn)
            
        }
    }
}


struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(gameData: ResourcePool(), vm: Board())
    }
}
