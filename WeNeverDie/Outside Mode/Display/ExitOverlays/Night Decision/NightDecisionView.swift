//
//  NightDecisionView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct NightDecisionView: View {
    let resultCalculator : NightResultCalculator
    @Binding var showBoard : Bool
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        VStack{
            Text("You have to get home now. \(resultCalculator.zombieCount) zombies nearby.")
            HStack{
                vm.foodNew >= resultCalculator.results.costOfSafeOption ? Button("Distract with \(resultCalculator.results.costOfSafeOption)") {
                    // code for the safe option
                    print("Dropping some food and running...")
                    vm.foodNew-=resultCalculator.results.costOfSafeOption

                    vm.neutralOutcome = true
                    vm.audio.playSFX(.carStarting)
                    vm.showEscapeOption = false
                } : Button("Unable to distract. Cost : \(resultCalculator.results.costOfSafeOption)"){}
                Button("Run"){
                    // code for the risky option
                    print("Just running...")
                    let randomNumber = Double.random(in: 0...1)
                    if randomNumber < resultCalculator.results.chanceOfFailure {
                        vm.UnitsDied+=1
                        gameData.transferResourcesToResourcePool(vm: vm)
                        print("You were caught by the zombies and lost everything!")
                        vm.badOutcome = true                       
                        vm.audio.playSFX(.badResult)
                        vm.showEscapeOption = false
                    }
                    else {
                        print("You made it out safely!")
                        vm.audio.playSFX(.carStarting)
                        vm.showEscapeOption = false
                        vm.avoidedOutcome = true             
                    }
                    
                }.buttonStyle(.bordered)
            }
            
        }.frame(width: 300, height: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.thickMaterial)
            )
    }
    
}


struct NighttimeExitDecisonView_Previews: PreviewProvider {
    static var previews: some View {
        NightDecisionView(resultCalculator: NightResultCalculator(zombieCount: 10), showBoard: .constant(true), vm: Board(), gameData: ResourcePool())
    }
}
