//
//  CampView.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
class Camp : ObservableObject {
    @Published var SurvivorList : [any Piece] = []
    @Published var foodStored = 0
    init() {
        self.SurvivorList = []
        self.foodStored = 0
    }
    
    
}
struct CampView: View {
    @Binding var showBoard : Bool
    @ObservedObject var vm : Camp
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Generate World") {
            showBoard = true
        }
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), vm: Camp())
    }
}
