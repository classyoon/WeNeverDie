//
//  VictoryView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct VictoryView : View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        VStack{
            Text("You have won the demo")
                .font(.title)
            Text("You proved them all wrong. You survived and you cured the zombie virus. Hope prevails! Tell me about the bugs if you encountered any..").font(.body)
            //Spacer()//You go on to set the new future for the world that was seemingly brought to an end. Although you may have died many times, you never let your hope (or at least determination) die. Humanity shall never die as long as it has people like you (and your survivors) in this world.
            HStack{
                Button("Reset"){
                    gameData.reset()
                }
                Button("Continue (If you would like)"){
                    gameData.victory = false
                }
            }
        }.foregroundColor(Color.black)
            .colorScheme(.dark).padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}
struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(gameData: ResourcePool(surviors: 2, food: 20))
    }
}
