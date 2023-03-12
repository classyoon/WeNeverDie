//
//  GameWND.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI
var devMode = false


let key = "game data"
struct GameView: View {
    @ObservedObject var gameData: ResourcePool
    @ObservedObject var board: Board
    @State var showBoard = false
    
    var body: some View {
        ZStack {
            VStack {
                
                if !gameData.hasViewedTutorial {
                    TutorialView(gameData: gameData)
                    
                }
                else if  showBoard {
                    // Show the tutorial
                    OutsideView(showBoard: $showBoard, vm: gameData.generateMap(), gameData: gameData)
                }
                else {
                    CampView(showBoard: $showBoard, gameData: gameData, surivorsSentOnMission: $gameData.survivorSent)
                        .onChange(of: gameData.shouldResetGame) { newValue in
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
