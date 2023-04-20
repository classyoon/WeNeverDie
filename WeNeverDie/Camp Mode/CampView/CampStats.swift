//
//  CampStats.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI
class CampManager : ObservableObject{
    @ObservedObject var gameData : ResourcePool = ResourcePool()
    var survivorsSentOnMission : Int = 0
    var isExitButtonPressed : Bool = false
    var isResetButtonPressed : Bool = false
    var starvationColor : Color = Color.green
    
    func shouldShowMap() -> Bool{
        if survivorsSentOnMission > 0{
            return true
        }
        return false
    }
    
    func getStarvationColor()->Color{
        if gameData.foodStored <= 0 {
            return gameData.visionAssist ? Color.purple : Color.red
        }
        return gameData.visionAssist ? Color.yellow : Color.green
    }
    
    func getDeathCalc()->Int{
        return gameData.deathRequirement-gameData.progressToDeath
    }
    func getStarvationStatus()->Bool{
        return gameData.starving
    }
    func catchNegativeSurvivorBug()->Bool{
        return gameData.survivorNumber <= 0
    }
    func getDaysOfFood()->Int{
        return gameData.foodStored / gameData.survivorNumber
    }
    func getFoodStored()->Int{
        return gameData.foodStored
    }
}
class CampViewModel : ObservableObject {
    @ObservedObject var campManager = CampManager()
    func starvationText()->String{
        if campManager.getStarvationStatus(){
            return "We are starving. Days till death \(campManager.getDeathCalc())"
        }
        if campManager.catchNegativeSurvivorBug(){
            return "If you see this then it is a bug. You shouldn't see this."
        }
        else{
            return "We have food for \(campManager.getDaysOfFood()) days, (\(campManager.getFoodStored()) rations)."
        }
    }
    func getShouldShowMap()->Bool{
        return campManager.shouldShowMap()
    }
    
}
struct CampStats : View {
    @ObservedObject var gameData : ResourcePool
    @Binding var shouldResetGame : Bool
    @Binding var surivorsSentOnMission: Int
    @Binding var showBoard : Bool

    @State var survivorsArr: [Int] = []

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
        if gameData.foodStored <= 0 {
            return gameData.visionAssist ? Color.purple : Color.red
        }
        return gameData.visionAssist ? Color.yellow : Color.green
    }
    func starvationText()->String{
        if gameData.starving{
            return "We are starving. Days till death \(gameData.deathRequirement-gameData.progressToDeath)"
        }
        if gameData.survivorNumber <= 0{
            return "If you see this then it is a bug. You shouldn't see this."
        }
        else{
            return "We have food for \(gameData.foodStored / gameData.survivorNumber) days, (\(gameData.foodStored) rations)."
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
                        gameData.switchToLeft ? nil : Spacer()
                        gameData.switchToLeft ? nil : Spacer()
                        gameData.switchToLeft ? nil : Spacer()
                        
                        gameData.switchToLeft ? Spacer() : nil
                        
                        survivorSelector(gameData: gameData)
                        
                        gameData.switchToLeft ? nil : Spacer()
                        
                        gameData.switchToLeft ? Spacer() : nil
                        gameData.switchToLeft ? Spacer() : nil
                        gameData.switchToLeft ? Spacer() : nil
                    }
                    Spacer()
                }.padding(.horizontal, 100)
                    .frame(width: UIScreen.screenWidth)
            }
        }
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(gameData: ResourcePool(), shouldResetGame: Binding.constant(false), surivorsSentOnMission: Binding.constant(0), showBoard: Binding.constant(false))
    }
}
