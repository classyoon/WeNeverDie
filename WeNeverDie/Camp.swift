//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
//class Camp : ObservableObject {
//    @Published var SurvivorList : [any Piece] = []
//    let field : Board
//
//    init(field : Board) {
//        self.field = field
//        self.SurvivorList = []
//    }
//
//
//
//
//
//}

struct CampView: View {
    
    
    @Binding var showBoard : Bool
    @ObservedObject var GameData : ResourcePool
    @State var ResetGame = false
    @State var surivorsSentOnMission : Int
    func starvationText()->String{
        if GameData.starving{
            return "We are starving"
        }
        else{
            return "Estimated left over food for \(GameData.foodResource/GameData.survivorNumber) days, (rations \(GameData.foodResource))"
        }
    }
    func starvationColor()->Color{
        if GameData.foodResource <= 0{
            return Color.red
        }
        return Color.green
    }
    func shouldShowMap() -> Bool{
        if surivorsSentOnMission > 0{
            return true
        }
        return false
    }

    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink {
                    TutorialView()
                } label: {
                    Text("Tutorial")
                }
               

               //                "Music"
                    
//                NavigationLink {
//                    Settings()
//                } label: {
//                    Text("Settings")
//                }
                
                //            Text(vm.SurvivorList2[0].function?.name)
                Text("\(GameData.days) day(s) since beginning")
                Text("Cure Progress (Keep survivors at home to progress)")
                ProgressView(value: Double(GameData.WinProgress), total: Double(GameData.WinCondition)).padding()
                Text("Survive. Get food from outside. Don't die. Make it back to camp.")
                Text(starvationText()).foregroundColor(starvationColor())
                
                Stepper(value: $surivorsSentOnMission, in: 0...GameData.survivorNumber) {
                    Text("People to send \(surivorsSentOnMission)").padding()
                }
                Text("Number of people \(GameData.survivorNumber)")
                
                HStack{
                    //                Button("Pass Day") {
                    //                    GameData.passDay()
                    //                    GameData.survivorSent = surivorsSentOnMission
                    //                }
                    Button("Proceed") {
                        GameData.passDay()
                        showBoard = shouldShowMap()
                        print(showBoard)
                        print("Sending \(GameData.survivorSent)")
                        print("Sent \(surivorsSentOnMission)")
                        GameData.survivorSent = surivorsSentOnMission
                        print(surivorsSentOnMission)
                        print("Sending \(GameData.survivorSent)")
                        GameData.victory
                    }
                }
            } .navigationTitle("Your Camp")
                .overlay{
                GameData.death ?
                VStack{
                    Text("Dead")
                        .font(.title).foregroundColor(Color.black)
                        .colorScheme(.dark)
                    Button("Reset (Does Absolutely Nothing, exit to reset)"){
                        GameData.ResetGame = true
                       
                                            }
                }.padding()
                        .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                : nil
            }
            .overlay{
                GameData.victory ?
                VStack{
                    Text("You Win!!!")
                        .font(.title)
                    Text(" You proved them all wrong. You survived and you cured the zombie virus. Hope prevails! ").font(.body)
                    //Spacer()//You go on to set the new future for the world that was seemingly brought to an end. Although you may have died many times, you never let your hope (or at least determination) die. Humanity shall never die as long as it has people like you (and your survivors) in this world.
                    HStack{
                        Button("Reset <-(Still broken)"){
                            print("Before reset \(GameData.foodResource)")
                            GameData.ResetGame = true
                            print("Attempted reset \(GameData.foodResource)")
                        }
                        Button("Continue"){
                            GameData.victory = false
                        }
                    }
                }.foregroundColor(Color.black)
                    .colorScheme(.dark).padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                : nil
            }
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission:  0)
    }
}
