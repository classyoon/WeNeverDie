//
//  escapeExplainView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct escapeExplainView: View {
    var body: some View {
        VStack{
            ZStack{
                Tile2(image: "grass", tileLocation: Coord())
                Image("escape").resizable()
            }.frame(width: 300, height: 300).padding()
            Text("This is your means of returning to camp. You will typically find it at the bottom right of the board. Get your survivors to it once you are satisfied with your haul or if things get too dicy. If none of the survivors you sent are able to return, your camp will get nothing.")
        }
    }
}

struct escapeExplainView_Previews: PreviewProvider {
    static var previews: some View {
        escapeExplainView()
    }
}
