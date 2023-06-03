//
//  RightHandButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct RightHandButtons: View {
    @Binding var showCureHelp : Bool
    @Binding var showBoard : Bool
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        HStack {
            //MARK: Cure
            CureProgressView(gameData: gameData, uiSettings: gameData.uiSetting, showCureHelp: $showCureHelp)
                .foregroundColor(.primary).padding()
            //survivorSelector(gameData: gameData)
            Spacer()
            VStack{
                
                VStack{
                    TopButtons(gameData: gameData)
                    Spacer()
                }
                BeginMissionButton(gameData: gameData, showBoard: $showBoard).frame(maxHeight: 250)
            }
//                .frame(maxWidth: 70)
                .padding()

            
        }.padding()
//            .frame(maxHeight: UIScreen.screenHeight)
    }
}

struct RightHandButtons_Previews: PreviewProvider {
    static var previews: some View {
        RightHandButtons(showCureHelp: .constant(false), showBoard: .constant(false), gameData: ResourcePool())
    }
}
