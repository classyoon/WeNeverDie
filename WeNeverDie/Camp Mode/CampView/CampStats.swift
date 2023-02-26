//
//  CampStats.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct CampStats : View {
    @ObservedObject var GameData : ResourcePool
    @State var ResetGame = false
    @State var surivorsSentOnMission : Int
    func starvationColor()->Color{
        if GameData.foodResource <= 0{
            return Color.red
        }
        return Color.green
    }
    func starvationText()->String{
        if GameData.starving{
            return "We are starving"
        }
        else{
            return "Estimated left over food for \(GameData.foodResource/GameData.survivorNumber) days, (rations \(GameData.foodResource))"
        }
    }
    var body: some View {
        VStack{
            
            Text("\(GameData.days) day(s) since the Beginning")
            Text("Cure Progress (Keep survivors at home to progress faster.)")
            ProgressView(value: Double(GameData.WinProgress), total: Double(GameData.WinCondition)).padding()
            Text("Survive. Get food. Don't die. Make it back to camp.")
            Text(starvationText()).foregroundColor(starvationColor())
            
            Stepper(value: $surivorsSentOnMission, in: 0...GameData.survivorNumber) {
                Text("People to send \(surivorsSentOnMission)").padding()
            }
            Text("Number of people \(GameData.survivorNumber)")
        }
        
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(GameData: ResourcePool(surviors: 2, food: 10), surivorsSentOnMission: 0)
    }
}
