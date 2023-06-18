//
//  buildingAndScavengeExplained.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct buildingAndScavengeExplained: View {
    var body: some View {
        VStack{
            Image("building").resizable().frame(width: 300, height: 300).padding()
            Text("This is an abandoned building, currently the only way to get food, and this is where the button \"search\" comes into play on the right side of the screen. \n\nBuildings will have a certain amount of resources in them. The only way to get the resources is for a survivor to \"search\" the place.\n\nTo search a place, select a survivor who is standing on a building tile, hit the \"search\" button to attempt to get a food resource. If there is still some left, you will collect it. Yummy!")
        }
    }
}

struct buildingAndScavengeExplained_Previews: PreviewProvider {
    static var previews: some View {
        buildingAndScavengeExplained()
    }
}
