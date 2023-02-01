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
    var showingMission = true
    @ViewBuilder
    func changeScene() -> any View {
        if showingMission{
            BoardView(vm: Board())
        }
        else{
            TestMerge()
        }
//
//        return
    }
    @ViewBuilder
    var body: some Scene {
    
        WindowGroup {
//            ZStack{
//                TestMerge()
                BoardView(vm: Board())
                //    changeScene().environment(\.managedObjectContext, persistenceController.container.viewContext)
            //}
        }
    }
}
