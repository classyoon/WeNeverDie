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
    func passDay(){
        GameData.passDay()
    }
    func starvationText()->String{
        if GameData.foodResource >= 0{
            return "\(GameData.foodResource) days of food left"
        }
        return "We are starving"
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
            Text(starvationText()).foregroundColor(starvationColor())
            //Text("People : \($vm.survivorList.count) survivors")
          

            Text("Food Stored \(GameData.foodResource)")
            Button("pass Day") {
                passDay()
            }
            Button("Generate World") {
                showBoard = true
            }
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(), vm: Camp(field: Board()))
    }
}
