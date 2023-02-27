//
//  CampStats.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct CampStats : View {
    @ObservedObject var gameData : ResourcePool
    @Binding var ResetGame : Bool
    @State var surivorsSentOnMission : Int
    @Binding var showBoard : Bool
    func shouldShowMap() -> Bool{
        if surivorsSentOnMission > 0{
            return true
        }
        return false
    }
    func campPassDay(){
        gameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sending \(gameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        gameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(gameData.survivorSent)")
    }
    func starvationColor()->Color{
        if gameData.foodResource <= 0{
            return Color.red
        }
        return Color.green
    }
    func starvationText()->String{
        if gameData.starving{
            return "We are starving"
        }
        else{
            return "Estimated food left: \(gameData.foodResource/gameData.survivorNumber) days (\(gameData.foodResource) units of food - \(gameData.survivorNumber) per day)"
        }
    }
    var body: some View {
        VStack{
            
            Text("\(gameData.days) day(s) since the Beginning")
            Text("Cure Progress (Keep survivors at home to progress faster.)")
            ProgressView(value: Double(gameData.WinProgress), total: Double(gameData.WinCondition)).padding()
            Text("Survive! Get food! Don't die! Make it back to camp!")
            Text(starvationText()).foregroundColor(starvationColor())
            
            Stepper(value: $surivorsSentOnMission, in: 0...gameData.survivorNumber) {
                Text("People to send on next day : \(surivorsSentOnMission)").padding()
            }
            Text("Number of people in your group : \(gameData.survivorNumber)")
            Button("Next Day") {
                campPassDay()
            }
        }
        
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(gameData: ResourcePool(surviors: 2, food: 10), ResetGame: Binding.constant(false), surivorsSentOnMission: 0, showBoard: Binding.constant(false))
    }
}
