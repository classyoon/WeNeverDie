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
            Text("This is a forest. It provides safety and absolute concealment from zombies.")//try to fix
        }
    }
}

struct forestExplainView_Previews: PreviewProvider {
    static var previews: some View {
        forestExplainView()
    }
}
