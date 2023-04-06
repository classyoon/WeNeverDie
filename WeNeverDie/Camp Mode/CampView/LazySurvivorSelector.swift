//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct LazySurvivorSelector: View {
    @State var rowofbuttons = [buttonSelected(), buttonSelected(), buttonSelected()]
    @State var numberSelected = 0
    @State var lastTappedIndex: Int?
    
    var body: some View {
        VStack{
            Text("Numbers : \(numberSelected)")
            HStack{
                ForEach(rowofbuttons.indices, id: \.self){ index in
                    VStack{
                        Button(rowofbuttons[index].selected ? "true" : "false"){
                            if lastTappedIndex == index {
                                // Tapped the same button twice, set all buttons to the left to false
                                for i in 0...index {
                                    rowofbuttons[i] = buttonSelected(selected: false)
                                }
                                numberSelected = 0
                                lastTappedIndex = nil
                            } else {
                                // Tapped a different button, update the selection
                                numberSelected = index
                                for x in rowofbuttons.indices {
                                    if x <= numberSelected {
                                        rowofbuttons[x] = buttonSelected(selected: true)
                                    } else {
                                        rowofbuttons[x] = buttonSelected(selected: false)
                                    }
                                }
                                lastTappedIndex = index
                            }
                        }
                        Rectangle().fill(rowofbuttons[index].selected ? .green : .red)
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
    }
}

struct LazySurvivorSelector_Previews: PreviewProvider {
    static var previews: some View {
        LazySurvivorSelector()
    }
}






struct buttonSelected {
    @State var selected = false
}

