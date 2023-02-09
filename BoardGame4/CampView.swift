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
    
    
}
struct CampView: View {
    @Binding var showBoard : Bool
    @ObservedObject var vm : Camp
    
    var body: some View {
        VStack{
//            Text(vm.SurvivorList2 ?? "")
            
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
