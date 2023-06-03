//
//  CampInterface.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 6/3/23.
//

import SwiftUI

struct CampInterface: View {
    @Binding var showBoard: Bool
    @ObservedObject var gameData: ResourcePool
    @State var shouldResetGame = false
    @State var showCureHelp = false
    @Binding var surivorsSentOnMission: Int
    @State var degrees: Double = 0
    @ObservedObject var uiSettings: UserSettingsManager
    @State var gameCon : GameCondition = GameCondition.shared
    @State var stock : Stockpile = Stockpile.shared
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
//                HStack(spacing : 0){
//                VStack {
//                    Spacer()
                    //MARK: Stats
                    CampStats(gameData: gameData, shouldResetGame: $shouldResetGame, showBoard: $showBoard, uiSettings: gameData.uiSetting)
//                    survivorSelector(gameData: gameData)
//                    Spacer()
//                    HStack{
//                      
//                        BeginMissionButton(gameData: gameData, showBoard: $showBoard).frame(maxWidth: UIScreen.screenWidth * 0.4, maxHeight: UIScreen.screenHeight * 0.4)
//                        uiSettings.switchToLeft ? Spacer() : nil
//                    }
//                }
            
               
            !uiSettings.switchToLeft ? RightHandButtons(showCureHelp: $showCureHelp, showBoard: $showBoard, gameData: gameData) : nil
            uiSettings.switchToLeft ? LeftHandButtons(showCureHelp: $showCureHelp, gameData: gameData, showBoard: $showBoard) : nil
            
            
        }.background(
            Image("Campground")
                .resizable()
                .aspectRatio(contentMode: .fill))
    }
}

struct CampInterface_Previews: PreviewProvider {
    static var previews: some View {
        CampInterface(showBoard: Binding.constant(false), gameData: ResourcePool(), surivorsSentOnMission: Binding.constant(0), uiSettings: UserSettingsManager())
    }
}
