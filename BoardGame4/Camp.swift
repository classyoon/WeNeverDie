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
    @Published var foodStored = 0
    init(field : Board) {
        self.field = field
        self.SurvivorList = []
        self.foodStored = 0
    }
    func passDay(){
        if foodStored>=0{
            foodStored-=SurvivorList.count
        }
    }
    func starvationColor()->Color{
        if foodStored <= 0{
            return Color.red
        }
        return Color.black
    }
    func starvationText()->String{
        if foodStored >= 0{
            return "\(foodStored) days of food left"
        }
        return "We are starving"
    }
    
    
}
struct CampView: View {
    @Binding var showBoard : Bool
    @ObservedObject var vm : Camp
    
    var body: some View {
        VStack{
//            Text(vm.SurvivorList2[0].function?.name)
            Text(vm.starvationText()).foregroundColor(vm.starvationColor())
            //Text("People : \($vm.survivorList.count) survivors")
          

            Text("Food Stored \(vm.foodStored)")
            Button("Generate World") {
                showBoard = true
            }
        }
    }
}


struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), vm: Camp(field: Board()))
    }
}
