//
//  CampView.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
class Camp : ObservableObject {
    @Published var SurvivorList : [any Piece] = []
    let field : Board
    var SurvivorList2 : [any Piece] {
        field.transferSurvivorsToCamp()
    }
    init(field : Board) {
        self.field = field
        self.SurvivorList = []
    }
    

    
    
    
}
struct CampView: View {
    
    
    @Binding var showBoard : Bool
    @ObservedObject var GameData : ResourcePool
    @ObservedObject var vm : Camp
    @State var ResetGame = false

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
        return Color.black
    }
    
    var body: some View {
        VStack{
//            Text(vm.SurvivorList2[0].function?.name)
            
            Text("Survive. Get food from outside. Don't die. Make it back to camp.")
            Text(starvationText()).foregroundColor(starvationColor())
            //Text("People : \($vm.survivorList.count) survivors")
          
//            Stepper(value: GameData.survivorNumber, in: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Range@*/1...10/*@END_MENU_TOKEN@*/) {
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("Stepper")/*@END_MENU_TOKEN@*/
//            }
           
            Text("Number of people \(GameData.survivorNumber)")
 
            HStack{
                Button("Pass Day") {
                    GameData.passDay()
                }
                Button("Generate World") {
                    showBoard = true
                }
            }
        }.overlay{
            GameData.death ?
            VStack{
                Text("Dead")
                    .font(.title)
                Button("Reset (Does Absolutely Nothing)"){
                    ResetGame = true
                }
            }.padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            : nil
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(surviors: 3, food: 10), vm: Camp(field: Board(players: 3)))
    }
}
