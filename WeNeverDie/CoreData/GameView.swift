//
//  GameWND.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI

struct GameView: View {
    @State var gameData = ResourcePool(surviors: 3, food: 10)
    @StateObject var board = Board(players: 0)
    @State var showBoard = false
    @State var playerNumber = 3

    var body: some View {
        ZStack {
            VStack {
                if showBoard {
                    OutsideView(showBoard: $showBoard, vm: gameData.generateMap(), GameData: $gameData)
                }
                else {
                    CampView(showBoard: $showBoard, gameData: gameData, surivorsSentOnMission: $gameData.survivorSent).onChange(of: gameData.ResetGame) { newValue in
                        if newValue {
                            gameData = ResourcePool(surviors: 3, food: 10)
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
