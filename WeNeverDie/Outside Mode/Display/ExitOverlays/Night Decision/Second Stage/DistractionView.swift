//
//  DistractionView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/8/23.
//

import SwiftUI

struct DistractionView: View {
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    @Binding var showBoard : Bool
    @ObservedObject var stockpile = Stockpile.shared
    var body: some View {
        VStack{
            Text(stockpile.getSurvivorSent() > 1 ? "You set up a little piece of bait with your \(returnDescriptor())food. You made it with \(vm.foodNew) pieces of food." : "Y'all sprinted and y'all made it back with \(vm.foodNew) pieces of food")
                .font(.title).foregroundColor(Color.black)
            Button {
                showBoard = false
                stockpile.transferResourcesToResourcePool(vm: vm)
                gameData.passDay()
               
            } label: {
                Text("Return to Camp")
            }.buttonStyle(.borderedProminent)
            
        }.padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
    func returnDescriptor() -> String{
        let totalNumOfSurvivors = stockpile.getNumOfPeople()+vm.UnitsRecruited-vm.UnitsDied
        
        if (stockpile.getNumOfFood()+vm.foodNew) - (totalNumOfSurvivors) >= totalNumOfSurvivors{
            return " precious "
        }
        return ""
    }
}

struct DistractionView_Previews: PreviewProvider {
    static var previews: some View {
        DistractionView(vm: Board(), gameData: ResourcePool(), showBoard: .constant(false))
    }
}
