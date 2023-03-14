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
    func transferResourcesToResourcePool(){
        print("Adding -> Food : \(gameData.foodResource)")
        gameData.foodResource += food
        print("Result -> Food : \(gameData.foodResource)")
        
        gameData.survivorNumber+=unitsRecruited
        
        gameData.survivorSent = 0
        
        
        print("Subtracting Deaths -> Survivors : \(gameData.survivorNumber)")
        gameData.survivorNumber-=vm.UnitsDied
        print("Result -> Survivors : \(gameData.survivorNumber)")
        
        print("Saving Data -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
        save(items: ResourcePoolData(resourcePool: gameData), key: key)
    }
    var body: some View {
        VStack{
            Text(!vm.changeToNight ? "End Mission : Gathered \(food) rations, total food for the day should be \(gameData.foodResource-gameData.survivorNumber+food)" : "We made it back, or we survived till dawn. Let's not do that again. Feature coming soon.")
                .font(.title).foregroundColor(Color.black)
            Button {
                
                showBoard = false
                
                leavingSoundPlayer?.stop()
                
               
                transferResourcesToResourcePool()
                print("Pre Pass Day Function -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
                gameData.passDay()
                print("Post Pass Day Function -> Food : \(gameData.foodResource) Survivors : \(gameData.survivorNumber) Cure Progress : \(gameData.WinProgress) Death Progress : \(gameData.progressToDeath)")
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
        ExitOverlayView(vm: Board(), food: 20, gameData: ResourcePool(), showBoard: .constant(false), unitsDied: 2, unitsRecruited: 1)
    }
}
