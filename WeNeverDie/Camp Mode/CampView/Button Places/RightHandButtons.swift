//
//  RightHandButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct RightHandButtons: View {
    @Binding var showCureHelp : Bool
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        HStack {
            //MARK: Cure
            CureProgressView(gameData: gameData, uiSettings: gameData.uiSetting, showCureHelp: $showCureHelp, vm:gameData.buildVm)
                .foregroundColor(.primary)
            Spacer()
            VStack{
                TopButtons(gameData: gameData)
                Spacer()
            }
                .frame(maxWidth: 70)
                .padding()

            
        }.padding()
            .frame(maxHeight: UIScreen.screenHeight)
    }
}

struct RightHandButtons_Previews: PreviewProvider {
    static var previews: some View {
        RightHandButtons(showCureHelp: .constant(false), gameData: ResourcePool())
    }
}
