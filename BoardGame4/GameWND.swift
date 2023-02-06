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
    @Published var showView = true
  
    init() {
            self.camp = Camp()
            self.board = Board()
        }
    
}

struct GameView : View {
    @ObservedObject var vm = GameWND()
    func getCurrentView()-> AnyView {
        if vm.showView {
            return AnyView(BoardView(vm: vm.board))
        }
        else {
            return AnyView(CampView(vm: vm.camp))
        }
    }
    var body: some View {
        ZStack{
            VStack{
                getCurrentView()
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    vm.showView.toggle()
                }
            }
        }
    }
}

