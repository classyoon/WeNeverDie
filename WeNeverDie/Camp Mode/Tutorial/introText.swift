//
//  introText.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct introText: View {
    var body: some View {
        Text("Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive and two others. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n")
    }
}

struct introText_Previews: PreviewProvider {
    static var previews: some View {
        introText()
    }
}
