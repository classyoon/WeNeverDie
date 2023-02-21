//
//  GameWND.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI



struct GameView : View {
    @State var gameData = ResourcePool(surviors: 3, food: 10)
    @StateObject var camp  = Camp(field: Board(players: 3))
    @StateObject var board  = Board(players: 3)

    @State var showBoard = false
    @State var playerNumber = 3
    
    
    
    var body: some View {
        ZStack{
            VStack{
                if showBoard {
                    BoardView(showBoard: $showBoard, vm: board, GameData: gameData)
                    
                }
                else {
                    CampView(showBoard: $showBoard, GameData: gameData, vm: camp)
                }
            }
        }.onChange(of: showBoard) { newValue in
            if newValue {
                board.generateBoard(gameData.survivorNumber)
            }
        }
    }
}

