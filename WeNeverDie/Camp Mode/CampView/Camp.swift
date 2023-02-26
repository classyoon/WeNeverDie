//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard : Bool
    @ObservedObject var GameData : ResourcePool
    @State var ResetGame = false
    @State var surivorsSentOnMission : Int

    
    

    var body: some View {
        NavigationStack{
            VStack{
                TopButtons()
                CampStats(GameData: GameData, ResetGame: $ResetGame, surivorsSentOnMission: surivorsSentOnMission, showBoard: $showBoard)
              
            } .navigationTitle("Your Camp")
                .overlay{
                    GameData.death ?
                    DefeatView(GameData: GameData)
                    : nil
                }
                .overlay{
                    (GameData.victory && GameData.AlreadyWon) ?
                    VictoryView(GameData: GameData)
                    : nil
                }
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission:  0)
    }
}
