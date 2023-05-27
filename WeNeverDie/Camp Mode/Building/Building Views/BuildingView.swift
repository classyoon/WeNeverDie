//
//  BuildingView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
// CHECK

import SwiftUI
import Foundation
struct BuildingView: View {
    @ObservedObject var building: Building
    var constructor = BuildingViewConstructor.shared
    @ObservedObject var buildMan : BuildingManager
    @ObservedObject var stock = Stockpile.shared
    @State private var showScrapAlert = false
    
    var body: some View {
        VStack {
            HStack{
                Text(constructor.workCostText(for: building))
                Text(constructor.workerText(for: building))
            }
            if building.isComplete && building is AdvancementBuilding {
                Text("Researcher Jobs not implemented yet")
               
            } else {
    
                constructor.startConstructionButton(for: building, buildMan: buildMan)
                constructor.workerButtons(for: building, buildMan: buildMan)
            }
                
            
            if building.constructionStarted && (buildMan.canAssignWorker(to: building) || building.workers > 0) {
                Button(constructor.confirmScrap) {
                    showScrapAlert = true
                }
                .alert(isPresented: $showScrapAlert) {
                    Alert(
                        title: Text(constructor.alertText),
                        message: Text(constructor.alert2Text),
                        primaryButton: .destructive(Text(constructor.confirmScrap)) {
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
        
        BuildingView(building: AdvancementBuilding(extraModel: AdvancementData(name: "Tester", workCost: 10, techBranch: [])), buildMan: BuildingManager())
    }
}
