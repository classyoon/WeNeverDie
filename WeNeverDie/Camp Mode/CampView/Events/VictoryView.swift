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
            Text("You proved them all wrong. You survived and you cured the zombie virus. Hope prevails! As you can see, this is a demo. If you would be intrested in me  adding more to this game email me.")
                .font(.body)
                .lineLimit(nil)
                .padding()
                //.font
            // Spacer()//You go on to set the new future for the world that was seemingly brought to an end. Although you may have died many times, you never let your hope (or at least determination) die. Humanity shall never die as long as it has people like you (and your survivors) in this world.
            HStack(alignment: .top) {
                Button {
                    gameData.gameCon.data.victory = false
                    gameData.gameCon.data.AlreadyWon = true
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
        //.aspectRatio(3, contentMode: .fit)
        // TODO: remove .onReceive from production. for testing purposes only
        //            .onReceive(timer) { _ in
        //                if gameData.victory {
        //                    gameData.victory = false
        //                } else {
        //                    gameData.victory = true
        //                }
        //            }
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(gameData: ResourcePool())
    }
}
