//
//  BoardView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/27/23.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var vm : Board
    
    @Namespace var nameSpace : Namespace.ID
    var body: some View {

          
            GeometryReader { geo in
                ScrollView{
                    VStack(spacing: 0) {
                        ForEach(0..<vm.rowMax, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<vm.colMax, id: \.self) { col in
                                    TilePieceDisplay(row: row, col: col, vm: vm)
                                }
                            }
                        }
                    }
                    .id(vm.turn)
                }
            }
            
    }
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(vm: Board(players: 1))
    }
}
