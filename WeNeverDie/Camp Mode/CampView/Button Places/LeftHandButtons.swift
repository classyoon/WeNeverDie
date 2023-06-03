//
//  LeftHandButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct LeftHandButtons: View {
    @Binding var showCureHelp : Bool
    @ObservedObject var gameData : ResourcePool
    @Binding var showBoard : Bool
    var body: some View {
        HStack {
            //MARK: Cure
           
            //survivorSelector(gameData: gameData)
            
            VStack{
                
                VStack{
                    TopButtons(gameData: gameData)
                    Spacer()
                }
                BeginMissionButton(gameData: gameData, showBoard: $showBoard).frame(maxHeight: 250)
            }
//                .frame(maxWidth: 70)
                .padding()
            Spacer()
            CureProgressView(gameData: gameData, uiSettings: gameData.uiSetting, showCureHelp: $showCureHelp)
                .foregroundColor(.primary).padding()
            
        }.padding()
            //.frame(maxHeight: UIScreen.screenHeight)
    }
}

struct LeftHandButtons_Previews: PreviewProvider {
    static var previews: some View {
        LeftHandButtons(showCureHelp: .constant(false), gameData: ResourcePool(), showBoard: .constant(false))
    }
}
