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
            Text("This is water or any kind of difficult terrain. This terrain will take two stamina points rather than one to traverse. Exposed, but there can be loads of food in the form of fish.\n")
        }
        
    }
    
}

struct waterExplainView_Previews: PreviewProvider {
    static var previews: some View {
        waterExplainView()
    }
}
