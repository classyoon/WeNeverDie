//
//  TutorialView2.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//]

/**
 This is a forest. It provides absolute (and currently unbreakable) concealment from zombies for the survivor who stands in.
 
 This is a building. This currently the only way to get food, and this is where ‘scavenging’ comes into play.
 
 Buildings will have a certain amount of resources in them. The only way to get these resources is for a survivor to search the place themselves.
 
 After selecting a survivor who is standing on a building, hit the search button to attempt to get a food resource. If there is still some left, you will obtain it with the search.
 
 This is your means of returning to camp. Get your survivors to it once you are satisfied with your haul, or if things get too dicy. If all of the survivors you sent outside were killed, you (should because this is beta) get nothing.
 */
import SwiftUI
struct enemyView : View {
    var body: some View {
        VStack{
            Text("The enemy").font(.title2)
            Image("Zombie").resizable().frame(width: 300, height: 300).padding()
            Text("Above is a shuffler. They are a common but very weak zombie. They have only one stamina per turn. But they come in large numbers, and once one can see you all of them can see you.")
        }
    }
}
struct waterExplainView: View {
  
    var body: some View {
        ScrollView{
            VStack{
                Image("water").resizable().frame(width: 300, height: 300).padding()
                 Text("This is water/any kind of difficult terrain. This terrain will take 2 stamina than one to traverse. It should be rare to see this as the zombie path finding isn't advanced enough to deal with it.")
                Text("That is all survivor. Good luck out there to you and your friends. Here is a cool tune to listen to.")
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
                Text("This is a grass field. It is nothing special.")
                Tile2(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
                Text("This is a forest. It provides absolute (and currently unbreakable) concealment from zombies for the survivor who stands in.")
                Image("building").resizable().frame(width: 300, height: 300).padding()
                Text("This is a building. This currently the only way to get food, and this is where ‘scavenging’ comes into play. \n\nBuildings will have a certain amount of resources in them. The only way to get these  is for a survivor to search the place.\n\nTo search a place, after selecting a survivor who is standing on a building, hit the search button to attempt to get a food resource. If there is still some left, you will obtain it with the search.")
                ZStack{
                    Tile2(image: "grass", tileLocation: Coord())
                    Image("escape").resizable()
                }.frame(width: 300, height: 300).padding()
                Text("This is your means of returning to camp. Get your survivors to it once you are satisfied with your haul, or if things get too dicy. If all of the survivors you sent outside were killed, you (should because this is beta) get nothing.")
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
