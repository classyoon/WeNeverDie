//
//  SurvivorInfoButton.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct SurvivorInfoButton: View {
    @ObservedObject var GameData: ResourcePool
    var index : Int
    var body: some View {
        Button {
            GameData.displayInfo(index: index)
        } label: {
            Image(systemName: "info.circle")
        }
    }
}

struct SurvivorInfoButton_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorInfoButton(GameData: ResourcePool(), index: 0)
    }
}
