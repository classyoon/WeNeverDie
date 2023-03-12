//
//  CureProgressView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

import SwiftUI

struct CureProgressView: View {
    @ObservedObject var gameData : ResourcePool
    @Binding var showCureHelp : Bool
    var body: some View {
        GeometryReader { progressDim in
            HStack {
                HStack {
                    ProgressView(value: Double(gameData.WinProgress), total: Double(gameData.WinCondition))
                        .padding()
                        .animation(.easeInOut(duration: 3), value: gameData.WinProgress)
                    Button {
                        showCureHelp = true
                    } label: {
                        Image(systemName: gameData.victory ? "syringe.fill" : "syringe")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: 70)
                    }
                    .frame(width: progressDim.size.width * 0.1)

                }.alert("Cure Progress \(String(format: " %.0f%%", gameData.WinProgress / gameData.WinCondition * 100))", isPresented: $showCureHelp) {
                    Button("Understood", role: .cancel) {}
                } message: {
                    Text("Keep survivors at home to make progress faster.")
                }
                Spacer()
            }
        }.aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: min(UIScreen.screenHeight, UIScreen.screenWidth) - 70, maxHeight: min(UIScreen.screenHeight, UIScreen.screenWidth) - 70)
            .rotationEffect(Angle(degrees: -90))
            .foregroundColor(.blue)
    }
}

struct CureProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CureProgressView(gameData: ResourcePool(), showCureHelp: .constant(true))
    }
}
