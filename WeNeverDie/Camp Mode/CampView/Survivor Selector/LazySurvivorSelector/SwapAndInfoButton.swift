//
//  SwapAndInfoButton.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI


struct SwapAndInfoButton: View {
    @ObservedObject var GameData: ResourcePool
    @ObservedObject var stock = Stockpile.shared
    var index : Int
    var body: some View {
        HStack{
            Menu(Stockpile.shared.getName(index: index)) {
                ForEach(0..<stock.stockpileData.rosterOfSurvivors.count){ current in
                    if current != index {
                        SurvivorNameSwapButton(current: current, index: index)
                    }
                }
            }
            SurvivorInfoButton(GameData: GameData, index: index)
        }.buttonStyle(.bordered)
    }
}

struct SwapAndInfoButtons_Previews: PreviewProvider {
    static var previews: some View {
        SwapAndInfoButton(GameData: ResourcePool(), index: 0)
    }
}
