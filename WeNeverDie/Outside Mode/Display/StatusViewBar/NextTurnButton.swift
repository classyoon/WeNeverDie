//
//  NextTurnButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct NextTurnButton: View {
    @ObservedObject var vm : Board
    var body: some View {
        Button {
            withAnimation{vm.nextTurn()}
            vm.turn = UUID()
            
        } label: {
            
            Text("Next Turn").foregroundColor(Color.white)
            
                .padding()
                .background(vm.canAnyoneMove ? .gray : .green)
            
                .clipShape(
                    RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
        .shadow(color: vm.canAnyoneMove ? .clear : .green, radius: 5)
    }
}

struct NextTurnButton_Previews: PreviewProvider {
    static var previews: some View {
        NextTurnButton(vm: Board())
    }
}
