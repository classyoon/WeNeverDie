//
//  FoodCounter.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct FoodCounter: View {
    @ObservedObject var vm : Board
    var body: some View {
        Text("Food collected : \(vm.foodNew)")
            //.foregroundColor(vm.changeToNight ? .white : .black)
    }
}

struct FoodCounter_Previews: PreviewProvider {
    static var previews: some View {
        FoodCounter(vm: Board())
    }
}
