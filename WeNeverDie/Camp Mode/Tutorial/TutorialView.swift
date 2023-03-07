//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI



struct TutorialView: View {
    var body: some View {
        ScrollView {
            VStack{
                introText()
                HowToMove()
                HowToAttack()
                enemyView()
                tileExplainView()
                sendOff()
            }.padding().navigationTitle("Tutorial")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}




