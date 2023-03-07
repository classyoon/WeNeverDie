//
//  enemyView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct enemyView : View {
    var body: some View {
        VStack{
            Text("The enemy").font(.title2)
            Image("SZombie").resizable().frame(width: 350, height: 200)
            Text("Above is a Shuffler. They are a common but very weak zombie. They have only one stamina per turn, but they come in large numbers. Once they can see you, they will turn red and try to eat you.")
            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
            Text("\n Boo!")
        }
    }
}

struct enemyView_Previews: PreviewProvider {
    static var previews: some View {
        enemyView()
    }
}
