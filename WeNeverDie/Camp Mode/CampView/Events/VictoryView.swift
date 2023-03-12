//
//  VictoryView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct VictoryView: View {
    @ObservedObject var gameData: ResourcePool
    var body: some View {
        VStack {
            Text("You have won the demo")
                .font(.title)
                .bold()
            Text("You proved them all wrong. You survived and you cured the zombie virus. Hope prevails! Tell me about the bugs if you encountered any..")
                .font(.body)
                .lineLimit(3)
                .padding()
            // Spacer()//You go on to set the new future for the world that was seemingly brought to an end. Although you may have died many times, you never let your hope (or at least determination) die. Humanity shall never die as long as it has people like you (and your survivors) in this world.
            HStack(alignment: .top) {
                Button {
                    gameData.victory = false
                } label: {
                    Text("Endless")
                        .font(.headline)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            Color.red.clipShape(RoundedRectangle(cornerRadius: 50)))
                }
                Spacer()
                Button {
                    gameData.reset()
                } label: {
                    Text("RESET")
                        .font(.headline)
                        .bold()
                        .padding()
                        .foregroundColor(.red)
                        .background(
                            Color.white
                        ).overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.red, lineWidth: 5)
                        ).clipShape(RoundedRectangle(cornerRadius: 50))
                }
            }.padding(.horizontal, 30)
        }
        .padding()
        .aspectRatio(3, contentMode: .fit)
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(gameData: ResourcePool())
    }
}
