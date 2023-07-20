//
//  CampStats.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct CampStats : View {
    @ObservedObject var gameData : ResourcePool
    @Binding var shouldResetGame : Bool
    
    @Binding var showBoard : Bool
    @ObservedObject var uiSettings : UserSettingsManager
    
    @ObservedObject var buildingMan : BuildingManager = BuildingManager.shared
    @ObservedObject var stockpile : Stockpile = Stockpile.shared
    
    @State var survivorsArr: [Int] = []
    
    func shouldShowMap() -> Bool{
        if Stockpile.shared.getSurvivorSent() > 0{
            return true
        }
        return false
    }
    func campPassDay(){
        gameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sent \(Stockpile.shared.getSurvivorSent())")
        Stockpile.shared.setSurvivorSent(Stockpile.shared.getSurvivorSent())
    }
    func starvationColor()->Color{
        if Stockpile.shared.getNumOfFood() <= 0 {
            return uiSettings.visionAssist ? Color.purple : Color.red
        }
        return uiSettings.visionAssist ? Color.yellow : Color.green
    }
    func starvationText()->String{
        if buildingMan.getStatusOf("Farm") && buildingMan.getStatusOf("House"){
            return "We have food for \(Stockpile.shared.getNumOfFood() / Stockpile.shared.getNumOfPeople()) days, (\(Stockpile.shared.getNumOfFood()) rations). However, we will also produce  \(buildingMan.getProjectedOutputOf("Farm")) and consume \(buildingMan.getProjectedInputOf("Nursery")) per day."
        }else if buildingMan.getStatusOf("Farm")  {
            return "We have food for \(Stockpile.shared.getNumOfFood() / Stockpile.shared.getNumOfPeople()) days, (\(Stockpile.shared.getNumOfFood()) rations). However, we will also produce  \(buildingMan.getProjectedOutputOf("Farm")) per day"
            
        }   else if buildingMan.getStatusOf("Nursury"){
            return "We have food for \(Stockpile.shared.getNumOfFood() / Stockpile.shared.getNumOfPeople()) days, (\(Stockpile.shared.getNumOfFood()) rations). However, we will also consume \(buildingMan.getProjectedInputOf("Nursery")) per day."
        }
        if Stockpile.shared.isStarving(){
            return "We are starving. Days till death \(gameData.gameCon.getDeathCountdown())"
        }
        if Stockpile.shared.getNumOfFood() < 0{
            return "If you see this then it is a bug. You shouldn't see this."
        }
        else{
            return "We have food for \(Stockpile.shared.getNumOfFood() / Stockpile.shared.getNumOfPeople()) days, (\(Stockpile.shared.getNumOfFood()) rations)."
        }
        
    }
    func resourceAmount()->String{
        if buildingMan.getStatusOf("Farm") &&  buildingMan.getStatusOf("Mine") {
            return "We have \(Stockpile.shared.getNumOfMat()) building materials. We will produce \(buildingMan.getProjectedOutputOf("Mine")). We will consume \(buildingMan.getProjectedInputOf("Farm"))"
        }
        if buildingMan.getStatusOf("Farm"){
            return "We have \(Stockpile.shared.getNumOfMat()) building materials. We will consume \(buildingMan.getProjectedInputOf("Farm"))"
    }
        if buildingMan.getStatusOf("Mine"){
            return "We have \(Stockpile.shared.getNumOfMat()) building materials. We will produce \(buildingMan.getProjectedOutputOf("Mine"))"
    }
            if Stockpile.shared.getNumOfMat() == 0 {
            return "We have no building material"
        }
        else if Stockpile.shared.getNumOfMat() < 0 {
            return "This is a bug and you should not see this"
        }
        else {
            return "We have \(Stockpile.shared.getNumOfMat()) building materials."
        }
    }
    var instructions: some View {
        VStack {
            Text("Survive. Get food. Don't die. Make it back to camp.")
                .font(.headline)
                .shadow(color: .black, radius: 5)
            Text(starvationText())
                .font(.subheadline)
                .foregroundColor(starvationColor())
                .shadow(color: .black, radius: 5)
            Text(resourceAmount())
                .font(.subheadline)
                .foregroundColor(.white)
        }.background {
            Color(.black).opacity(0.7)
        }
    }
    
    var body: some View {
        VStack {
            Text(gameData.days == 0 ? "The Beginning" : "Day \(gameData.days)")
                .font(.largeTitle)
                .shadow(color: .black, radius: 5)
                .padding()
            ZStack(alignment: .topLeading) {
                VStack {
                    instructions
                    Spacer()
                    HStack{
                        if uiSettings.isUsingLeftHandedInterface {
                            Spacer()
                        } else {
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        
                        survivorSelector(gameData: gameData)
                        
                        if uiSettings.isUsingLeftHandedInterface {
                            Spacer()
                            Spacer()
                            Spacer()
                        } else {
                            Spacer()
                        }
                        
                    }
                    Spacer()
                }.padding(.horizontal, 100)
                    .frame(width: UIScreen.screenWidth)
            }
        }
        .padding()
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(gameData: ResourcePool(), shouldResetGame: Binding.constant(false), showBoard: Binding.constant(false), uiSettings: UserSettingsManager())
    }
}
