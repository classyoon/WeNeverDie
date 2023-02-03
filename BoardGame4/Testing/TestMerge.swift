//
//  TestMerge.swift
//  BoardGame4
//
//  Created by Conner Yoon on 1/20/23.
//

import SwiftUI

struct TestMerge: View {
    @Binding var vm : Board
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                vm.showBoard = true
            } label: {
                Text("Switch back?")
            }
            Button {
                vm = Board()
            } label: {
                Text("Randomize?")
            }

        }
        
    }
}

struct TestMerge_Previews: PreviewProvider {
    static var previews: some View {
//        TestMerge(vm: Board())
        ZStack{
            
        }
    }
}
