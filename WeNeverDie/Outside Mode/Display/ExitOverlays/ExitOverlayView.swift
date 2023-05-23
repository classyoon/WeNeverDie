//
//  ExitOverlayView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI
// TODO: Move this to resource pool
struct ExitOverlayView: View {
    var vm : Board
    @ObservedObject var gameData : ResourcePool
    @ObservedObject var stockpile : Stockpile
    @Binding var showBoard : Bool
    var unitsDied : Int
    var unitsRecruited : Int
    var body: some View {
        VStack{
            Text("End Mission : Gathered \(vm.foodNew) rations, total food for the day should be \(stockpile.getNumOfFood()-stockpile.getNumOfPeople()+vm.foodNew)")
                .font(.title).foregroundColor(Color.black)
            Button {
                vm.showEscapeOption = false
                showBoard = false
    
                gameData.passDay()
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
        ExitOverlayView(vm: Board(), gameData: ResourcePool(), stockpile: Stockpile(), showBoard: .constant(false), unitsDied: 2, unitsRecruited: 1)
    }
}


/*
 func transferResourcesToResourcePool(){
     print("Adding -> Food : \(gameData.foodStored)")
     gameData.foodStored += vm.foodNew
     print("Result -> Food : \(gameData.foodStored)")
     
     gameData.survivorNumber+=unitsRecruited
     
     gameData.survivorSent = 0
     
     gameData.isInMission = false
     print("Subtracting Deaths -> Survivors : \(gameData.survivorNumber)")
     gameData.survivorNumber-=vm.UnitsDied
     print("Result -> Survivors : \(gameData.survivorNumber)")
     
     print("Saving Data -> Food : \(gameData.foodStored) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
     save(items: ResourcePoolData(resourcePool: gameData), key: key)
 }
 */
