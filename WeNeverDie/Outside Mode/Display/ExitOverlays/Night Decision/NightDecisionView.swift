//
//  NightDecisionView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct NightDecisionView: View {
    var chanceOfFailure = NightResultCalculator(zombieCount: 10).results.chanceOfFailure
    var costOfSafeOption = NightResultCalculator(zombieCount: 10).results.costOfSafeOption
    var body: some View {
        HStack{
            Button("drop some food and run"){
               
            }
            Button("just run"){
                
            }
        }.buttonStyle(.bordered)
    }
}

struct NighttimeExitDecisonView_Previews: PreviewProvider {
    static var previews: some View {
        NightDecisionView()
    }
}
