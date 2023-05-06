//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard: Bool
    @ObservedObject var gameData: ResourcePool
    @State var shouldResetGame = false
    @State var showCureHelp = false
    @Binding var surivorsSentOnMission: Int
    @State var degrees: Double = 0
    @ObservedObject var uiSettings: UserSettingsManager
    // TODO: remove Timer from production. for testing purposes only
    //    let timer = Timer.publish(every: 10, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                VStack {
                    Spacer()
                    //MARK: Stats
                    CampStats(gameData: gameData, shouldResetGame: $shouldResetGame, surivorsSentOnMission: $surivorsSentOnMission, showBoard: $showBoard, uiSettings: gameData.uiSetting)
                    Spacer()
                    PassDayButton(surivorsSentOnMission: $surivorsSentOnMission, gameData: gameData, showBoard: $showBoard)
                }
                HStack{
                    BeginMissionButton(surivorsSentOnMission: $surivorsSentOnMission, gameData: gameData, showBoard: $showBoard)
                    uiSettings.switchToLeft ? Spacer() : nil
                }
                !uiSettings.switchToLeft ? RightHandButtons(showCureHelp: $showCureHelp, gameData: gameData) : nil
                uiSettings.switchToLeft ? LeftHandButtons(showCureHelp: $showCureHelp, gameData: gameData) : nil
                
            }
            //MARK: Background
            .background(
                Image("Campground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.opacity(gameData.death || gameData.victory ? 0.5 : 1)
            ).ignoresSafeArea()
            
                .blur(radius: gameData.death || (gameData.victory && !gameData.AlreadyWon) ? 10 : 0)
            //MARK: Death
                .overlay {
                    gameData.death ?
                    DefeatView(gameData: gameData, uiSettings: uiSettings)
                        .padding()
                    : nil
                }.foregroundColor(.white)
            //MARK: Victory
                .overlay {
                    (gameData.victory && !gameData.AlreadyWon) ?
                    HStack {
                        Spacer()
                        VictoryView(gameData: gameData)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                        Spacer()
                    }
                    : nil
                }
       
        }
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), gameData: ResourcePool(), surivorsSentOnMission: Binding.constant(0), uiSettings: UserSettingsManager())
    }
}






