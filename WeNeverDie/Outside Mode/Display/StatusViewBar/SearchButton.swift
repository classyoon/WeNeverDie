//
//  SearchButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct SearchButton: View {
    @ObservedObject var vm : Board
    var body: some View {
        VStack(spacing: 30.0){
            Button {
                
                vm.searchLocationVM()
                
            } label: {
                Text("Search")
            }
            .foregroundColor(vm.canAnyoneMove ? .white : .red)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(vm: Board())
    }
}
