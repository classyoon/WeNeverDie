//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard : Bool
    @ObservedObject var gameData : ResourcePool
    @State var ResetGame = false
    @State var surivorsSentOnMission : Int

    
    

    var body: some View {
        NavigationStack{
            VStack{
                TopButtons(gameData: gameData)
                CampStats(gameData: gameData, ResetGame: $ResetGame, surivorsSentOnMission: surivorsSentOnMission, showBoard: $showBoard)
              
            } .navigationTitle("Your Camp")
                .overlay{
                    gameData.death ?
                    DefeatView(gameData: gameData)
                    : nil
                }
                .overlay{
                    (gameData.victory && gameData.AlreadyWon) ?
                    VictoryView(gameData: gameData)
                    : nil
                }
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), gameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission:  0)
    }
}
