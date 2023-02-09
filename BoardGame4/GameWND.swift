//
//  GameWND.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI



struct GameView : View {
 
    @StateObject var camp  = Camp()
    @StateObject var board  = Board()
    @State var showBoard = true
    var body: some View {
        ZStack{
            VStack{
                if showBoard {
                    BoardView(showBoard: $showBoard, vm: board)
                }
                else {
                    CampView(showBoard: $showBoard, vm: camp)
                }
            }
        }.onChange(of: showBoard) { newValue in
            if newValue {
               board.generateBoard()
            }
        }
    }
}

