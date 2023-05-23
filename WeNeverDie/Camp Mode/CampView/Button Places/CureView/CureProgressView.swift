//
//  CureProgressView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

import SwiftUI

struct CureProgressView: View {
    @ObservedObject var gameData : ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    @Binding var showCureHelp : Bool
    
    var body: some View {
        ZStack {
            HStack{
            uiSettings.switchToLeft ? Spacer() : nil
                VStack{
                    Button {
                        showCureHelp = true
                    } label: {
                        Image(systemName: gameData.gameCon.data.AlreadyWon ? "syringe.fill" : "syringe")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(maxHeight: 70)
                        
                    }.padding(.top)
                }
                !uiSettings.switchToLeft ? Spacer() : nil
            }
            Group{
                if showCureHelp {
                    CureProgressInfoView(showCure: $showCureHelp, buildingMan : gameData.buildingMan, stock : gameData.stockpile)
                }else{
                    Spacer()
                }
            }
        }
        
        
        
            
        
        
    }
}

struct CureProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CureProgressView(gameData: ResourcePool(), uiSettings: UserSettingsManager(), showCureHelp: .constant(true))
    }
}
