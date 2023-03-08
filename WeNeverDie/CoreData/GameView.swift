//
//  GameWND.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI
var devMode = false

//struct MainView: View {
//
//    var body: some View {
//        GameView(gameData: ResourcePool(surviors: 3, food: 10)
//    }
//}
struct GameView: View {
    @ObservedObject var gameData: ResourcePool
    @ObservedObject var board: Board
    @State var showBoard = false
    @State var playerNumber = 3


    var body: some View {
        ZStack {
            VStack {
                if showBoard {
                    OutsideView(showBoard: $showBoard, vm: gameData.generateMap(), gameData: gameData)
                }
                else {
                    CampView(showBoard: $showBoard, gameData: gameData, surivorsSentOnMission: $gameData.survivorSent).onChange(of: gameData.shouldResetGame) { newValue in
                        if newValue {
                            gameData.reset()
                        }
                    }
                }
            }
        }.onChange(of: showBoard) { newValue in
            if newValue {
                board.generateBoard(gameData.survivorSent)
            }
        }
    }
}
