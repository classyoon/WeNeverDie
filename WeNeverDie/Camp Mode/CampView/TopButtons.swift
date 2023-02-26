//
//  TopButtons.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct TopButtons : View {
    //                "Music"
    
    //                NavigationLink {
    //                    Settings()
    //                } label: {
    //                    Text("Settings")
    //                }
    
    //            Text(vm.SurvivorList2[0].function?.name)
    var body: some View {
        HStack{
            NavigationLink {
                TutorialView()
            } label: {
                Text("Tutorial")
            }
            
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

struct TopButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopButtons()
    }
}
