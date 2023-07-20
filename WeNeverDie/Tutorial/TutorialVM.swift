//
//  TutorialVM.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/11/23.
//

import Foundation
import SwiftUI

//struct TutorialVM : View {
//    var intro = "Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive with two friends. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n"
//   
//    var howToDefendYourSelf = "Select your survivor by tapping on them. If your survivor has a stamina point you may attack your enemy at the cost of one stamina point. While your survivor is selected, you may attack by tapping on the enemy. You must be right next to an enemy to attack."
//    
//    var growingNumbers = "This is another survivor, who is not part of your group. You may encounter them outside your camp. You can recruit them by having your survivor approach and talk to them. You do this in the same fashion you command your survivors to attack."
//    var thisIsYourSurvivor = "You tap to select them. The white circles will indicate where they can go. The instant you tap on one of these circles your person will advance to that tile at the cost of one stamina point."
//    var howToTakeTurn = "Below each survivor, the H stands for their health, and the S stands for their number of stamina points. \n\nStamina points dictate how many actions a survivor can perform per turn. Actions such as moving, searching, and attacking will expend their stamina points. \n\nThe only way your people may replenish stamina is to tap \"Next turn,\" but be careful since that is when your enemies will move according to how many stamina points they have. Likewise, below an enemy, you can see how many stamina points and health they have."
//    var shufflerText = "Above is a Shuffler. They are a common but very weak zombie. They have only one stamina point per turn, but they come in large numbers. Once they can see you, they will turn red and try to eat you. They cannot attack you or detect you while you are hidden. Like most zombies, shufflers are nocturnal; however, you may still see some wandering about during the day. \n\n(They are currently the only zombie in the game, but in the future and if this game does well, there may be more.)"
//    func tutorialView() -> some View {
//        Text(intro)
//    }
//    func defendingYourselfView() -> some View {
//        VStack {
//            Text("Defending Yourself").font(.title)
//            Text(howToDefendYourSelf)
//            Image("SurvivorW")
//        }
//    }
//    
//    func growingYourNumbersView() -> some View {
//        VStack {
//            Text("Growing Your Numbers").font(.title)
//            Text(growingNumbers)
//        }
//    }
//    
//    func navigatingTheOutsideView() -> some View {
//        VStack {
//            Text("Navigating the Outside").font(.title)
//            Text("\nThis is one of your people. Color may vary.")
//            Image("SurvivorY").resizable().frame(width: 350, height: 200)
//            Text(thisIsYourSurvivor)
//            Image("BoardExample").resizable().frame(width: 300, height: 300)
//            Text(howToTakeTurn)
//        }
//    }
//    
//    func thoseWhoNeverDieView() -> some View {
//        VStack {
//            Text("Those Who Never Die").font(.title)
//            Text(shufflerText)
//            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
//        }
//    }
//    
//    func landAndScavengingView() -> some View {
//        VStack {
//            Text("Land & Scavenging").font(.title)
//            Image("grass").resizable().frame(width: 300, height: 300).padding()
//            Text("This is a grass field.")//try to fix
//            
//            Tile2(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
//            Text("This is a forest. It provides safety and absolute concealment from zombies.")//try to fix
//            
//            Image("building").resizable().frame(width: 300, height: 300).padding()
//            Text("This is an abandoned building, currently the only way to get food, and this is where the button \"search\" comes into play on the right side of the screen. \n\nBuildings will have a certain amount of resources in them. The only way to get the resources is for a survivor to \"search\" the place.\n\nTo search a place, select a survivor who is standing on a building tile, hit the \"search\" button to attempt to get a food resource. If there is still some left, you will collect it. Yummy!")
//            
//            Image("water").resizable().frame(width: 300, height: 300).padding()
//            Text("This is water or any kind of difficult terrain. This terrain will take two stamina points rather than one to traverse.\n")
//            escapeView()
//        }
//    }
//    func escapeView()-> some View {
//        return VStack{
//      
//            Text("This is your means of returning to camp. You will typically find it at the bottom right of the board. Get your survivors to it once you are satisfied with your haul or if things get too dicey. If none of the survivors you sent are able to return, your camp will get nothing.")
//        }
//    }
//    
//    
//    
//    func goodLuckMessageView() -> some View {
//        Text("That is all, Survivor. Good luck out there to you and your friends.")
//    }
//}
