//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard: Bool
    @ObservedObject var GameData: ResourcePool
    @State var ResetGame = false
    @State var surivorsSentOnMission: Int

    func campPassDay() {
        GameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sending \(GameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        GameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(GameData.survivorSent)")
    }

    func shouldShowMap() -> Bool {
        if surivorsSentOnMission > 0 {
            return true
        }
        return false
    }

    var body: some View {
        NavigationStack {
            VStack {
                TopButtons()
                    .padding()
                    .frame(maxHeight: 70)
                Spacer()
                CampStats(GameData: GameData, ResetGame: ResetGame, surivorsSentOnMission: surivorsSentOnMission)
                Spacer()
                Button {
                    campPassDay()
                } label: {
                    VStack {
                        Image(systemName: "bed.double.circle.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(.white)
                        Text("I should try to Sleep. Tomorrow's zombies can wait.")
                    }
                }.padding()
                    .frame(maxHeight: 100)
            }.padding()
                .background(
                    Image("Campground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(GameData.death || GameData.victory ? 0.5 : 1)
                ).ignoresSafeArea()

                .blur(radius: GameData.death || GameData.victory ? 10 : 0)
                .overlay {
                    GameData.death ?
                        DefeatView(GameData: GameData)
                        .padding()
                        : nil
                }
                .overlay {
                    (GameData.victory && GameData.AlreadyWon) ?
                        VictoryView(GameData: GameData)
                        .padding()
                        : nil
                }
        }.foregroundColor(.white)
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission: 0)
    }
}
