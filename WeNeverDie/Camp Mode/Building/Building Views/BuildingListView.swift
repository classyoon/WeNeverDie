//
//  BuildingList.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import SwiftUI

struct BuildingListView: View {
   
    @ObservedObject var buildingMan : BuildingManager
    @ObservedObject var stockpile = Stockpile.shared
    var constructor = BuildingViewConstructor.shared
    var body: some View {
        ScrollView{
            ForEach(buildingMan.buildings.indices, id: \.self) { index in
                BuildingView(building: buildingMan.buildings[index], buildMan: buildingMan).padding()
                
            }
        }
    }
}

struct BuildListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingListView(buildingMan: BuildingManager())
    }
}
