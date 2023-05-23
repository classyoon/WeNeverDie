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
    @Binding var surivorsSentOnMission: Int
    @Binding var showBoard : Bool
    @ObservedObject var uiSettings : UserSettingsManager
    
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
        if gameData.stockpile.getNumOfFood() <= 0 {
            return uiSettings.visionAssist ? Color.purple : Color.red
        }
        return uiSettings.visionAssist ? Color.yellow : Color.green
    }
    func starvationText()->String{
        if gameData.stockpile.isStarving(){
            return "We are starving. Days till death \(gameData.gameCon.getDeathCountdown())"
        }
        if gameData.stockpile.getNumOfFood() <= 0{
            return "If you see this then it is a bug. You shouldn't see this."
        }
        else{
            return "We have food for \(gameData.stockpile.getNumOfFood() / gameData.stockpile.getNumOfPeople()) days, (\(gameData.stockpile.getNumOfFood()) rations)."
        }
    }
    func resourceAmount()->String{
        if gameData.stockpile.getNumOfMat() == 0 {
            return "We have no building material"
        }
        else if gameData.stockpile.getNumOfMat() < 0 {
            return "This is a bug and you should not see this"
        }
        else {
            return "We have \(gameData.stockpile.getNumOfMat()) building materials."
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
                        if uiSettings.switchToLeft {
                            Spacer()
                        } else {
                            Spacer()
                            Spacer()
                            Spacer()
                        }

                        survivorSelector(gameData: gameData)

                        if uiSettings.switchToLeft {
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
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(gameData: ResourcePool(), shouldResetGame: Binding.constant(false), surivorsSentOnMission: Binding.constant(0), showBoard: Binding.constant(false), uiSettings: UserSettingsManager())
    }
}
