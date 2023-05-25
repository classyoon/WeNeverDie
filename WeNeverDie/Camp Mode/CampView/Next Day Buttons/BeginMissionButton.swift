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
    var canSendMission: Bool {
        surivorsSentOnMission != 0
    }
    
    var body: some View {
    Button {
            withAnimation {
                degrees = degrees == 0 ? 180 : 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // Code you want to be delayed
                showBoard = true
                gameData.audio.playSFX(.carStarting)
              
            }
        } label: {
            VStack {
                //MARK: Mission Start
                Image("Bus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .white, radius: canSendMission ? 5 : 0)
                    .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
                Text("Start Mission")
                    .foregroundColor(.white)
                    .bold()
            }
        }.disabled(!canSendMission)
            .opacity(canSendMission ? 1 : 0.6)
            .padding()
            .frame(maxHeight: UIScreen.screenHeight * 0.4)
    }
}
struct BeginMissionButton_Previews: PreviewProvider {
    static var previews: some View {
        BeginMissionButton(surivorsSentOnMission: .constant(1), gameData: ResourcePool(), showBoard: .constant(false))
    }
}
