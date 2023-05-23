//
//  BuildingView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import SwiftUI

struct BuildingView: View {
    @ObservedObject var building: Building
    @ObservedObject var vm : BuildingsViewModel
    @ObservedObject var ResourcePool : ResourcePool
    
    @State private var showScrapAlert = false
    
    var body: some View {
        VStack {
            Text(vm.workCostText(for: building))
            vm.buildingButtons(for: building, ResourcePool: ResourcePool)
            if building.constructionStarted && (ResourcePool.buildingMan.canAssignWorker(to: building) || building.workers > 0) {
                Button("Scrap") {
                    showScrapAlert = true
                }
                .alert(isPresented: $showScrapAlert) {
                    Alert(
                        title: Text("Are you sure you want to scrap this building?"),
                        message: Text("This will refund your resources."),
                        primaryButton: .destructive(Text("Scrap")) {
                            building.constructionStarted = false
                            ResourcePool.buildingMan.scrap(building)
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }.padding()
    }
}


struct BuildingView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingView(building: Building(name: "HQ", workCost: 100), vm: BuildingsViewModel(), ResourcePool: ResourcePool())
    }
}
