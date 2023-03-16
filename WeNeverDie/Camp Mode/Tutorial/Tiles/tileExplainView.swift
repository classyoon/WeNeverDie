//
//  TutorialView2.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//]

import SwiftUI


struct tileExplainView: View {
    var body: some View {
        ScrollView{
            VStack{
                grassTutorial()
                forestExplainView()
                buildingAndScavengeExplained()
                waterExplainView()
                escapeExplainView()
                
                
            }.padding()
        }
    }
}

struct TutorialView2_Previews: PreviewProvider {
    static var previews: some View {
        tileExplainView()
    }
}







