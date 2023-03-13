//
//  UnusedDefaultExitView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct UnusedDefaultExitView: View {
    var vm : Board
    let food : Int
    var gameData : ResourcePool
    @Binding var showBoard : Bool
    var unitsDied : Int
    var unitsRecruited : Int
    var body: some View {
            VStack{
                Text("End Mission : Gathered \(food) rations, total food for the day should be \(gameData.foodResource-gameData.survivorNumber+food)")
                    .font(.title).foregroundColor(Color.black)
                Button {
                    showBoard = false
                    print("Pre Pass Day Function -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                    gameData.passDay()
                    print("Post Pass Day Function -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                    gameData.foodResource += food
                    gameData.survivorNumber+=unitsRecruited
                    print("Adding -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                    gameData.survivorSent = 0
                    //gameData.survivorNumber -= unitsDied
                    print("Subtracting Deaths -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                    save(items: ResourcePoolData(resourcePool: gameData), key: key)
                    print("Saving Data -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                } label: {
                    Text("Back to Camp")
                }.buttonStyle(.borderedProminent)
                
            }.padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
        
    }
}

struct RegularExitView_Previews: PreviewProvider {
    static var previews: some View {
        UnusedDefaultExitView(vm: Board(), food: 20, gameData: ResourcePool(), showBoard: .constant(false), unitsDied: 2, unitsRecruited: 1)
    }
}
