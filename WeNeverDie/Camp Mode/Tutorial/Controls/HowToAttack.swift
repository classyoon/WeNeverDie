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
            Text("Defending Yourself").font(.title2)
            Text("Select your survivor by tapping on them. If your survivor has a stamina point you may attack your enemy at the cost of one stamina point. While your survivor is selected, you may attack by tapping on the enemy. You must be right next to an enemy to attack.")
           
            Image("SurvivorW")
            Text("Growing Your Numbers").font(.title2)
            Text("This is another survivor, who is not part of your group. You may encounter them outside your camp. You can recruit them by having your survivor approach and talk to them. You do this in same fashion you command your survivors to attack.")
        }
    }
}

struct HowToAttack_Previews: PreviewProvider {
    static var previews: some View {
        HowToAttack()
    }
}
