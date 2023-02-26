//
//  WeNeverDieApp.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI

@main
struct WeNeverDieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
    
        WindowGroup {

               GameView()
            //DeviceRotationViewTest()
        }
    }
}
