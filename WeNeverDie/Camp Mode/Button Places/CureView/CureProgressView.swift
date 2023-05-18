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
                        Image(systemName: gameData.victory ? "syringe.fill" : "syringe")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(maxHeight: 70)
                        
                    }.padding(.top)
                    
                    VerticalProgressBar(progress: gameData.WinProgress, max: gameData.WinCondition)
                        .padding()
                        .animation(.easeInOut(duration: 3), value: gameData.WinProgress)
                }
                !uiSettings.switchToLeft ? Spacer() : nil
            }
            Group{
                if showCureHelp {
                    CureProgressInfoView(progress: $gameData.WinProgress, max: gameData.WinCondition, showCure: $showCureHelp)
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
