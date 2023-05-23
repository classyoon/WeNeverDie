//
//  GameWND.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI

let key = "game data"
struct GameView: View {
    @ObservedObject var gameData: ResourcePool
    @ObservedObject var board: Board
    @State var showBoard = outsideTesting && devMode ? true : false
    var body: some View {
        ZStack {
            VStack {
                
                if !gameData.gameCon.data.hasViewedTutorial {
                    TutorialView(gameData: gameData, seenTutorialBool: gameData.gameCon.data.hasViewedTutorial)
                }
                else if  showBoard {
                    // Show the tutorial
                    OutsideView(showBoard: $showBoard, vm: gameData.generateMap(), gameData: gameData, uiSettings: gameData.uiSetting)
                }
                else {
                    CampView(showBoard: $showBoard, gameData: gameData, surivorsSentOnMission: $gameData.survivorSent, uiSettings: gameData.uiSetting)
                }
            }
        }.onChange(of: showBoard) { newValue in
            if newValue {
                print("Survivors Sent : \(gameData.survivorSent)")
                gameData.isInMission = true
                board.generateBoard(gameData.survivorSent)
               
            }
        }
    }
}
