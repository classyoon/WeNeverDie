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
    @ObservedObject var buildMan : BuildingManager
    var body: some View {
        ZStack {
            VStack {
                
                if gameData.gameCon.data.hasViewedTutorial {
                    TutorialView(gameData: gameData, seenTutorialBool: gameData.gameCon.data.hasViewedTutorial)
                }
                else if  showBoard {
                    // Show the tutorial
                    OutsideView(showBoard: $showBoard, vm: gameData.generateMap(), gameData: gameData, uiSettings: gameData.uiSetting)
                }
                else {
                    CampView(showBoard: $showBoard, gameData: gameData, surivorsSentOnMission: $gameData.stockpile.stockpileData.survivorSent, uiSettings: gameData.uiSetting).onAppear{
                        buildMan.saveAll()
                    }
                }
            }
        }.onChange(of: showBoard) { newValue in
            if newValue {
                gameData.isInMission = true
                board.generateBoard(gameData.stockpile.getSurvivorSent())
               
            }
        }
    }
}
/*
 @State var advancementBuilding = load(key: "lab") ?? AdvancementData(name: "Lab", workCost: 20, materialCost: 10, techBranch: [BuildingData( name: "Cure", workCost: 50), BuildingData(name: "Upgrade", workCost: 10)])
 @State var farm = load(key: "farm") ?? ProducerData(name: "Farm", workCost: 10, materialCost : 10, rate: 3, produces: .food)
 @State var house = load(key: "house") ?? ProducerData(name: "House", workCost: 20, rate: 1, produces: .people)
 @State var mine = load(key: "mine") ?? ProducerData(name: "Mine", workCost: 10, rate: 3, produces: .material)
 */
