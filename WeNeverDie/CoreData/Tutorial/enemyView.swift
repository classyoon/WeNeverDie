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
            
            Image("SZombie").resizable().frame(width: 350, height: 200)
            Text("Those Who Never Die").font(.title)
            Text("Above is a Shuffler. They are a common but very weak zombie. They have only one stamina point per turn, but they come in large numbers. Once they can see you, they will turn red and try to eat you. They cannot attack you or detect you while you are hidden. Like most zombies, shufflers are nocturnal; however, you may still see some wandering about during the day. \n\n(They are currently the only zombie in the game, but in the future and if this game does well, there may be more.)")
            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
        }
    }
}

struct enemyView_Previews: PreviewProvider {
    static var previews: some View {
        enemyView()
    }
}
