//
//  sendOff.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct sendOff: View {
    var body: some View {
        VStack{
            Text("That is all, Survivor. Good luck out there to you and your friends. Here is a cool tune to listen to.")
            Button {
                if musicPlayer?.isPlaying == true {
                    musicPlayer?.pause()
                } else {
                    musicPlayer?.play()
                }
            } label: {
                Text(musicPlayer?.isPlaying == true ? "Pause" : "Play Song")
            }
        }
    }
}
struct sendOff_Previews: PreviewProvider {
    static var previews: some View {
        sendOff()
    }
}
