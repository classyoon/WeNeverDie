//
//  NightDecisionView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct NightDecisionView: View {
    let zombieCount = 5 // replace with actual zombie count
    let resultCalculator = NightResultCalculator(zombieCount: 5)
    @State var loot = 10
    var body: some View {
        VStack{
            Button("Distract") {
                // code for the safe option
                print("Dropping some food and running...")
                loot-=resultCalculator.results.costOfSafeOption
                print("You lost \(resultCalculator.results.costOfSafeOption) loot, you now have \(resultCalculator.results.costOfSafeOption) loot")
            }
            Button("Run"){
                // code for the risky option
                print("Just running...")
                let randomNumber = Double.random(in: 0...1)
                if randomNumber < resultCalculator.results.chanceOfFailure {
                    print("You were caught by the zombies and lost everything!")
                } else {
                    print("You made it out safely!")
                }
                
            }.buttonStyle(.bordered)
        }
    }
    
}


struct NighttimeExitDecisonView_Previews: PreviewProvider {
    static var previews: some View {
        NightDecisionView()
    }
}
