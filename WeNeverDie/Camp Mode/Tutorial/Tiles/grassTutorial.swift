//
//  grassTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct grassTutorial: View {
    var body: some View {
        VStack{
            Text("Land & Scavenging").font(.title2)
            Image("grass").resizable().frame(width: 300, height: 300).padding()
            Text("This is a grass field.")//try to fix
        }
    }
}

struct grassTutorial_Previews: PreviewProvider {
    static var previews: some View {
        grassTutorial()
    }
}
