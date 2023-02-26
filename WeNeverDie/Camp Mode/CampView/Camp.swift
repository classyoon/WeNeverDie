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
    func campPassDay(){
        GameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sending \(GameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        GameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(GameData.survivorSent)")
    }
    
    func shouldShowMap() -> Bool{
        if surivorsSentOnMission > 0{
            return true
        }
        return false
    }

    var body: some View {
        NavigationStack{
            VStack{
                TopButtons()
                CampStats(GameData: GameData, ResetGame: ResetGame, surivorsSentOnMission: surivorsSentOnMission)
                Button("Pass Day") {
                    campPassDay()
                }
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
