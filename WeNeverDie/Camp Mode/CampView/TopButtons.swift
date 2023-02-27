//
//  TopButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct TopButtons: View {
    @State var musicIsPlaying = musicPlayer?.isPlaying == true
    //                "Music"

    //                NavigationLink {
    //                    Settings()
    //                } label: {
    //                    Text("Settings")
    //                }

    //            Text(vm.SurvivorList2[0].function?.name)
    var body: some View {
        HStack {
            NavigationLink {
                TutorialView()
                    .foregroundColor(Color(.label))
            } label: {
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(0.8, contentMode: .fit)
                    .foregroundColor(Color(.white))
            }

            Spacer()

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
                    .foregroundColor(musicIsPlaying ? Color(.white) : Color(.white).opacity(0.3))
            }.onAppear {
                if !musicIsPlaying {
                    guard (musicPlayer?.play()) != nil else {
                        fatalError("Unable to start music")
                    }
                    musicIsPlaying = true
                }
            }
        }
    }
}

struct TopButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopButtons()
            .background(.black)
    }
}
