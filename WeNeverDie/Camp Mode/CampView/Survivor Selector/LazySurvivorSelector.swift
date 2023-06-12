//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct LazySurvivorSelector: View {
    
    @ObservedObject var GameData: ResourcePool
    @ObservedObject var uiSettings : UserSettingsManager
    @ObservedObject var stock = Stockpile.shared
    var body: some View {
        
        HStack{
            ForEach(0..<stock.getNumOfPeople()-stock.getBuilders(), id: \.self){ index in
                VStack{
                    
                    Button {
                        
                        GameData.balance(index)
                        
                    } label: {
                        
                        Image(systemName: uiSettings.isUsingLeftHandedInterface ?
                              (index >= GameData.displayOfSelectedIcons.count -  Stockpile.shared.getSurvivorSent() ? "person.fill" : "person") :
                                (index < Stockpile.shared.getSurvivorSent() ? "person.fill" : "person")) .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        
                    }
                    HStack{
                        Menu(Stockpile.shared.stockpileData.rosterOfSurvivors[index].name) {
                            ForEach(0..<stock.stockpileData.rosterOfSurvivors.count){ current in
                                if current != index {
                                    Button(stock.stockpileData.rosterOfSurvivors[current].name){
                                        let tempSurvivor = stock.stockpileData.rosterOfSurvivors[index]
                                        let tempStatus = stock.stockpileData.rosterOfSurvivors[index].isBeingSent
                                        let secondTempStatus = stock.stockpileData.rosterOfSurvivors[current].isBeingSent
                                        
                                        stock.stockpileData.rosterOfSurvivors[index] = stock.stockpileData.rosterOfSurvivors[current]
                                        stock.stockpileData.rosterOfSurvivors[current] = tempSurvivor
                                        stock.stockpileData.rosterOfSurvivors[current].isBeingSent = secondTempStatus
                                        stock.stockpileData.rosterOfSurvivors[index].isBeingSent = tempStatus
                                        
                                    }
                                }
                            }
                        }
                        Button {
                            GameData.viewedPiece = stock.stockpileData.rosterOfSurvivors[index]
                            GameData.displayInfo = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }.buttonStyle(.bordered)
                }
                
            }
        }
        
    }
}
struct LazySurvivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        LazySurvivorSelector(GameData: ResourcePool(), uiSettings: UserSettingsManager())
    }
}

