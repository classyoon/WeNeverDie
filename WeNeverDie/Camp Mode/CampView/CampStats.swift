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
        if gameData.foodResource <= 0 {
            return Color.red
        }
        return Color.green
    }
    func starvationText()->String{
        if gameData.starving{
            return "We are starving. Days till death \(gameData.deathRequirement-gameData.progressToDeath)"
        }
        if gameData.survivorNumber <= 0{
            return "If you see this then it is a bug. You shouldn't see this."
        }
        else{
            return "We have food for \(gameData.foodResource / gameData.survivorNumber) days, (\(gameData.foodResource) rations)."
        }
    }

    var survivorStepper: some View {
        VStack(alignment: .trailing) {
            Text("People to send scavenging: \(surivorsSentOnMission)")
                .font(.footnote)
            Stepper(value: $surivorsSentOnMission, in: 0 ... gameData.survivorNumber) {
                HStack {
                    ForEach(survivorsArr, id: \.self) { index in
                        Image(systemName: index < surivorsSentOnMission ? "person.fill" : "person")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                }.frame(maxHeight: 50)
            }
        }.padding()
            .background(.brown.opacity(0.7))
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
                    survivorStepper
                    Spacer()
                }.padding(.horizontal, 100)
                    .frame(width: UIScreen.screenWidth)
            }
        }
        .onAppear {
            survivorsArr = (0 ..< gameData.survivorNumber).map { index in index }
        }.onChange(of: gameData.survivorNumber) { _ in
            survivorsArr = (0 ..< gameData.survivorNumber).map { index in index }
        }
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(gameData: ResourcePool(), shouldResetGame: Binding.constant(false), surivorsSentOnMission: Binding.constant(0), showBoard: Binding.constant(false))
    }
}
