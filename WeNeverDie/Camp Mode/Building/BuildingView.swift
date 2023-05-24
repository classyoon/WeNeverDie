//
//  BuildingView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//

import SwiftUI
import Foundation
struct BuildingView: View {
    @ObservedObject var building: Building
    @ObservedObject var vm : BuildingsViewModel
    @ObservedObject var buildMan : BuildingManager
    @ObservedObject var stock : Stockpile
    @State private var showScrapAlert = false
    
    var body: some View {
        VStack {
            Text(vm.workCostText(for: building))
            Text(vm.workerText(for: building))
            vm.buildingButtons(for: building, buildMan: buildMan, stock: stock )
                
            
            if building.constructionStarted && (buildMan.canAssignWorker(to: building) || building.workers > 0) {
                Button("Scrap") {
                    showScrapAlert = true
                }
                .alert(isPresented: $showScrapAlert) {
                    Alert(
                        title: Text("Are you sure you want to scrap this building?"),
                        message: Text("This will refund your resources."),
                        primaryButton: .destructive(Text("Scrap")) {
                            building.constructionStarted = false
                            buildMan.scrap(building)
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}


struct BuildingView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingView(building: Building(model: BuildingData(name: "HQ", workCost: 100)), vm: BuildingsViewModel(), buildMan: BuildingManager(stock: Stockpile()), stock: Stockpile())
    }
}
