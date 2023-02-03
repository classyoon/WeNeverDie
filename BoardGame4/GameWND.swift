//
//  GameWND.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI


class GameWND : ObservableObject {
    
    var camp : Camp
    var board : Board
    
    var showBoard = true
    
    init() {
        self.camp = Camp()
        self.board = Board()
    }
    
    func toggleMode(){
        showBoard.toggle()
    }
  
}

struct GameView : View {
    
    var vm = GameWND()
    func getCurrentView()-> AnyView {
        if vm.showBoard {
            return AnyView(BoardView(vm: Board(), game: vm))
        }
        else {
            return AnyView(CampView(game: vm))
        }
    }
    var body: some View {
        ZStack{
            getCurrentView()
            
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
