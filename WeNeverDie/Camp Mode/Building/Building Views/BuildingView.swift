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
            Text(constructor.workCostText(for: building))
            Text(constructor.workerText(for: building))
            constructor.buildingButtons(for: building, buildMan: buildMan, stock: stock )
                
            
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


