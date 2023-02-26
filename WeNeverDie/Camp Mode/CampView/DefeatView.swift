//
//  DefeatView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct DefeatView : View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        
        VStack{
            Text("Dead")
                .font(.title).foregroundColor(Color.black)
                .colorScheme(.dark)
            Button("Reset"){
                gameData.reset()
                
            }
        }.padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
    
}

struct DefeatView_Previews: PreviewProvider {
    static var previews: some View {
        DefeatView(gameData: ResourcePool(surviors: 0, food: 0))
    }
}
