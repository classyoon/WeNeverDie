//
//  BuildingList.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/23/23.
//

import SwiftUI

struct BuildingList: View {
    @State var stock  = Stockpile()
    var buildingMan : BuildingManager {
        BuildingManager(stock: stock)
    }
   
    var vm = BuildingsViewModel()
    var body: some View {
        ScrollView{
            ForEach(buildingMan.buildings.indices, id: \.self) { index in
                BuildingView(building: buildingMan.buildings[index], vm: vm, buildMan: buildingMan, stock: stock)
                
            }
            
        }.padding()
    }
}

struct BuildingList_Previews: PreviewProvider {
    static var previews: some View {
        BuildingList()
    }
}
