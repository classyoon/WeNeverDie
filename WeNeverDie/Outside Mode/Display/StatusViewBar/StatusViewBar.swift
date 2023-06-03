//
//  StatusViewBar.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/27/23.
//

import SwiftUI

struct StatusViewBar: View {
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    var testNight = false//vm.changeToNight
    var body: some View {
        VStack{
            TopButtons(gameData: gameData)
                .frame(maxWidth: 70)
                .padding()
            CountDown(vm: vm, uiSettings: gameData.uiSetting)
            Text("-- Collected --")
            HStack{
                FoodCounter(vm: vm)
                MaterialCounter(vm: vm)
            }
            Text("-- Search for --")
            HStack{
                SearchButton(vm: vm)
                SearchForMaterialsButton(vm: vm)
            }
            NextTurnButton(uiSettings: gameData.uiSetting, vm: vm)
            Text("\(vm.examinedPiece?.stamina ?? 0)")
        }
        .padding()
        .background(ZStack{Color.orange
            Color.secondary
                .opacity(!vm.changeToNight ? 0.1 : 2)
        })
        .cornerRadius(20)
        
        
    }
}

struct StatusViewBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusViewBar(vm: Board(), gameData: ResourcePool())
    }
}
