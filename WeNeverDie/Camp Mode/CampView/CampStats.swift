//
//  CampStats.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct CampStats: View {
    @ObservedObject var GameData: ResourcePool
    @State var ResetGame = false
    @Binding var surivorsSentOnMission: Int

    @State var survivorsArr: [Int] = []
    func starvationColor()->Color {
        if GameData.foodResource <= 0 {
            return Color.red
        }
        return Color.green
    }

    func starvationText()->String {
        if GameData.starving {
            return "We are starving"
        }
        else {
            return "We have food for \(GameData.foodResource / GameData.survivorNumber) days, (rations \(GameData.foodResource))."
        }
    }

    var survivorStepper: some View {
        VStack(alignment: .trailing) {
            Text("People to send scavenging: \(surivorsSentOnMission)")
                .font(.footnote)
            Stepper(value: $surivorsSentOnMission, in: 0 ... GameData.survivorNumber) {
                HStack {
                    ForEach(survivorsArr, id: \.self) { index in
                        Image(systemName: index < surivorsSentOnMission ? "person.fill" : "person")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                }.frame(maxHeight: 50)
            }
        }.padding()
            .background(.black.opacity(0.7))
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
            Text(GameData.days == 0 ? "The Beginning" : "Day \(GameData.days)")
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
            survivorsArr = (0 ..< GameData.survivorNumber).map { index in index }
        }.onChange(of: GameData.survivorNumber) { _ in
            survivorsArr = (0 ..< GameData.survivorNumber).map { index in index }
        }
    }
}

struct CampStats_Previews: PreviewProvider {
    static var previews: some View {
        CampStats(GameData: ResourcePool(surviors: 2, food: 10), surivorsSentOnMission: Binding.constant(0))
    }
}
