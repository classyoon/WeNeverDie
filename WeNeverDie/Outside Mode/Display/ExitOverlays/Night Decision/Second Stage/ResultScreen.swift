//
//  ResultScreen.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/19/23.
//

import SwiftUI


struct ResultScreen: View {
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    @Binding var showBoard : Bool
    var body: some View {
        VStack{
            Text(gameData.survivorSent > 1 ? "You sprinted as fast as you could, hopping inside your van and slamming the accelerator. You made it with \(vm.foodNew) pieces of food." : "Y'all sprinted and y'all made it back with \(vm.foodNew) pieces of food")
                .font(.title).foregroundColor(Color.black)
            Button {
                showBoard = false
                gameData.transferResourcesToResourcePool(vm: vm)
                gameData.passDay()
               
            } label: {
                Text("Return to Camp")
            }.buttonStyle(.borderedProminent)
            
        }.padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen(vm: Board(), gameData: ResourcePool(surviors: 2, food: 10), showBoard: .constant(true))
    }
}

