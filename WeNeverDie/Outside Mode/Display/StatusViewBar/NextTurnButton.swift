//
//  NextTurnButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct NextTurnButton: View {
    @ObservedObject var gameData : ResourcePool
    @ObservedObject var vm : Board
    var body: some View {
        Button {
           
            withAnimation{vm.nextTurn()}
            vm.turn = UUID()
            
        } label: {
            
            Text("Next Turn").foregroundColor(Color.white)
            
                .padding()
                .background(vm.canAnyoneMove ? .gray : (gameData.visionAssist ? .blue : .green))
            
                .clipShape(
                    RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
        .shadow(color:  (vm.canAnyoneMove ? .clear :  (gameData.visionAssist ? Color.blue : Color.green)), radius: 5)
    }
}

struct NextTurnButton_Previews: PreviewProvider {
    static var previews: some View {
        NextTurnButton(gameData: ResourcePool(), vm: Board())
    }
}
