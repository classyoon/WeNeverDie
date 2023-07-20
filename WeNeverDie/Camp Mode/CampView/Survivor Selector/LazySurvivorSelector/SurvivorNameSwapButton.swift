//
//  SurvivorNameSwapButton.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct SurvivorNameSwapButton: View {
    @ObservedObject var stock = Stockpile.shared
    @State var current : Int
    @State var index : Int
    var body: some View {
        Button(stock.getName(index: current)){
            stock.swapSurvivors(index: index, current: current)
        }
    }
}

struct SurvivorNameSwapButton_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorNameSwapButton(current: 0, index: 0)
    }
}
