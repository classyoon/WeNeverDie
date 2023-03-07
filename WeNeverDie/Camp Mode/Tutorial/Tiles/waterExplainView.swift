//
//  waterExplainView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct waterExplainView: View {
    var body: some View {
        VStack{
            Image("water").resizable().frame(width: 300, height: 300).padding()
            Text("Difficult Terrain : \nThis is water or any kind of difficult terrain. This terrain will take 2 stamina points rather than 1 to traverse.\n")
        }
        
    }
    
}

struct waterExplainView_Previews: PreviewProvider {
    static var previews: some View {
        waterExplainView()
    }
}
