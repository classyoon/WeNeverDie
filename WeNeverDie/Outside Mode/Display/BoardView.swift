//
//  BoardView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/27/23.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var vm : Board
    
    
    var body: some View {
<<<<<<< HEAD
        HStack{
            GameBoard(vm: vm)
                .overlay{
                    !vm.missionUnderWay ?
                    ExitOverlayView(food: food, gameData: GameData, showBoard: $showBoard, unitsDied: vm.UnitsDied)
                    : nil
                    
                }
            StatusViewBar(food: $food, vm: vm)
        }.background(Color.black)
=======
      
            
          
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
            
       
>>>>>>> SAVE
    }
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(vm: Board(players: 1))
    }
}
