//
//  SurvivorIconButtonView.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct SurvivorIconButtonView: View {
    @ObservedObject var GameData: ResourcePool
    
    @State var index : Int
    var body: some View {
        Button {
            GameData.balance(index)
        } label: {
            Image(systemName: GameData.getImageName(index: index)) .resizable()
                .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct SurvivorIconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorIconButtonView(GameData: ResourcePool(), index: 0)
    }
}
