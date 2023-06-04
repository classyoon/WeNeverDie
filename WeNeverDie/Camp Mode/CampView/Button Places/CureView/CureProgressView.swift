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
    var constructor = BuildingViewConstructor.shared
    @ObservedObject var buildingMan : BuildingManager = BuildingManager.shared
    func giveWhichImage()->String{
        if !buildingMan.allBuildingAreMaintained && buildingMan.isABuildingCompleted {
            return "Hammer Both"
        }
        if buildingMan.isABuildingCompleted{
            return "Hammer Complete"
        }
        if !buildingMan.allBuildingAreMaintained{
            return "Hammer Issue"
        }
        return "Hammer"
    }
    func printImage(){
        print(giveWhichImage())
    }
    var body: some View {
        ZStack {
            HStack{
            uiSettings.switchToLeft ? Spacer() : nil
                VStack{
                    Button {
                        printImage()
                        showCureHelp = true
                    } label: {
                        Image(giveWhichImage())
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(maxHeight: 100)
                        
                    }.padding(.top)
                }
                !uiSettings.switchToLeft ? Spacer() : nil
            }
            Group{
                if showCureHelp {
                    CureProgressInfoView(showCure: $showCureHelp, stock : gameData.stockpile)
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
