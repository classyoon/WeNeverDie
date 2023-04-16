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
    var body: some View {
        HStack {
            //MARK: Cure
            
            VStack{
                TopButtons(gameData: gameData)
                Spacer()
            }
            .frame(maxWidth: 70)
            .padding()
            Spacer()
            
            CureProgressView(gameData: gameData, showCureHelp: $showCureHelp)
            
                .foregroundColor(.primary)
            
            
        }.padding()
            .frame(maxHeight: UIScreen.screenHeight)
    }
}

struct LeftHandButtons_Previews: PreviewProvider {
    static var previews: some View {
        LeftHandButtons(showCureHelp: .constant(false), gameData: ResourcePool())
    }
}
