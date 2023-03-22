//
//  ResultScreen.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/19/23.
//

import SwiftUI

struct ResultScreen: View {
    var body: some View {
        Text("Zombies caught someone.").buttonStyle(.borderedProminent)
            .padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen()
    }
}
