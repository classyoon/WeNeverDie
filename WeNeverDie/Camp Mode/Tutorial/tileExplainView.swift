//
//  TutorialView2.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//]

import SwiftUI

struct waterExplainView: View {
  
    var body: some View {
        ScrollView{
            VStack{
                Image("water").resizable().frame(width: 300, height: 300).padding()
                 Text("Difficult Terrain : \nThis is water or any kind of difficult terrain. This terrain will take 2 stamina points rather than 1 to traverse.\n")
                Text("That is all Survivor. Good luck out there to you and your friends. Here is a cool tune to listen to.")
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
    
}
struct tileExplainView: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("Land & Scavenging").font(.title2)
                Image("grass").resizable().frame(width: 300, height: 300).padding()
                Text("This is a grass field. It is nothing special.")//try to fix
                Tile2(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
                Text("This is a forest. It provides safety and absolute concealment from zombies.")//try to fix
                Image("building").resizable().frame(width: 300, height: 300).padding()
                Text("Buildings :\nThis is currently the only way to get food, and this is where the button \"search\" comes into play on the right side of the screen. \n\nBuildings will have a certain amount of resources in them. The only way to get the resources is for a survivor to \"search\" the place.\n\nTo search a place, select a survivor who is standing on a building tile, hit the \"search\" button to attempt to get a food resource. If there is still some left, you will collect it. Yummy!")
                ZStack{
                    Tile2(image: "grass", tileLocation: Coord())
                    Image("escape").resizable()
                }.frame(width: 300, height: 300).padding()
                Text("Escape :\n This is your means of returning to camp. You will typically find it at the bottom-right of the board. Get your survivors to it once you are satisfied with your haul, or if things get too dicy. If none of the survivors you sent are able to return, your camp will get nothing.")
                waterExplainView()
           
            }.padding()
        }
    }
}

struct TutorialView2_Previews: PreviewProvider {
    static var previews: some View {
        tileExplainView()
    }
}
