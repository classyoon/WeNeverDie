//
//  TestingChatGPT.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/11/23.
//

import SwiftUI

struct TestingChatGPT: View {
    //var vm = TutorialVM()
    var body: some View {
        ScrollView {
            tutorialView()
            CampPhaseTutorial()
            OutsidePhaseTutorial()
            goodLuckMessageView()
        }
    }
    func tutorialView() -> some View {
        Text("Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive with two friends. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n")
    }
    
    func goodLuckMessageView() -> some View {
        Text("That is all, Survivor. Good luck out there to you and your friends.")
    }
    
}


struct TestingChatGPT_Previews: PreviewProvider {
    static var previews: some View {
        TestingChatGPT()
    }
}
