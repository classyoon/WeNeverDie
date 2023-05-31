//
//  BuildingList.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import SwiftUI

struct BuildingListView: View {
   
    @ObservedObject var buildMan = BuildingManager.shared
    @ObservedObject var stockpile = Stockpile.shared
    var constructor = BuildingViewConstructor.shared
    var body: some View {
        ScrollView{
            ForEach(buildMan.buildings.indices, id: \.self) { index in
                BuildingView(building: BuildingManager.shared.buildings[index]).padding()
                
            }
        }
    }
}

struct BuildListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingListView()
    }
}
