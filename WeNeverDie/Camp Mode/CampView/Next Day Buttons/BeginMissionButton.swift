//
//  BeginMissionButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct BeginMissionButton: View {
    @Binding var surivorsSentOnMission: Int
    @ObservedObject var gameData: ResourcePool
    @State var degrees: Double = 0
    @Binding var showBoard: Bool
    @ObservedObject var stockpile : Stockpile = Stockpile.shared
    func checkSendMission()->Bool{
        return stockpile.getSurvivorSent() > 0
    }
    
    
    var body: some View {
    Button {
            withAnimation {
                degrees = degrees == 0 ? 180 : 0
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + (checkSendMission() ? 1.0 : 0)) {
                // Code you want to be delayed
                if checkSendMission() {
                    showBoard = true
                    gameData.audio.playSFX(.carStarting)
                }
                else {
                    gameData.passDay()
                }
            }
        } label: {
            VStack {
                //MARK: Mission Start
                    Image(checkSendMission() ? "Bus" : "Clock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .white, radius: checkSendMission() ? 5 : 15)
                    .rotation3DEffect(checkSendMission() ? .degrees(degrees) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                Text(checkSendMission() ? "Start Mission" : "Stay Inside")
                    .foregroundColor(.white)
                    .bold()
            }
        }.opacity(1)
            .padding()
            .frame(maxHeight: UIScreen.screenHeight * 0.4)
    }
}
struct BeginMissionButton_Previews: PreviewProvider {
    static var previews: some View {
        BeginMissionButton(surivorsSentOnMission: .constant(1), gameData: ResourcePool(), showBoard: .constant(false))
    }
}
