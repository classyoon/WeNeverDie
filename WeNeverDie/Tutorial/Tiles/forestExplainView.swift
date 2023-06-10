//
//  forestExplainView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct forestExplainView: View {
    var body: some View {
        VStack{
            Tile2(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
            Text("This is a forest. It provides safety and absolute concealment from zombies, and tends to have building materials in the form of large branches. However, just like water, this terrain will cost 2 stamina instead of one to traverse.")//try to fix
        }
    }
}

struct forestExplainView_Previews: PreviewProvider {
    static var previews: some View {
        forestExplainView()
    }
}
