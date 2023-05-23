//
//  BadResultView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/8/23.
//

import SwiftUI

struct BadResultView: View {
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    @Binding var showBoard : Bool
    var body: some View {
        VStack{
            Text(gameData.stockpile.getNumOfPeople() != 1 ? "End Mission : Gathered \(vm.foodNew) pieces of food. Someone didn't make it though." : "It was agony...\nYou didn't make it...")
                .font(.title).foregroundColor(Color.black)
            Button {
                showBoard = false
                gameData.transferResourcesToResourcePool(vm: vm)
                gameData.passDay()
               
            } label: {
                Text(gameData.stockpile.getNumOfPeople() != 1 ? "Move on" : "Perish")
            }.buttonStyle(.borderedProminent)
            
        }.padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct BadResultView_Previews: PreviewProvider {
    static var previews: some View {
        BadResultView(vm: Board(), gameData: ResourcePool(), showBoard: .constant(true))
    }
}
