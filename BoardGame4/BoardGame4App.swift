//
//  BoardGame4App.swift
//  BoardGame4
//
//  Created by Tim Yoon on 12/2/22.
//

import SwiftUI

@main
struct BoardGame4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BoardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
