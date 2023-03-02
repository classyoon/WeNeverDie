//
//  ExitOverlayView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct ExitOverlayView: View {
    let food : Int
    var gameData : ResourcePool
    @Binding var showBoard : Bool
    var unitsDied : Int
    var body: some View {
        VStack{
            Text("End Mission : Gathered \(food) rations, total food for the day should be \(gameData.foodResource + food)")
                .font(.title).foregroundColor(Color.black)
            Button {
                showBoard = false
                gameData.foodResource += food
                gameData.foodResource-=gameData.survivorNumber
                gameData.calcWinProgress()
                gameData.checkForDefeat()
                
                //musicPlayer?.stop()
                
                
                //gameData.foodResource -= gameData.survivorNumber
                
                gameData.survivorSent = 0
                gameData.survivorNumber -= unitsDied
                //                            gameData.passDay()
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
        ExitOverlayView(food: 20, gameData: ResourcePool(surviors: 10, food: 10), showBoard: .constant(false), unitsDied: 2)
    }
}
