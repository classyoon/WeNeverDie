//
//  NightExitView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct NightExitView: View {
    var vm : Board
    let food : Int
    var gameData : ResourcePool
    @Binding var showBoard : Bool
    var unitsDied : Int
    var unitsRecruited : Int
    var presentChoices = false//Present user with two
    var constructor = BuildingViewConstructor.shared
    @ObservedObject var stockpile = Stockpile.shared
    var body: some View {
        VStack{
            Text("We survived the night. Let's not do that again. We gathered \(food) rations. That should leave us with \(gameData.stockpile.getNumOfFood()-gameData.stockpile.getNumOfPeople()+food) rations")
                    .font(.title).foregroundColor(Color.black)
                Button {
                    showBoard = false
                    gameData.passDay()
                    Stockpile.shared.transferResourcesToResourcePool(vm: vm)
                   
                    save(items: ResourcePoolData(resourcePool: gameData), key: key)
                    
                } label: {
                    Text("Back to Camp")
                }.buttonStyle(.borderedProminent)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
 
        }
    }
}

struct NightExitView_Previews: PreviewProvider {
    static var previews: some View {
        NightExitView(vm: Board(), food: 10, gameData: ResourcePool(), showBoard: .constant(false), unitsDied: 0, unitsRecruited: 0)
    }
}
