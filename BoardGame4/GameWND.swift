//
//  GameWND.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import Foundation
import SwiftUI



struct GameView : View {
 
    @StateObject var camp  = Camp()
    @StateObject var board  = Board()
    
    func getCurrentView()-> AnyView {
        if board.missionUnderWay {
            return AnyView(BoardView(vm: board))
        }
        else {
            return AnyView(CampView(vm: camp))
        }
    }
    var body: some View {
        ZStack{
            VStack{
                getCurrentView()
            }
        }
    }
}

