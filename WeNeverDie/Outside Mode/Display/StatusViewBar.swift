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
    

    var body: some View {
        VStack{
            TopButtons(gameData: gameData)
                .frame(maxWidth: 70)
                .padding()
            Text(vm.changeToNight ? "It's night" : "\(vm.turnsOfDaylight-vm.turnsSinceStart) hrs til night").foregroundColor(vm.changeToNight ? Color.red : nil)
            Text("Food collected : \(vm.foodNew)")
                .foregroundColor(vm.changeToNight ? .white : .black)
            VStack(spacing: 30.0){
                Button {
                    
                    vm.searchLocationVM()

                } label: {
                    Text("Search")
                }
                .foregroundColor(vm.canAnyoneMove ? .white : .red)
                .buttonStyle(.borderedProminent)
                
                
                
            }
            HStack{
                Button {
                    withAnimation{vm.nextTurn()}
                    vm.turn = UUID()
                    
                } label: {
                    
                    Text("Next Turn").foregroundColor(Color.white)
                    
                        .padding()
                        .background(vm.canAnyoneMove ? .gray : .green)
                    
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20))
                }
                .buttonStyle(.plain)
                .shadow(color: vm.canAnyoneMove ? .clear : .green, radius: 5)
            }
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
