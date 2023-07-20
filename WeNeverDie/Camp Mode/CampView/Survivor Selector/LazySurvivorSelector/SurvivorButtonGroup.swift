//
//  SurvivorButtonGroup.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct SurvivorButtonGroup: View {
    @ObservedObject var GameData: ResourcePool
    var index : Int
    var body: some View {
        VStack{
            SurvivorIconButtonView(GameData: GameData, index: index)
            SwapAndInfoButton(GameData: GameData, index: index)
        }
    }
}

struct SurvivorButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorButtonGroup(GameData: ResourcePool(), index: 0)
    }
}
