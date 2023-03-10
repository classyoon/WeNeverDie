//
//  ExitOverlayView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct ExitOverlayView: View {
    var vm : Board
    let food : Int
    var gameData : ResourcePool
    @Binding var showBoard : Bool
    var unitsDied : Int
    var unitsRecruited : Int
    var body: some View {
        VStack{
            Text(vm.changeToNight ? "End Mission : Gathered \(food) rations, total food for the day should be \(gameData.foodResource-gameData.survivorNumber+food)" : "We survived the night, but lost some food")
                .font(.title).foregroundColor(Color.black)
            Button {
                print("Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                showBoard = false
                
                gameData.foodResource += (vm.changeToNight ? food : food/2)
                gameData.passDay()
                gameData.survivorNumber+=unitsRecruited
                
                //musicPlayer?.stop()
                
                
                //gameData.foodResource -= gameData.survivorNumber
                
                gameData.survivorSent = 0
                gameData.survivorNumber -= unitsDied
                print("Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                save(items: ResourcePoolData(resourcePool: gameData), key: key)
            } label: {
                Text("Back to Camp")
            }.buttonStyle(.borderedProminent)
            
        }.padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct ExitOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ExitOverlayView(vm: Board(players: 1), food: 20, gameData: ResourcePool(surviors: 10, food: 10), showBoard: .constant(false), unitsDied: 2, unitsRecruited: 1)
    }
}
