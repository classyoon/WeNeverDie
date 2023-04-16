//
//  ResetButtonView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct ResetButtonView: View {
    @ObservedObject var gameData: ResourcePool
    var body: some View {
        Button {
           
                gameData.reset()
            
        } label: {
            Text("RESET GAME")
                .font(.headline)
                .bold()
                .padding()
                .foregroundColor(gameData.visionAssist ? Color.purple : Color.red)
                .background(
                    Color.white
                ).overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(gameData.visionAssist ? Color.purple : Color.red, lineWidth: 5)
                ).clipShape(RoundedRectangle(cornerRadius: 50))
        }.shadow(color: gameData.visionAssist ? Color.purple : Color.red, radius: 5)
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView(gameData: ResourcePool())
    }
}
