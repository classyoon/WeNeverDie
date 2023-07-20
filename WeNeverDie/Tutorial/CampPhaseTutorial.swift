//
//  CampPhaseTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct CampPhaseTutorial: View {
    var body: some View {
        VStack{
            campIntro()
            Text(resources)
            buildingTutor()
            missionSending()
        }
    }
    
    var camp = """
Below represents your camp.
"""
    
    var resources = """
There are currently two resources you should keep track of :

Food - For eating
Building Material - For building
"""
 
    var buildButton = """

Tap a button that looks like the image below to open the build menu
"""
    
    var startConstruction = """
Tap this button to start construction. You can use the plus or minus to add or subtract builders, which will speed up or slow down the construction each day in game.
"""
    
    var goOnMission = """
Tap this button to progress to the next day. If you have any people selected, a mission will automatically start. If the button is a van, it means that you will be starting a mission if you tap the button, if it is a clock then it will just be progressing to the next day.
"""
    func campIntro()-> some View {
        VStack{
            Text("Home Sweet Home").font(.title)
            Text(camp)
            Image("Campground").resizable().frame(height: 400)
        }
    }
    
    func buildingTutor()-> some View {
        VStack{
            Text(buildButton)
            Image("Hammer").resizable().frame(width: 100, height: 100)
        }
    }
    
    func missionSending()->some View {
        VStack{
            Text(goOnMission)
            HStack{
            Image("Bus").resizable().frame(width: 100, height: 100)
                Image("Clock").resizable().frame(width: 100, height: 100)
            }
        }
    }
}

struct CampPhaseTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            CampPhaseTutorial()
        }
    }
}
