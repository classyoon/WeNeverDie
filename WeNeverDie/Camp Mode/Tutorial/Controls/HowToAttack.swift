//
//  HowToAttack.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/6/23.
//

import SwiftUI

struct HowToAttack : View {
    var body: some View {
        VStack{
            Text("How to attack").font(.title2)
            Text("Select your unit and tap to attack.")
            Text("How to recruit").font(.title2)
            Image("SurvivorW")
            Text("You may see these people in blue shirts. You can recruit them. Select you unit and tap on them. You will need to try two times.")
        }
    }
}

struct HowToAttack_Previews: PreviewProvider {
    static var previews: some View {
        HowToAttack()
    }
}
