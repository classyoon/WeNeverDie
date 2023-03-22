//
//  survivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/21/23.
//

import SwiftUI

struct survivorSelector : View {
    @ObservedObject var gameData : ResourcePool
    @Binding var surivorsSentOnMission: Int
    @Binding var survivorsArr: [Int]
    var body: some View {
        VStack(alignment: .trailing) {
            Text("People to send scavenging: \(surivorsSentOnMission)")
                .font(.footnote)
            Stepper(value: $surivorsSentOnMission, in: 0 ... gameData.survivorNumber) {
                HStack {
                    ForEach(survivorsArr, id: \.self) { index in
                        Image(systemName: index < surivorsSentOnMission ? "person.fill" : "person")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                }.frame(maxHeight: 50)
            }
        }.padding()
            .background(.brown.opacity(0.7))
    }
}


struct survivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        survivorSelector(gameData: ResourcePool(surviors: 10, food: 0), surivorsSentOnMission: .constant(0), survivorsArr: .constant([Int]()))
    }
}
