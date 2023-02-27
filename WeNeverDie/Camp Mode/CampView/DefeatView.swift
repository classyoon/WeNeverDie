//
//  DefeatView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct DefeatView: View {
    @State var GameData: ResourcePool
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Death\(Int.random(in: 1 ... 4))")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(20)
                .shadow(radius: 10)
            VStack {
                Spacer()
                Text("R.I.P.")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(.label))
                    .colorScheme(.dark)
                    .padding(50)
                    .background(
                        Rectangle()
                            .fill(Color(.systemBackground))
                            .aspectRatio(0.8, contentMode: .fit)
                            .cornerRadius(40, corners: [.topLeft, .topRight])
                            .opacity(0.5)
                    ).shadow(radius: 5, x: -5, y: -5)
                Spacer()
            }
            VStack {
                Spacer()
                Button {
                    GameData.ResetGame = true
                } label: {
                    Text("WE NEVER DIE")
                        .font(.largeTitle)
                        .bold()
                        .shadow(color: .red, radius: 5, x: -5, y: 5)
                        .padding()
                        .foregroundColor(.red)
                        .background(
                            Color(.systemBackground)
                                .opacity(0.3)
                                .shadow(color: Color(.systemBackground), radius: 10)
                        )
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct DefeatView_Previews: PreviewProvider {
    static var previews: some View {
        DefeatView(GameData: ResourcePool(surviors: 0, food: 0))
    }
}
