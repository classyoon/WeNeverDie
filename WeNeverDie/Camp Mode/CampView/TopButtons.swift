//
//  TopButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct TopButtons: View {
    @ObservedObject var gameData: ResourcePool
    @State var musicIsPlaying = musicPlayer?.isPlaying == true
    @State var initialLoad = true

    var body: some View {
        VStack {
            Button {
                if musicIsPlaying {
                    guard (musicPlayer?.pause()) != nil else {
                        fatalError("Unable to pause music")
                    }
                    musicIsPlaying = false
                } else {
                    guard (musicPlayer?.play()) != nil else {
                        fatalError("Unable to start music")
                    }
                    musicIsPlaying = true
                }
            } label: {
                Image(systemName: musicIsPlaying ? "speaker.wave.2.circle.fill" : "speaker.slash.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(musicIsPlaying ? Color(.white) : Color(.white).opacity(0.5))
                    .shadow(radius: 5)
            }.onAppear {
                if initialLoad {
                    if !musicIsPlaying {
                        guard (musicPlayer?.play()) != nil else {
                            fatalError("Unable to start music")
                        }
                        musicIsPlaying = true
                    }
                    initialLoad = false
                }
            }.frame(maxHeight: 50)
            NavigationLink {
                TutorialView()
                    .foregroundColor(Color(.label))
            } label: {
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(0.6, contentMode: .fit)
                    .foregroundColor(Color(.white))
                    .shadow(radius: 5)
            }.frame(maxHeight: 50)
            NavigationLink {
                Settings(gameData: gameData)
            } label: {
                Text("Settings")
            }
            Spacer()
        }
    }
}

struct TopButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopButtons(gameData: ResourcePool(surviors: 2, food: 10))
    }
}
